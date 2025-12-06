return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      local icons = require("doty.config").icons

      return {
        debug = false,
        auto_close = false, -- auto close when there are no items
        auto_open = false, -- auto open when there are items
        auto_preview = true, -- automatically open preview when on an item
        auto_refresh = true, -- auto refresh when open
        auto_jump = false, -- auto jump to the item when there's only one
        focus = true, -- Focus the window when opened
        restore = true, -- restores the last location in the list when opening
        follow = true, -- Follow the current item
        indent_guides = true, -- show indent guides
        max_items = 50, -- limit number of items that can be displayed per section
        multiline = true, -- render multi-line messages
        pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
        warn_no_results = true, -- show a warning when there are no results
        open_no_results = false, -- open the trouble window when there are no results
        ---@type trouble.Window.opts
        -- Window options for the preview window. Can be a split, floating window,
        -- or `main` to show the preview in the main editor window.
        ---@type trouble.Window.opts
        preview = {
          type = "main",
          -- when a buffer is not yet loaded, the preview window will be created
          -- in a scratch buffer with only syntax highlighting enabled.
          -- Set to false, if you want the preview to always be a real loaded buffer.
          scratch = true,
        },
        -- Throttle/Debounce settings. Should usually not be changed.
        ---@type table<string, number|{ms:number, debounce?:boolean}>
        throttle = {
          refresh = 20, -- fetches new data when needed
          update = 10, -- updates the window
          render = 10, -- renders the window
          follow = 100, -- follows the current item
          preview = { ms = 100, debounce = true }, -- shows the preview for the current item
        },

        -- key mappings for actions in the trouble list
        keys = {
          -- ["?"] = "help",
          ["?"] = function()
            require("which-key").show({ global = false })
          end,
          r = "refresh", -- manually refresh
          R = "toggle_refresh",
          q = "close", -- close the list
          o = "jump_close", -- jump to the diagnostic and close the list
          ["<esc>"] = "cancel", -- cancel the preview and get back to your last window / buffer / cursor
          ["<cr>"] = "jump", -- jump to the diagnostic or open / close folds
          ["<2-leftmouse>"] = "jump", -- jump to the diagnostic or open / close folds
          ["<c-x>"] = "jump_split", -- open buffer in new split
          ["<c-v>"] = "jump_vsplit", -- open buffer in new vsplit
          -- go down to next item (accepts count)
          -- j = "next",
          ["}"] = "next",
          ["]]"] = "next",
          -- go up to prev item (accepts count)
          -- k = "prev",
          ["{"] = "prev",
          ["[["] = "prev",
          dd = "delete",
          d = { action = "delete", mode = "v" },
          i = "inspect",
          p = "preview", -- preview the diagnostic location
          P = "toggle_preview", -- toggle auto_preview
          zo = "fold_open",
          zO = "fold_open_recursive",
          zc = "fold_close",
          zC = "fold_close_recursive",
          za = "fold_toggle", -- toggle fold of current file
          zA = "fold_toggle_recursive",
          zm = "fold_more",
          zM = "fold_close_all", -- close all folds
          zr = "fold_reduce",
          zR = "fold_open_all", -- open all folds
          zx = "fold_update",
          zX = "fold_update_all",
          zn = "fold_disable",
          zN = "fold_enable",
          zi = "fold_toggle_enable",
          gb = { -- example of a custom action that toggles the active view filter
            action = function(view)
              view:filter({ buf = 0 }, { toggle = true })
            end,
            desc = "Toggle Current Buffer Filter",
          },
          -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
          s = {
            action = function(view)
              local f = view:get_filter("severity")
              local severity = ((f and f.filter.severity or 0) + 1) % 5
              view:filter({ severity = severity }, {
                id = "severity",
                template = "{hl:Title}Filter:{hl} {severity}",
                del = severity == 0,
              })
            end,
            desc = "Toggle Severity Filter",
          },
          --     open_tab = {"<c-t>"}, -- open buffer in new tab
          --     toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          --     hover = "K", -- opens a small popup with the full multiline message
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client

        icons = {
          indent = {
            top = "│ ",
            middle = "├╴",
            last = "╰╴",
            fold_open = icons.collapsible_open .. " ", -- icon used for open folds
            fold_closed = icons.collapsible_closed .. " ", -- icon used for closed folds
            ws = "  ",
          },
          folder_open = icons.folder.arrow_open .. " ",
          folder_closed = icons.folder.arrow_closed .. " ",
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
        },
      }
    end,
  },
}
