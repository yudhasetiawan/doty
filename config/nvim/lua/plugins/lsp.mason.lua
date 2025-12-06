return {
  {
    --
    "williamboman/mason.nvim",
    opts = function()
      local icons = require("doty.config").icons

      return {
        -- The directory in which to install packages.
        -- install_root_dir = vim.fn.stdpath("data").."/mason",

        -- Where Mason should put its bin location in your PATH. Can be one of:
        -- - "prepend" (default, Mason's bin location is put first in PATH)
        -- - "append" (Mason's bin location is put at the end of PATH)
        -- - "skip" (doesn't modify PATH)
        ---@type '"prepend"' | '"append"' | '"skip"'
        PATH = "prepend",

        -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
        -- debugging issues with package installations.
        log_level = vim.log.levels.DEBUG,

        ui = {
          -- Whether to automatically check for new versions when opening the :Mason window.
          check_outdated_packages_on_open = true,

          -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
          border = "rounded",

          -- Width of the window. Accepts:
          -- - Integer greater than 1 for fixed width.
          -- - Float in the range of 0-1 for a percentage of screen width.
          width = 0.8,
          -- Height of the window. Accepts:
          -- - Integer greater than 1 for fixed height.
          -- - Float in the range of 0-1 for a percentage of screen height.
          height = 0.9,

          icons = {
            -- The list icon to use for installed packages.
            package_installed = icons.status.success,
            -- The list icon to use for packages that are installing, or queued for installation.
            package_pending = icons.status.pending,
            -- The list icon to use for packages that are not installed.
            package_uninstalled = icons.status.failure,
          },

          keymaps = {
            -- Keymap to expand a package
            toggle_package_expand = "<Tab>",
            -- Keymap to install the package under the current cursor position
            install_package = "i",
            -- Keymap to reinstall/update the package under the current cursor position
            update_package = "u",
            -- Keymap to check for new version for the package under the current cursor position
            check_package_version = "c",
            -- Keymap to update all installed packages
            update_all_packages = "U",
            -- Keymap to check which installed packages are outdated
            check_outdated_packages = "C",
            -- Keymap to uninstall a package
            uninstall_package = "d",
            -- Keymap to cancel a package installation
            cancel_installation = "<C-c>",
            -- Keymap to apply language filter
            apply_language_filter = "<C-f>",
            -- Keymap to toggle viewing package installation log
            toggle_package_install_log = "<Tab>",
            -- Keymap to toggle the help view
            toggle_help = "<C-h>",
          },
        },
      }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- Automatically enable (vim.lsp.enable()) installed servers.
      automatic_enable = true,
      -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
      -- This setting has no relation with the `automatic_installation` setting.
      ---@type string[]
      ensure_installed = {
        -- Diagnostic (general purpose server)
        "typos_lsp",
        "diagnosticls",

        -- Ansible
        "ansiblels",

        -- Bash
        "bashls",
        "awk_ls",

        -- Docker, Docker compose
        "dockerls",
        "docker_compose_language_service",

        -- Dot files
        "dotls",
        "harper_ls",

        -- Git
        "gitlab_ci_ls",
        "golangci_lint_ls",

        -- Go
        "gopls",
        "templ",
        -- Helm Chart
        "helm_ls",

        -- JavaScript, TypeScript
        "ts_ls",
        "eslint",
        "tsp_server",

        -- JSON, Jsonnet, jq
        "jsonls",
        "jsonnet_ls",
        "jqls",

        -- Lua
        "lua_ls",

        -- Markdown
        "marksman",

        -- Nginx
        "nginx_language_server",

        -- OpenAPI
        "vacuum",

        -- Python
        "pylsp",
        -- Rust
        "rust_analyzer",

        -- SQL
        "sqls",

        -- Terraform
        "terraformls",
        "tflint",

        -- TOML
        "taplo",

        -- VimScript
        "vimls",

        -- YAML, yq
        "yamlls",
      },

      -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Servers are not automatically installed.
      --   - true: All servers set up via lspconfig are automatically installed.
      --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
      ---@type boolean
      automatic_installation = true,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      auto_update = true,
      debounce_hours = 24,
      ensure_installed = {
        -- LSP servers
        "bash-language-server",
        "lua-language-server",
        "typescript-language-server",
        "eslint-lsp",
        "jsonls",
        "yamlls",
        "dockerls",
        "terraformls",
        "gopls",
        "pylsp",
        "rust-analyzer",
        -- Formatters & linters
        "stylua",
        "prettier",
        "eslint_d",
        "shellcheck",
        "shfmt",
        "golangci-lint",
        "gofumpt",
        "goimports",
        "yamllint",
        "flake8",
        -- DAP debuggers
        "codelldb",
      },
    },
  },
  {
    "zapling/mason-conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "stevearc/conform.nvim",
    },
    -- init = function()
    --   -- Conform also provides a formatexpr, same as the LSP client.
    --   -- If you want the formatexpr, here is the place to set it.
    --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    -- end,
    opts = {
      -- List of formatters to ignore during install
      ignore_install = {
        -- "prettier",
        -- "helm_ls",
        -- "yq",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = {
        "ansiblelint",
        "checkmake",
        "codespell",
        "commitlint",
        "dotenv_linter",
        "editorconfig_checker",
        "golangci_lint",
        "hadolint",
        "jq",
        "luacheck",
        "misspell",
        "semgrep",
        "sqruff",
        "staticcheck",
        "stylua",
        "systemdlint",
        "terraform_validate",
        "textlint",
        "tfsec",
        "vacuum",
        "vale",
        "write_good",
        "yamllint",
        "zsh",
      },
      -- Enable or disable null-ls methods to get set up
      -- This setting is useful if some functionality is handled by other plugins such as `conform` and `nvim-lint`
      methods = {
        diagnostics = true,
        formatting = true,
        code_actions = true,
        completion = true,
        hover = true,
      },
      -- Run `require("null-ls").setup`.
      -- Will automatically install masons tools based on selected sources in `null-ls`.
      -- Can also be an exclusion list.
      -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
      automatic_installation = true,
      -- See [#handlers-usage](#handlers-usage) section
      handlers = nil,
    },
  },
}
