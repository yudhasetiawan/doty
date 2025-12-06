return {
  {
    "SmiteshP/nvim-navic",
    config = function()
      local cfg = require("doty.config")
      local navic = require("nvim-navic")
      local icons = cfg.icons

      navic.setup({
        icons = {
          File = icons.file,
          Module = icons.module,
          Namespace = icons.namespace,
          Package = icons.package,
          Class = icons.class,
          Method = icons.method,
          Property = icons.property,
          Field = icons.field,
          Constructor = icons.constructor,
          Enum = icons.enum,
          Interface = icons.interface,
          Function = icons.functions,
          Variable = icons.variable,
          Constant = icons.constant,
          String = icons.string,
          Number = icons.number,
          Boolean = icons.boolean,
          Array = icons.array,
          Object = icons.object,
          Key = icons.key,
          Null = icons.null,
          EnumMember = icons.enumMember,
          Struct = icons.struct,
          Event = icons.event,
          Operator = icons.operator,
          TypeParameter = icons.typeParameter,
        },
        lsp = {
          -- Doesn't need to be enabled, since it's already attached by barbecue.nvim
          auto_attach = false,
          preference = nil,
        },
        highlight = false,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
        lazy_update_context = false,
        click = false,
        format_text = function(text)
          return text
        end,
      })
    end,
  },
}
