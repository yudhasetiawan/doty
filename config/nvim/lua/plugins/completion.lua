return {
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-calc" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-emoji" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-path" },
  { "ray-x/cmp-treesitter" },
  {
    "saadparwaiz1/cmp_luasnip",
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
    },
    config = function() end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    opts = {
      completion = {
        insert_closing_quote = true,
        crates = {
          enabled = true,
          min_chars = 3,
          max_results = 8,
        },
      },
    },
  },
  {
    "tamago324/cmp-zsh",
    ft = "zsh",
    opts = {
      zshrc = true, -- Source the zshrc (adding all custom completions). default: false
      filetypes = {
        "deoledit",
        "bash",
        "sh",
        "zsh",
      }, -- Filetypes to enable cmp_zsh source. default: {"*"}
    },
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
    end,
  },
  -- auto generate code
  -- {'rafamadriz/friendly-snippets'},
}
