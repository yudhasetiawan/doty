return {
  {
    "onsails/lspkind-nvim",
    main = "lspkind",
    config = function()
      local icons = require("doty.config").icons

      require("lspkind").init({
        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = "symbol_text",

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        preset = "default",

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
          Copilot = "",
          Text = icons.text,
          Method = icons.method,
          Function = icons.functions,
          Constructor = icons.constructor,
          Field = icons.field,
          Variable = icons.variable,
          Class = icons.class,
          Interface = icons.interface,
          Module = icons.module,
          Property = icons.property,
          Unit = "󰑭",
          Value = "󰎠",
          Enum = icons.enum,
          Keyword = icons.key,
          Snippet = "",
          Color = "󰏘",
          File = icons.file,
          Reference = "󰈇",
          Folder = icons.folder.default,
          EnumMember = icons.enumMember,
          Constant = icons.constant,
          Struct = icons.struct,
          Event = icons.event,
          Operator = icons.operator,
          TypeParameter = icons.typeParameter,
        },
      })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end,
  },
}
