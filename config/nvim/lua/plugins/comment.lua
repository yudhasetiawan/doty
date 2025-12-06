return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    enabled = true,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- TODO: Find out where is the keymap come from?
      -- vim.keymap.del({'n', 'x'}, 'gc')

      require("Comment").setup({
        ---Add a space b/w comment and the line
        padding = true,

        -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
        mappings = {
          -- operator-pending mapping
          -- Includes:
          --  `gcc`               -> line-comment  the current line
          --  `gcb`               -> block-comment the current line
          --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
          --  `gb[count]{motion}` -> block-comment the region contained in {motion}
          basic = true,

          -- extra mapping
          -- Includes `gco`, `gcO`, `gcA`
          extra = true,
        },

        -- LHS of operator-mode mappings in NORMAL and VISUAL mode
        opleader = {
          -- line-comment keymap
          line = "gc",
          -- block-comment keymap
          block = "gb",
        },

        -- LHS of toggle mappings in NORMAL
        toggler = {
          -- line-comment keymap
          -- Makes sense to be related to your opleader.line
          line = "gcc",

          -- block-comment keymap
          -- Make sense to be related to your opleader.block
          block = "gbc",
        },

        -- LHS of extra mappings
        extra = {
          -- Inserts comment above
          above = "gcO",
          -- Inserts comment below
          below = "gco",
          -- Inserts comment at the end of line
          eol = "gcA",
        },

        -- Pre-hook, called before commenting the line
        --    Can be used to determine the commentstring value
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),

        -- Post-hook, called after commenting is done
        --    Can be used to alter any formatting / newlines / etc. after commenting
        -- post_hook = nil,

        -- Can be used to ignore certain lines when doing linewise motions.
        -- - Can be string (lua regex)
        -- - Or function (that returns lua regex)
        -- ignore = function()
        --   -- Only ignore empty lines for lua files
        --   if vim.bo.filetype == 'lua' then
        --     return '^$'
        --   end

        --   return '^$'
        -- end,
      })

      local comment = require("Comment.ft")

      comment
        .set("lua", { "--%s", "--[[%s]]" })
        -- Set only line comment
        .set("yaml", "#%s")
        -- Or set both line and block commentstring
        .set("javascript", { "//%s", "/*%s*/" })

      -- Multiple filetypes
      comment({ "go", "rust" }, comment.get("c"))
      comment({ "toml", "graphql" }, "#%s")

      vim.g.minicomment_disable = true
    end,
  },
  {
    "folke/todo-comments.nvim", -- highlight comments
    opts = function()
      local cfg = require("doty.config")
      local icons = cfg.icons
      local colors = cfg.colors

      return {
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = icons.fix .. " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = icons.todo .. " ", color = "info" },
          HACK = { icon = icons.hack .. " ", color = "warning" },
          WARN = {
            icon = icons.warning .. " ",
            color = "warning",
            alt = { "WARN", "WARNING", "XXX" },
          },
          PERF = {
            icon = icons.performance .. " ",
            alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
          },
          NOTE = {
            icon = icons.info .. " ",
            color = "hint",
            alt = { "HINT", "INFO" },
          },
          TEST = {
            icon = icons.test .. " ",
            color = "test",
            alt = { "TESTING", "PASSED", "FAILED" },
          },
        },
        gui_style = {
          fg = "BOLD", -- The gui style to use for the fg highlight group.
          bg = "NONE", -- The gui style to use for the bg highlight group.
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          multiline = true, -- enable multiline todo comments
          multiline_pattern = "^(\\s+)?\\-", -- lua pattern to match the next multiline from the start of the matched keyword
          multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
          before = "", -- "fg" or "bg" or empty
          keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
          after = "fg", -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of highlight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", colors.fg.error },
          warning = { "DiagnosticWarn", "WarningMsg", colors.fg.warning },
          info = { "DiagnosticInfo", colors.fg.info },
          hint = { "DiagnosticHint", colors.fg.hint },
          default = { "Identifier", colors.fg.unknown_title },
          test = { "Identifier", colors.fg.test },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      }
    end,
  },
}
