return {
  {
    "rcarriga/nvim-dap-ui",
    main = "dapui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dapui = require("dapui")
      local icons = require("doty.config").icons

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "√", texthl = "", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "", texthl = "", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapStopped", { text = "", texthl = "Error" })

      dapui.setup({
        icons = {
          expanded = icons.dap.expanded,
          collapsed = icons.dap.collapsed,
          current_frame = icons.dap.current_frame,
        },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        element_mappings = {},
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        force_buffers = true,
        layouts = {
          {
            -- You can change the order of elements in the sidebar
            elements = {
              -- Provide IDs as strings or tables with "id" and "size" keys
              { id = "scopes", size = 0.25 }, -- Can be float or integer > 1
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left", -- Can be "left" or "right"
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 10,
            position = "bottom", -- Can be "bottom" or "top"
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            ["close"] = { "q", "<Esc>" },
          },
        },
        controls = {
          enabled = vim.fn.exists("+winbar") == 1,
          element = "repl",
          icons = {
            pause = icons.dap.controls.pause,
            play = icons.dap.controls.play,
            step_into = icons.dap.controls.step_into,
            step_over = icons.dap.controls.step_over,
            step_out = icons.dap.controls.step_out,
            step_back = icons.dap.controls.step_back,
            run_last = icons.dap.controls.run_last,
            terminate = icons.dap.controls.terminate,
            disconnect = icons.dap.controls.disconnect,
          },
        },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
          indent = 1,
        },
      })
    end,
  },
}
