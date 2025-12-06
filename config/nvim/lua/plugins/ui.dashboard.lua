return {
  {
    "glepnir/dashboard-nvim",
    main = "dashboard",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      local icons = require("doty.config").icons

      return {
        theme = "hyper", --  theme is doom and hyper default is hyper
        disable_move = true, --  default is false disable move keymap for hyper
        shortcut_type = "number", --  shortcut type "letter" or "number"
        -- change_to_vcs_root = true, -- default is false,for open file in hyper mru. it will change to the root of vcs
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            {
              desc = "󰊳 Update",
              group = "@property",
              action = "Lazy update",
              key = "u",
            },
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Files",
              group = "Label",
              action = "Telescope find_files",
              key = "f",
            },
            {
              desc = " Apps",
              group = "DiagnosticHint",
              action = "Telescope app",
              key = "a",
            },
            {
              desc = " Dotfiles",
              group = "Number",
              action = "Telescope dotfiles",
              key = "d",
            },
          },
          packages = { enable = true }, -- show how many plugins neovim loaded
          -- limit how many projects list, action when you press key or enter it will run this action.
          -- action can be a function type, e.g.
          -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
          mru = {
            enable = true,
            limit = 10,
            icon = icons.folder.symlink .. " ",
            label = "Most Recent Files",
            cwd_only = false,
          },
          project = {
            enable = true,
            limit = 20,
            icon = icons.package .. " ",
            label = "Projects:",
            action = "Telescope find_files cwd=",
          },
        },
        hide = {
          -- this is expected to be 'disabled' by some but NOT ALL
          enabled = true,
          filetype = { "alpha", "dashboard", "startup", "snacks_dashboard" },
          buftype = {
            "terminal",
            "help",
            "alpha",
            "dashboard",
            "startup",
            "snacks_dashboard",
          },
        },
      }
    end,
  },
}
