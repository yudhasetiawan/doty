return {
  {
    "rcarriga/nvim-notify",
    enabled = false,
    main = "notify",
    dependencies = {
      "yamatsum/nvim-nonicons",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local notify = require("notify")
      local cfg = require("doty.config")
      local icons = cfg.icons
      local colors = cfg.colors

      notify.setup({
        background_colour = colors.palette.bg,
        border = "none",
        icon = "<U+F835>",
        icons = {
          ERROR = icons.error,
          WARN = icons.warning,
          INFO = icons.info,
          DEBUG = icons.debug,
          TRACE = icons.trace,
        },
        -- timeout = 5000,
        -- render = "wrapped-compact",
        -- stages = "fade_in_slide_out",
        top_down = false,
        level = vim.log.levels.DEBUG,
        minimum_width = 50,
        max_width = 50,
        max_height = 40,
      })
      vim.notify = notify
    end,
  },
}
