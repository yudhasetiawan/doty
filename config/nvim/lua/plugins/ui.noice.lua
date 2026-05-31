return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local cfg = require("doty.config")
      local icons = cfg.icons

      return {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
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
        -- Configure the looks of the notification view
        views = {
          mini = {
            zindex = 100,
            win_options = { winblend = 0 },
          },
          notify = {
            timeout = 5000,
            align = "right",
            icons = {
              ERROR = icons.error,
              WARN = icons.warning,
              INFO = icons.info,
              DEBUG = icons.debug,
              TRACE = icons.trace,
            },
          },
        },
        cmdline = {
          format = {
            search_down = { icon = " " },
            search_up = { icon = " " },
          },
        },
        -- Use Neovim's built-in notifications instead of nvim-notify
        notify = {
          enabled = true,
          view = "notify",
        },
      }
    end
  }
}
