require("mason-lspconfig").setup({
  -- Automatically enable (vim.lsp.enable()) installed servers.
  automatic_enable = true,
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
  -- This setting has no relation with the `automatic_installation` setting.
  ---@type string[]
  ensure_installed = {
    -- Diagnostic (general purpose server)
    "typos_lsp",
    "diagnosticls",

    -- Ansible
    "ansiblels",

    -- Bash
    "bashls",
    -- "awk_ls",

    -- Docker, Docker compose
    "dockerls",
    "docker_compose_language_service",

    -- Dot files
    "dotls",
    "harper_ls",

    -- Git
    -- "gitlab_ci_ls",
    -- "golangci_lint_ls",

    -- Go
    -- "gopls",
    "templ",
    -- Helm Chart
    "helm_ls",

    -- JavaScript, TypeScript
    "ts_ls",
    "eslint",
    "tsp_server",

    -- JSON, Jsonnet, jq
    "jsonls",
    -- "jsonnet_ls",
    -- "jqls",

    -- Lua
    "lua_ls",

    -- Markdown
    "marksman",

    -- Nginx
    "nginx_language_server",

    -- OpenAPI
    "vacuum",

    -- Python
    "pylsp",
    -- Rust
    "rust_analyzer",

    -- SQL
    -- "sqls",

    -- Terraform
    "terraformls",
    "tflint",

    -- TOML
    "taplo",

    -- VimScript
    "vimls",

    -- YAML, yq
    "yamlls",
  },

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  ---@type boolean
  automatic_installation = true,
})

vim.filetype.add({
  extension = {
    ["alloy"] = "hcl.alloy",
  },
  pattern = {
    ["openapi.*%.ya?ml"] = "yaml.openapi",
    ["openapi.*%.json"] = "json.openapi",
    [".*openapi%.ya?ml"] = "yaml.openapi",
    [".*openapi%.json"] = "json.openapi",
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    ["%.gitlab%-ci.*%.ya?ml"] = "yaml.gitlab",
    [".*/gitlab%-ci/.*%.ya?ml"] = "yaml.gitlab",
  },
})
