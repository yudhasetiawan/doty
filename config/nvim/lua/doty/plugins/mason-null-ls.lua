require("mason-null-ls").setup({
  ensure_installed = {
    "ansiblelint",
    "checkmake",
    "codespell",
    "commitlint",
    "dotenv_linter",
    "editorconfig_checker",
    "golangci_lint",
    "hadolint",
    "jq",
    "luacheck",
    "misspell",
    "semgrep",
    "sqruff",
    "staticcheck",
    "stylua",
    "systemdlint",
    "terraform_validate",
    "textlint",
    "tfsec",
    "vacuum",
    "vale",
    "write_good",
    "yamllint",
    "zsh",
  },
  -- Enable or disable null-ls methods to get set up
  -- This setting is useful if some functionality is handled by other plugins such as `conform` and `nvim-lint`
  methods = {
    diagnostics = true,
    formatting = true,
    code_actions = true,
    completion = true,
    hover = true,
  },
  -- Run `require("null-ls").setup`.
  -- Will automatically install masons tools based on selected sources in `null-ls`.
  -- Can also be an exclusion list.
  -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
  automatic_installation = true,
  -- See [#handlers-usage](#handlers-usage) section
  handlers = nil,
})
