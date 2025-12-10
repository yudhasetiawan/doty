return {
  settings = {
    Lua = {
      -- Configure completion settings
      completion = {
        callSnippet = "Replace",
      },
      -- Configure diagnostics
      diagnostics = {
        globals = { "vim" },
      },
      -- Configure workspace
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}
