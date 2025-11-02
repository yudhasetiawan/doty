local lsp_status = require("lsp-status")
local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local masonlspconfig = require("mason-lspconfig")
--Enable (broadcasting) snippet capability for completion
local capabilitiesSnippet = vim.lsp.protocol.make_client_capabilities()
capabilitiesSnippet.textDocument.completion.completionItem.snippetSupport = true

-- Set up default language servers capabilities.
lsp_zero.extend_lspconfig()

-- Register the progress handler
lsp_status.register_progress()

-- Setup Mason-lspconfig with default handler
masonlspconfig.setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
    
    -- setup Ansible
    ["ansiblels"] = function(server_config)
      require("lspconfig").ansiblels.setup(vim.tbl_deep_extend("force", server_config, {
        settings = {
          ansible = {
            executionEnvironment = {
              enabled = true,
            },
            validation = {
              enabled = true,
              lint = {
                enabled = true,
              },
            },
          },
        },
      }))
    end,

    -- setup Shell scripts
    ["bashls"] = function(server_config)
      require("lspconfig").bashls.setup(vim.tbl_deep_extend("force", server_config, {
        settings = {
          bashIde = {
            globPattern = "*@(.sh|.zsh|.inc|.bash|.command)",
          },
        },
      }))
    end,

    -- setup Golang
    ["gopls"] = function(server_config)
      require("lspconfig").gopls.setup(vim.tbl_deep_extend("force", server_config, {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = {
              "-.git",
              "-.vscode",
              "-.idea",
              "-.vscode-test",
              "-node_modules",
            },
          },
        },
      }))
    end,

    -- setup Helm
    ["helm_ls"] = function(server_config)
      require("lspconfig").helm_ls.setup(vim.tbl_deep_extend("force", server_config, {
        settings = {
          ["helm-ls"] = {
            yamlls = { path = "yaml-language-server" },
          },
        },
      }))
    end,

    -- Setup JavaScript, TypeScript
    ["ts_ls"] = function(server_config)
      require("lspconfig").ts_ls.setup(server_config)
    end,

    -- Setup JSON
    ["jsonls"] = function(server_config)
      require("lspconfig").jsonls.setup(vim.tbl_deep_extend("force", server_config, {
        capabilities = capabilitiesSnippet,
        settings = {
          json = {
            schema = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      }))
    end,

    ["jsonnet_ls"] = function(server_config)
      require("lspconfig").jsonnet_ls.setup(vim.tbl_deep_extend("force", server_config, {
        settings = {
          formatting = {
            -- default values
            Indent = 2,
            MaxBlankLines = 2,
            StringStyle = "single",
            CommentStyle = "slash",
            PrettyFieldNames = true,
            PadArrays = false,
            PadObjects = true,
            SortImports = true,
            UseImplicitPlus = true,
            StripEverything = false,
            StripComments = false,
            StripAllButComments = false,
          },
        },
      }))
    end,

    -- Setup Lua
    ["lua_ls"] = function(server_config)
      -- Add workaround for nvim's incorrect handling of scopes in the workspace/configuration handler
      local on_init = server_config.on_init
      server_config.on_init = function(client, result)
        -- Apply any existing on_init function
        if on_init then
          on_init(client, result)
        end
        
        -- Set up the workspace configuration handler if lua_ls
        if client.name == "lua_ls" then
          client.handlers = vim.tbl_extend("error", {}, client.handlers)
          client.handlers["workspace/configuration"] = function(_, result, ctx)
            local client_id = ctx.client_id
            local client = vim.lsp.get_client_by_id(client_id)
            if
                client
                and client.workspace_folders
                and #client.workspace_folders
            then
              if result.items and #result.items > 0 then
                if not result.items[1].scopeUri then
                  return vim.tbl_map(function(_)
                    return nil
                  end, result.items)
                end
              end
            end

            return vim.lsp.handlers["workspace/configuration"](_, result, ctx)
          end
        end
      end

      require("lspconfig").lua_ls.setup(vim.tbl_deep_extend("force", server_config, lsp_zero.nvim_lua_ls({
        -- Setup lua_ls and enable call snippets
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })))
    end,

    -- Setup Python
    ["pylsp"] = function(server_config)
      require("lspconfig").pylsp.setup(vim.tbl_deep_extend("force", server_config, {
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = { "W391", "E501" },
                maxLineLength = 120,
              },
            },
          },
        },
      }))
    end,

    -- Setup Rust
    ["rust_analyzer"] = function(server_config)
      require("lspconfig").rust_analyzer.setup(vim.tbl_deep_extend("force", server_config, {
        -- Server-specific settings. See `:help lspconfig-setup`
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            diagnostics = {
              enable = true,
            },
            lens = {
              enable = true,
            },
            -- Add clippy lints for Rust.
            check = {
              enable = true,
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      }))
    end,

    -- Setup Terraform
    ["terraformls"] = function(server_config)
      require("lspconfig").terraformls.setup(vim.tbl_deep_extend("force", server_config, {
        root_dir = lspconfig.util.root_pattern(
          "*.tf",
          "*.terraform",
          "*.tfvars",
          ".terraform",
          ".git"
        ),
      }))
    end,

    -- Setup YAML
    ["yamlls"] = function(server_config)
      require("lspconfig").yamlls.setup(vim.tbl_deep_extend("force", server_config, {
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require("schemastore").yaml.schemas({
              extra = {
                -- Currently, kubernetes is special-cased in yammls, see the following upstream issues:
                -- * [#211](https://github.com/redhat-developer/yaml-language-server/issues/211).
                -- * [#307](https://github.com/redhat-developer/yaml-language-server/issues/307).
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.k8s.yaml",
                  name = "kubernetes.json",
                  url =
                  "https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json",
                },
              },
            }),
          },
        },
      }))
    end,
  }
})
