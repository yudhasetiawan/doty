return {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_dir = require("lspconfig.util").root_pattern("package.json", ".git"),
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
