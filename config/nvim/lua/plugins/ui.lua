-- UI and visual enhancement plugins
return {
  {
    "f-person/lua-timeago",
    lazy = true,
    config = function()
      local lang = require("lua-timeago/languages/en")
      local id = {
        justnow = "baru saja",
        minute = {
          singular = "beberapa menit yang lalu",
          plural = "menit yang lalu",
        },
        hour = { singular = "beberapa jam yang lalu", plural = "jam yang lalu" },
        day = {
          singular = "beberapa hari yang lalu",
          plural = "hari yang lalu",
        },
        week = {
          singular = "beberapa minggu yang lalu",
          plural = "minggu yang lalu",
        },
        month = {
          singular = "beberapa bulan yang lalu",
          plural = "bulan yang lalu",
        },
        year = {
          singular = "beberapa tahun yang lalu",
          plural = "tahun yang lalu",
        },
      }
      require("lua-timeago").set_language(lang)
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
      }
    end,
  },
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
}
