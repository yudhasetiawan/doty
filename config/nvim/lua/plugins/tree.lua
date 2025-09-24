return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeRefresh" },
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("doty.plugins.nvim-tree")
    end,
  },
}
