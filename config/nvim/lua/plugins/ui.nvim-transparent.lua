return {
  {
    -- Remove all background colors to make nvim transparent
    "xiyaowong/nvim-transparent",
    main = "transparent",
    opts = {
      -- table: default groups
      groups = {
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLine",
        "CursorLineNr",
        "StatusLine",
        "StatusLineNC",
        "EndOfBuffer",
      },
      -- table: additional groups that should be cleared
      extra_groups = { "Comment" },
      -- table: groups you don't want to clear
      exclude_groups = {
        "Notify",
      },
      -- function: code to be executed after highlight groups are cleared
      -- Also the user event "TransparentClear" will be triggered
      -- on_clear = function() end,
    },
    config = function(_, opts)
      local transparent = require("transparent")

      transparent.setup(opts)

      -- transparent.clear_prefix("lualine")
      transparent.toggle(true)

      -- Add additional highlight groups by explicitly assigning the variable `g:transparent_groups`.
      -- Here is an example about [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim).
      -- vim.g.transparent_groups = vim.list_extend(
      --   vim.g.transparent_groups or {},
      --   vim.tbl_map(function(v)
      --     return v.hl_group
      --   end, vim.tbl_values(require('bufferline.config').highlights))
      -- )
    end,
  },
}
