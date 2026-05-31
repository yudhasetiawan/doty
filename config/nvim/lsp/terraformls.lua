return {
  root_dir = require("lspconfig.util").root_pattern(
    "*.tf",
    "*.terraform",
    "*.tfvars",
    ".terraform",
    ".git"
  ),
}