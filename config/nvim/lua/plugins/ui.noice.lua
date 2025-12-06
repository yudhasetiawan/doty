return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      messages = { view_search = false },
      routes = {
        {
          filter = { event = "msg_show", find = "%d+L, %d+B" },
          view = "mini",
        },
        {
          filter = { event = "msg_show", find = "Hunk %d+ of %d+" },
          view = "mini",
        },
        {
          filter = { event = "msg_show", find = "%d+ more lines" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", find = "%d+ lines yanked" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", kind = "quickfix" },
          view = "mini",
        },
        {
          filter = { event = "msg_show", kind = "search_count" },
          view = "mini",
        },
        {
          filter = { event = "msg_show", kind = "wmsg" },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      commands = {
        all = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      },
      views = {
        mini = {
          zindex = 100,
          win_options = { winblend = 0 },
        },
      },
    },
  },
}
