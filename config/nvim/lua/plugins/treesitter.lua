return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("doty.plugins.nvim-treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = true,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    main = "treesitter-context",
    opts = {
      enable = true, -- Enable this plugin
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor",  -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursor
      separator = nil,
      zindex = 20, -- The Z-index of the context window
    }
  },

  {
    "bennypowers/nvim-regexplainer",
    main = "regexplainer",
    ft = "regex", -- Only load when in a regex file
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "mfussenegger/nvim-ts-hint-textobject",
    event = "VeryLazy",
    config = function()
      vim.cmd([[omap     <silent> m :<C-U>lua require("tsht").nodes()<CR>]])
      vim.cmd([[vnoremap <silent> m :lua require("tsht").nodes()<CR>]])
    end,
  },
  -- { dir = "~/plugins/tree-sitter-lua" },
  -- "nvim-treesitter/playground",
  -- "vigoux/architext.nvim",
}
