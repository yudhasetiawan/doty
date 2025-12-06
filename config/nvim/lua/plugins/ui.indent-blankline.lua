return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    --event = "VeryLazy",
    config = function()
      local hooks = require("ibl.hooks")
      local colors = require("doty.config").colors.palette

      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors.red })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors.yellow })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors.blue })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colors.orange })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors.green })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = colors.violet })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colors.cyan })
      end)

      hooks.register(hooks.type.ACTIVE, function(bufnr)
        return vim.api.nvim_buf_line_count(bufnr) < 5000
      end)

      local rainbow_hl = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      require("ibl").setup({
        enabled = true,
        indent = {
          -- Alternatives: ~
          -- • left aligned solid
          --   • `▏`
          --   • `▎` (default)
          --   • `▍`
          --   • `▌`
          --   • `▋`
          --   • `▊`
          --   • `▉`
          --   • `█`
          -- • center aligned solid
          --   • `│`
          --   • `┃`
          -- • right aligned solid
          --   • `▕`
          --   • `▐`
          -- • center aligned dashed
          --   • `╎`
          --   • `╏`
          --   • `┆`
          --   • `┇`
          --   • `┊`
          --   • `┋`
          -- • center aligned double
          --   • `║`
          char = "┊",
          -- highlight = {
          --   "Function",
          --   "Label",
          -- },
          smart_indent_cap = true,
        },
        whitespace = {
          highlight = { "CursorColumn", "Whitespace" },
          remove_blankline_trail = false,
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          injected_languages = true,
          highlight = rainbow_hl,
          priority = 500,
        },
        viewport_buffer = {
          max = 1000,
        },
        exclude = {
          filetypes = {
            "",
            "alpha",
            "checkhealth",
            "dashboard",
            "floaterm",
            "gitcommit",
            "help",
            "lazy",
            "lspinfo",
            "man",
            "NvimTree",
            "packer",
            "TelescopePrompt",
            "TelescopeResults",
            "Trouble",
          },
          buftypes = {
            "nofile",
            "prompt",
            "quickfix",
            "terminal",
          },
        },
      })
    end,
  },
}
