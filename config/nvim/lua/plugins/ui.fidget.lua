return {
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("doty.config").icons

      return {
        -- Options related to LSP progress subsystem
        progress = {
          -- Options related to how LSP progress messages are displayed as notifications
          display = {
            done_icon = icons.status.success, -- Icon shown when all LSP progress tasks are complete
            progress_icon = { "dots_negative" }, -- Icon shown when LSP progress tasks are in progress
          },
        },

        -- Options related to notification subsystem
        notification = {
          -- Options related to how notifications are rendered as text
          view = {
            stack_upwards = true, -- Display notification items from bottom to top
            icon_separator = " ", -- Separator between group name and icon
            group_separator = "---", -- Separator between notification groups
            -- Highlight group used for group separator
            group_separator_hl = "Comment",
            -- How to render notification messages
            render_message = function(msg, cnt)
              return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
            end,
          },

          -- Options related to the notification window and buffer
          window = {
            normal_hl = "Comment", -- Base highlight group in the notification window
            winblend = 85, -- Background color opacity in the notification window
            border = "single", -- Border around the notification window
            avoid = {
              -- "NvimTree"
              "TestExplorer", -- Ensure Fidget continues to avoid xcodebuild.nvim's explorer window.
            },
          },
        },

        -- Options related to logging
        logger = {
          level = vim.log.levels.WARN, -- Minimum logging level
          max_size = 5120, -- Maximum log file size, in KB
          float_precision = 0.01, -- Limit the number of decimals displayed for floats
          -- Where Fidget writes its logs to
          path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
        },
      }
    end,
  },
}
