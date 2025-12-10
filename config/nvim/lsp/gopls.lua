return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
  root_dir = require("lspconfig.util").root_pattern("go.mod", "go.work", ".git"),
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        generate = true,
        test = true,
        tidy = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
      },
      analyses = {
        unusedparams = true,
        unusedwrite = true,
      },
      usePlaceholders = false,
      completeUnimported = true,
      staticcheck = true,
    },
  },
}
