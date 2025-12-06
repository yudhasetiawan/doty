return {

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
  --     config = function()
  --       vim.g.go_addtags_transform = "camelcase"
  --     end
  -- },
  -- END ---
  -- Linters: { "jose-elias-alvarez/null-ls.nvim" } or { "mfussenegger/nvim-lint" }
  {
    "nvimtools/none-ls.nvim",
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   main = "lint",
  --   config = function()
  --     require("lint").linters_by_ft = {
  --       ["*"] = { "codespell", "gitlint", "staticcheck", "typos" },
  --       ansible = { "ansible_lint" },
  --       bash = { "bash", "shellcheck" },
  --       clojure = { "clj-kondo" },
  --       dockerfile = { "hadolint" },
  --       dotenv = { "dotenv_linter" },
  --       editorconfig = { "editorconfig-checker" },
  --       gitcommit = { "commitlint" },
  --       go = { "golangcilint" },
  --       inko = { "inko" },
  --       janet = { "janet" },
  --       jq = { "jq" },
  --       json = { "jsonlint" },
  --       lua = { "luacheck" },
  --       make = { "checkmake" },
  --       markdown = { "vale" },
  --       python = { "ruff", "mypy" },
  --       rst = { "vale" },
  --       ruby = { "ruby" },
  --       rust = { "clippy" },
  --       sh = { "shellcheck" },
  --       terraform = { "tflint", "terraform_validate" },
  --       text = { "vale" },
  --       tf = { "terraform_validate", "tflint", "tfsec" },
  --       yaml = { "yamllint" },
  --       yq = { "yq" },
  --       zsh = { "zsh" },
  --     }
  --
  --     vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  --       callback = function()
  --         local lint = require("lint")
  --         local names = lint._resolve_linter_by_ft(vim.bo.filetype)
  --         for _, linter in pairs(lint.linters_by_ft["*"]) do
  --           table.insert(names, linter)
  --         end

  --         -- try_lint without arguments runs the linters defined in `linters_by_ft`
  --         -- for the current filetype
  --         require("lint").try_lint(names)
  --       end,
  --     })
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
