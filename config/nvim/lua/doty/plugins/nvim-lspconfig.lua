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

lspconfig.util.on_setup = lspconfig.util.add_hook_after(
  lspconfig.util.on_setup,
  function(config, user_config)
    if config.name == "lua_ls" then
      -- workaround for nvim's incorrect handling of scopes in the workspace/configuration handler
      -- https://github.com/folke/neodev.nvim/issues/41
      -- https://github.com/LuaLS/lua-language-server/issues/1089
      -- https://github.com/LuaLS/lua-language-server/issues/1596
      -- https://github.com/LuaLS/lua-language-server/issues/1596#issuecomment-1855087288
      config.handlers = vim.tbl_extend("error", {}, config.handlers)
      config.handlers["workspace/configuration"] = function(...)
        local _, result, ctx = ...
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

        return vim.lsp.handlers["workspace/configuration"](...)
      end
    end
  end
)

masonlspconfig.setup_handlers({
  lsp_zero.default_setup,
  -- setup Ansible
  lspconfig.ansiblels.setup({
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
  }),

  -- setup Shell scripts
  lspconfig.bashls.setup({
    settings = {
      bashIde = {
        globPattern = "*@(.sh|.zsh|.inc|.bash|.command)",
      },
    },
  }),

  -- setup Golang
  lspconfig.gopls.setup({
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
  }),

  -- setup Helm
  lspconfig.helm_ls.setup({
    settings = {
      ["helm-ls"] = {
        yamlls = { path = "yaml-language-server" },
      },
    },
  }),

  -- Setup JavaScript, TypeScript
  lspconfig.ts_ls.setup({}),

  -- Setup JSON
  lspconfig.jsonls.setup({
    capabilities = capabilitiesSnippet,
    settings = {
      json = {
        schema = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  }),

  lspconfig.jsonnet_ls.setup({
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
  }),

  -- Setup Lua
  lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls({
    -- on_init = function(client)
    --   if client.workspace_folders then
    --     local path = client.workspace_folders[1].name
    --     if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
    --       return
    --     end
    --   end

    --   client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
    --     runtime = {
    --       -- Tell the language server which version of Lua you're using
    --       -- (most likely LuaJIT in the case of Neovim)
    --       version = 'LuaJIT'
    --     },
    --     -- Make the server aware of Neovim runtime files
    --     workspace = {
    --       checkThirdParty = false,
    --       -- Pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
    --       library = vim.api.nvim_get_runtime_file("", true)
    --     }
    --   })
    -- end,
    -- Setup lua_ls and enable call snippets
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })),

  -- Setup Python
  lspconfig.pylsp.setup({
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
  }),

  -- Setup Rust
  lspconfig.rust_analyzer.setup({
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
  }),

  -- Setup Terraform
  lspconfig.terraformls.setup({
    root_dir = lspconfig.util.root_pattern(
      "*.tf",
      "*.terraform",
      "*.tfvars",
      ".terraform",
      ".git"
    ),
  }),

  -- Setup YAML
  lspconfig.yamlls.setup({
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
  }),

  -- lspconfig.postgres_lsp.setup { },

  -- lspconfig.robotframework_ls.setup {
  --   pythonpath = os.getenv("PYENV_ROOT") .. "/shims/python"
  -- },

  -- lspconfig.pyls_ms.setup {
  --   handlers = lsp_status.extensions.pyls_ms.setup(),
  --   settings = {
  --     python = {
  --       workspaceSymbols = { enabled = true },
  --     },
  --   },
  -- },

  -- lspconfig.pyright.setup {},
  -- lspconfig.clangd.setup {
  --   handlers = lsp_status.extensions.clangd.setup(),
  --   init_options = {
  --     clangdFileStatus = true
  --   },
  -- },
})
