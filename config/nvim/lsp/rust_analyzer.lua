return {
  cmd = { "rust-analyzer" },
  root_markers = { "Cargo.lock" },
  filetypes = { "rust" },
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      diagnostics = {
        enable = true,
      },
      lens = {
        enable = true,
      },
      -- Add clippy lints for Rust.
      check = {
        enable = true,
        allFeatures = true,
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    },
  },
}
