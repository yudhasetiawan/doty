return {
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
      "tjdevries/colorbuddy.nvim",
    },
    opts = function()
      local cfg = require("doty.config")
      local icons = cfg.icons
      local symbols = cfg.symbols

      return {
        ---Whether to attach navic to language servers automatically.
        ---
        ---@type boolean
        attach_navic = true, -- prevent barbecue from automatically attaching nvim-navic

        ---Whether to create winbar updater autocmd.
        ---
        ---@type boolean
        create_autocmd = true,

        ---Buftypes to enable winbar in.
        ---
        ---@type string[]
        include_buftypes = { "" },

        ---Filetypes not to enable winbar in.
        ---
        ---@type string[]
        exclude_filetypes = { "netrw", "toggleterm" },

        modifiers = {
          ---Filename modifiers applied to dirname.
          ---
          ---See: `:help filename-modifiers`
          ---
          ---@type string
          dirname = ":~:.",

          ---Filename modifiers applied to basename.
          ---
          ---See: `:help filename-modifiers`
          ---
          ---@type string
          basename = "",
        },

        ---Whether to display path to file.
        ---
        ---@type boolean
        show_dirname = true,

        ---Whether to display file name.
        ---
        ---@type boolean
        show_basename = true,

        ---Whether to replace file icon with the modified symbol when buffer is
        ---modified.
        ---
        ---@type boolean
        show_modified = true,

        ---Get modified status of file.
        ---
        ---NOTE: This can be used to get file modified status from SCM (e.g. git)
        ---
        ---@type fun(bufnr: number): boolean
        -- modified = function(bufnr) return vim.bo[bufnr].modified end,

        ---Whether to show/use navic in the winbar.
        ---
        ---@type boolean
        show_navic = true,

        ---Get leading custom section contents.
        ---
        ---NOTE: This function shouldn't do any expensive actions as it is run on each
        ---render.
        ---
        ---@type fun(bufnr: number, winnr: number): barbecue.Config.custom_section
        -- lead_custom_section = function() return " " end,

        ---@alias barbecue.Config.custom_section
        ---|string # Literal string.
        ---|{ [1]: string, [2]: string? }[] # List-like table of `[text, highlight?]` tuples in which `highlight` is optional.
        ---
        ---Get custom section contents.
        ---
        ---NOTE: This function shouldn't do any expensive actions as it is run on each
        ---render.
        ---
        ---@type fun(bufnr: number, winnr: number): barbecue.Config.custom_section
        -- custom_section = function() return " " end,

        ---@alias barbecue.Config.theme
        ---|'"auto"' # Use your current colorscheme's theme or generate a theme based on it.
        ---|string # Theme located under `barbecue.theme` module.
        ---|barbecue.Theme # Same as '"auto"' but override it with the given table.
        ---
        ---Theme to be used for generating highlight groups dynamically.
        ---
        ---@type barbecue.Config.theme
        theme = "ayu",

        ---Whether context text should follow its icon's color.
        ---
        ---@type boolean
        context_follow_icon_color = false,

        symbols = {
          ---Modification indicator.
          ---
          ---@type string
          modified = symbols.modified,

          ---Truncation indicator.
          ---
          ---@type string
          ellipsis = symbols.ellipsis,

          ---Entry separator.
          ---
          ---@type string
          separator = symbols.separator,
        },

        ---@alias barbecue.Config.kinds
        ---|false # Disable kind icons.
        ---|table<string, string> # Type to icon mapping.
        ---
        ---Icons for different context entry kinds.
        ---
        ---@type barbecue.Config.kinds
        kinds = {
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
      }
    end,
    config = function()
      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter", --
        "CursorHold", --
        "InsertLeave", --
        "BufModifiedSet", -- include this if you have set `show_modified` to `true`
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },
}
