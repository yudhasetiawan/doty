local cfg = require("doty.config")
local icons = cfg.icons
local colors = cfg.colors

require("notify").setup({
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
  timeout = 5000,
  render = "default",
  stages = "fade_in_slide_out",
  on_open = nil,
  on_close = nil,
  level = "info",
  minimum_width = 50,
})

vim.notify = require("notify")

