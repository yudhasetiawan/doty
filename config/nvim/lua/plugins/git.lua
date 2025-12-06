return {
  {
    -- Git blamme
    "f-person/git-blame.nvim",
    main = "gitblame",
    lazy = true,
    dependencies = {
      "f-person/lua-timeago",
    },
    opts = {
      enabled = true, -- If you want to enable the plugin
      message_template = " <author>  <date>  <summary>",
      date_format = "%r", -- Template for the date, check Date format section for more options
      -- virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
      message_when_not_committed = "  Not Committed Yet",
      highlight_group = "Comment",
      clipboard_register = "+",
    },
  },
  "rhysd/committia.vim", -- Sweet commit messages
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
      vim.g.lazygit_floating_window_border_chars =
        "['╭','─', '╮', '│', '╯','─', '╰', '│']" -- customize lazygit popup window border characters
      vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
      vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
      vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
      vim.g.lazygit_config_file_path = "" -- custom config file path
    end,
  },
}
