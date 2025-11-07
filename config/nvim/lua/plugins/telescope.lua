return {
  {
    "nvim-telescope/telescope.nvim",
    priority = 100,
    dependencies = {
      "ANGkeith/telescope-terraform-doc.nvim",
      "ahmedkhalf/project.nvim",
      "cappyzawa/telescope-terraform.nvim",
      "crispgm/telescope-heading.nvim",
      "kdheepak/lazygit.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "ptethng/telescope-makefile",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("doty.plugins.telescope")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    main = "project_nvim",
    config = function()
      require("doty.plugins.telescope-project")
    end,
  },
  "crispgm/telescope-heading.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-symbols.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  {
    "ptethng/telescope-makefile",
    dependencies = {
      "akinsho/nvim-toggleterm.lua",
    },
  },
  {
    "cappyzawa/telescope-terraform.nvim",
    ft = { "terraform", "hcl" },
  },
  {
    "ANGkeith/telescope-terraform-doc.nvim",
    ft = { "terraform", "hcl" },
  },
  -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
