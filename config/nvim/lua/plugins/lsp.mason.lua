return {
  {
    "williamboman/mason.nvim",
    opts = function()
      local icons = require("doty.config").icons

      return {
        -- Where Mason should put its bin location in your PATH
        PATH = "prepend",

        -- Controls to which degree logs are written to the log file
        log_level = vim.log.levels.WARN,

        ui = {
          -- Whether to automatically check for new versions when opening the :Mason window
          check_outdated_packages_on_open = true,

          -- The border to use for the UI window
          border = "rounded",

          width = 0.8,
          height = 0.9,

          icons = {
            package_installed = icons.status.success,
            package_pending = icons.status.pending,
            package_uninstalled = icons.status.failure,
          },

          keymaps = {
            toggle_package_expand = "<Tab>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "d",
            cancel_installation = "<C-c>",
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
      -- Automatically enable installed servers
      automatic_enable = true,
      -- List of servers to automatically install
      ensure_installed = {
        "lua_ls",
        "gopls", 
        "rust_analyzer",
        "pylsp",
        "bashls",
        "yamlls",
        "jsonls",
        "terraformls",
        "helm_ls",
        "ansiblels",
      },
      -- Automatically install servers set up via lspconfig
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
      ensure_installed = {
        -- Formatters needed for LSP servers that use external tools
        "stylua",
        "prettierd",
        "prettier",
        "shellcheck",
        "shfmt",
        "gofumpt",
        "goimports",
        "taplo",
        "black",
        "ruff",
        "eslint_d",
        "yamlfmt",
        "yamllint",
        "jq",
      },
    },
  },
}
