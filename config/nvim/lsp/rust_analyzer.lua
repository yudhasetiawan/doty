return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = require("lspconfig.util").root_pattern("Cargo.toml", "Cargo.lock", ".git"),
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
