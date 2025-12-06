return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy", -- Load later and are not important for the initial UI
    opts = {
      input = {
        -- Set to false to disable the vim.ui.input implementation
        enabled = true,
        -- Default prompt string
        default_prompt = "Input",
        -- Trim trailing `:` from prompt
        trim_prompt = true,
        -- Can be 'left', 'right', or 'center'
        title_pos = "left",
        -- The initial mode when the window opens (insert|normal|visual|select).
        -- These are passed to nvim_open_win
        border = "rounded",
        -- 'editor' and 'win' will default to being centered
        relative = "cursor",

        -- Set to `false` to disable
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
        },

        override = function(conf)
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          return conf
        end,

        -- see :help dressing_get_config
        get_config = nil,
      },
      select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,
        -- Priority list of preferred vim.select implementations
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        -- Trim trailing `:` from prompt
        trim_prompt = true,

        -- Options for built-in selector
        builtin = {
          -- Display numbers for options and set up keymaps
          show_numbers = true,
          -- These are passed to nvim_open_win
          border = "rounded",
          -- 'editor' and 'win' will default to being centered
          relative = "editor",

          buf_options = {},
          win_options = {
            cursorline = true,
            cursorlineopt = "both",
            -- disable highlighting for the brackets around the numbers
            winhighlight = "MatchParen:",
            -- adds padding at the left border
            statuscolumn = " ",
          },

          -- Set to `false` to disable
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
        },
      },
    },
  },
}
