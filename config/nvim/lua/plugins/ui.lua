-- UI and visual enhancement plugins
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "yamatsum/nvim-nonicons",
      "nvim-tree/nvim-web-devicons",
      "f-person/git-blame.nvim",
      "tjdevries/colorbuddy.nvim",
      "folke/trouble.nvim",
    },
    opts = function()
      return require("doty.plugins.lualine")
    end,
  },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
      "tjdevries/colorbuddy.nvim",
    },
    config = function()
      require("doty.plugins.barbecue")
    end,
  },
  {
    "rcarriga/nvim-notify",
    main = "notify",
    event = "VeryLazy",
    dependencies = {
      "yamatsum/nvim-nonicons",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      return require("doty.plugins.nvim-notify")
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      return require("doty.plugins.noice")
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy", -- Load later and are not important for the initial UI
    config = function()
      return require("doty.plugins.dressing")
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      return require("doty.plugins.trouble")
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      return require("doty.plugins.nvim-navbuddy")
    end,
  },
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
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
      require("doty.plugins.fidget")
    end,
  },
  {
    "glepnir/dashboard-nvim",
    main = "dashboard",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VimEnter",
    config = function()
      return require("doty.plugins.dashboard")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = function()
      return require("doty.plugins.indent-blankline")
    end,
  },
  {
    -- Remove all background colors to make nvim transparent
    "xiyaowong/nvim-transparent",
    main = "transparent",
    config = function()
      require("doty.plugins.nvim-transparent")
    end,
  },
  {
    "folke/twilight.nvim",
    dependencies = {
      "folke/zen-mode.nvim",
    },
    event = "VeryLazy",
    config = function()
      return require("doty.plugins.twilight")
    end,
  },
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    opts = function()
      return require("doty.plugins.zen-mode")
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
