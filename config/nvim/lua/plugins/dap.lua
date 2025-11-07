return {
  {
    "folke/neodev.nvim",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    opts = function()
      return require("doty.plugins.neodev")
    end,
  },

  {
    "nvim-telescope/telescope-dap.nvim",
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "mfussenegger/nvim-dap",
    main = "dap",
    lazy = true,
    dependencies = {
      "jbyuki/one-small-step-for-vimkind",
    },
    config = function()
      require("doty.plugins.nvim-dap")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    main = "dapui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("doty.plugins.nvim-dap-ui")
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("doty.plugins.nvim-dap-virtual-text")
    end,
  },

  --  Adaparter configuration for specific languages
  -- "leoluz/nvim-dap-go",
  -- "mfussenegger/nvim-dap-python",
  "jbyuki/one-small-step-for-vimkind",
}
