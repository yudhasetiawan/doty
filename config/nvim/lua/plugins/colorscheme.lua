return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local cfg = require("doty.config")
      local colors = cfg.colors

      require("tokyonight").setup({
        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        style = "moon",
        light_style = "night", -- The theme is used when the background is set to light
        -- Enable this to disable setting the background color
        transparent = vim.g.transparent_enabled,
        -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        terminal_colors = true,
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = {
            bg = "NONE",
            ctermbg = "NONE",
            ctermfg = "NONE",
            italic = true,
          },
          keywords = {
            bg = "NONE",
            ctermbg = "NONE",
            ctermfg = "NONE",
            bold = true,
          },
          functions = { bold = true },
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        -- day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        -- dim_inactive = false, -- dims inactive windows
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param clr ColorScheme
        on_colors = function(clr)
          clr.bg = colors.palette.bg
          clr.fg = colors.palette.fg
          clr.comment = colors.palette.comment

          clr.git.add = colors.palette.vcs_added
          clr.git.change = colors.palette.vcs_modified
          clr.git.delete = colors.palette.vcs_removed

          clr.blue = colors.palette.blue
          clr.cyan = colors.palette.cyan
          clr.green = colors.palette.green
          clr.magenta = colors.palette.magenta
          clr.orange = colors.palette.orange
          clr.purple = colors.palette.purple
          clr.red = colors.palette.red
          clr.yellow = colors.palette.yellow
        end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param hl Highlights
        ---@param c ColorScheme
        -- on_highlights = function(hl, c)
        --   local prompt = "#2d3149"
        --   --     -- borderless Telescope
        --   --     hl.TelescopeNormal = {bg = c.bg_dark, fg = c.fg_dark}
        --   --     hl.TelescopeBorder = {bg = c.bg_dark, fg = c.bg_dark}
        --   hl.TelescopePromptNormal = { bg = prompt }
        --   hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
        --   hl.TelescopePromptTitle = { bg = prompt, fg = prompt }
        --   hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
        --   hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        -- end
      })
    end,
  },
  {
    "Shatur/neovim-ayu",
    main = "ayu",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
      "folke/tokyonight.nvim",
    },
    config = function()
      local colors = require("doty.config").colors

      require("ayu.colors").generate(true) -- Pass `true` to enable mirage
      require("ayu").setup({
        mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
        overrides = {
          -- Base.
          ErrorMsg = { fg = colors.fg.error },
          SpellBad = { sp = colors.fg.error, undercurl = true },
          Error = { fg = colors.white, bg = colors.fg.error },
          qfError = { fg = colors.fg.error },

          -- LSP.
          DiagnosticError = { fg = colors.fg.error },
          DiagnosticUnderlineError = { sp = colors.fg.error, undercurl = true },

          -- NvimTree.
          NvimTreeGitMerge = { fg = colors.fg.error },

          -- Notify.
          NotifyERRORTitle = { fg = colors.fg.error },
          NotifyWARNTitle = { fg = colors.fg.warning },
          NotifyINFOTitle = { fg = colors.fg.info },

          -- DAP UI.
          DapUIWatchesError = { fg = colors.fg.error },
        },
      })
    end,
  },
  {
    -- making cool neovim color schemes
    "tjdevries/colorbuddy.nvim",
    main = "colorbuddy",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
      "Shatur/neovim-ayu",
    },
    config = function()
      local cfg = require("doty.config")
      local colorbuddy = require("colorbuddy")

      colorbuddy.setup()
      -- Set colorscheme after options
      colorbuddy.colorscheme(cfg.theme)
      vim.cmd.colorscheme(cfg.theme)
    end,
  },
  {
    -- automatically highlighting other uses of the word under the cursor
    "RRethy/vim-illuminate",
    main = "illuminate",
    event = "UIEnter",
    config = function()
      ---- Illumimintes --------------------------------
      require("illuminate").configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        -- delay: delay in milliseconds
        delay = 100,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          "dirvish",
          "fugitive",
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        -- See `:help mode()` for possible values
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
        -- See `:help mode()` for possible values
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = nil,
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
        -- min_count_to_highlight: minimum number of matches required to perform highlighting
        min_count_to_highlight = 1,
      })
      vim.cmd("hi def IlluminatedWordText gui=underline")
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    main = "colorizer",
    config = function()
      require("colorizer").setup({
        "*", -- Highlight all files, but customize some others.
        html = { css = true, mode = "foreground" },
        scss = { css = true },
        css = { css = true },
        javascript = { no_names = true },
      }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        -- Available modes: foreground, background
        mode = "background", -- Set the display mode.
      })
    end,
  },
  {
    "norcalli/nvim-terminal.lua",
    main = "terminal",
  },

  {
    -- Adds file type icons to Vim plugins
    "nvim-tree/nvim-web-devicons",
    -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
    -- So for api plugins like devicons, we can always set lazy=true
    lazy = true,
    opts = {
      -- your personal icons can go here (to override)
      -- you can specify color or cterm_color instead of specifying both of them
      -- DevIcon will be appended to `name`
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh",
        },
      },
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overridden by `get_icons` option
      default = true,
      -- globally enable "strict" selection of icons - icon will be looked up in
      -- different tables, first by filename, and if not found by extension; this
      -- prevents cases when file doesn't have any extension but still gets some icon
      -- because its name happened to match some extension (default to false)
      strict = true,
      -- same as `override` but specifically for overrides by filename
      -- takes effect when `strict` is true
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore",
        },
      },
      -- same as `override` but specifically for overrides by extension
      -- takes effect when `strict` is true
      override_by_extension = {
        ["log"] = {
          icon = "",
          color = "#81e043",
          name = "Log",
        },
      },
    },
  },
  -- TODO: Conditionally only do this for linux
  {
    "yamatsum/nvim-nonicons",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    lazy = true,
  },
}
