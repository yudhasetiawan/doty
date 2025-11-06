return {
  {
    "kevinhwang91/nvim-ufo", -- Enable folds with nvim-ufo
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require("doty.plugins.nvim-ufo")
    end,
  },
  {
    "nvim-lua/lsp-status.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("doty.plugins.lsp-status")
    end,
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      return require("doty.plugins.nvim-navic")
    end,
  },
  {
    --
    "williamboman/mason.nvim",
    dependencies = {
      -- "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("doty.plugins.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("doty.plugins.mason-lspconfig")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --   "hrsh7th/nvim-cmp",
    -- },
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("doty.plugins.nvim-lspconfig")
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("doty.plugins.nvim-lspconfig-conform")
    end,
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
    config = function()
      require("mason-conform").setup({
        -- List of formatters to ignore during install
        ignore_install = {
          -- "prettier",
          -- "helm_ls",
          -- "yq",
        },
      })
    end,
  },

  -- JSON -------------------------------------------------------------
  {
    "b0o/SchemaStore.nvim",
    init = function()
      -- This plugin provides JSON schemas for LSP
      -- Useful for validating configuration files
    end,
  },
  -- END ---

  -- Helm -------------------------------------------------------------
  -- towolf/vim-helm provides basic syntax highlighting and filetype detection
  -- ft = "helm" is important to not start yamlls
  {
    "towolf/vim-helm",
    ft = "helm",
    init = function()
      -- Syntax highlighting for Helm templates
      -- Only loads when Helm files are opened
    end,
  },
  -- END ---

  -- Markdown ---------------------------------------------------------
  -- {
  --   "sotte/presenting.nvim",
  --   -- cmd = { "Presenting" },
  -- },
  -- -- install without yarn or npm
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   build = function() vim.fn["mkdp#util#install"]() end,
  --   -- install with yarn or npm
  --   -- build = "cd app && yarn install",
  -- },
  -- END ---

  -- Golang -----------------------------------------------------------
  -- "fatih/vim-go",
  -- "tjdevries/green_light.nvim", -- go test in nvim
  -- "buoto/gotests-vim",          -- generate test suite
  -- {
  --     "ray-x/go.nvim",
  --     event = {"CmdlineEnter"},
  --     ft = {"go", "gomod"},
  --     build = ":lua require("go.install").update_all_sync()", -- if you need to install/update all binaries
  --     dependencies = { -- optional packages
  --         "ray-x/guihua.lua", "neovim/nvim-lspconfig",
  --         "nvim-treesitter/nvim-treesitter"
  --     },
  --     config = function() require("doty.plugins.go") end
  -- },
  -- END ---
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({
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
          -- "gopls",
          "pylsp",
          "rust-analyzer",
          -- Formatters & linters
          "stylua",
          "prettier",
          "eslint_d",
          "shellcheck",
          "shfmt",
          "golangci-lint",
          -- "gofumpt",
          -- "goimports",
          "yamllint",
          "flake8",
          -- DAP debuggers
          "codelldb",
        },
      })
    end,
  },
  -- Linters: { "jose-elias-alvarez/null-ls.nvim" } or { "mfussenegger/nvim-lint" }
  {
    "nvimtools/none-ls.nvim",
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("doty.plugins.mason-null-ls")
    end,
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   main = "lint",
  --   config = function()
  --     require("doty.plugins.nvim-lint")
  --   end,
  -- },
  -- Formatters: { "jose-elias-alvarez/null-ls.nvim" } or { "mhartington/formatter.nvim" }
  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim" },
  --     { "nvim-treesitter/nvim-treesitter" }
  --   },
  -- },
}
