require("conform").setup({
  formatters_by_ft = {
    -- Shell/Bash
    -- sh = { "shfmt", "shellcheck" },
    -- bash = { "beautysh", "shfmt", "shellcheck", "shellharden" },

    -- Docker
    dockerfile = { "hadolint" },

    -- Go
    -- Conform will run multiple formatters sequentially
    -- go = { "gofumpt", "gofmt", "goimports", "golines" },

    -- HCL
    -- hcl = { "hcl" },
    hcl = { "packer_fmt" },

    -- JSON
    json = { "prettier", "jq" },
    -- jsonnet = { "jsonnetfmt" },

    -- Lua
    lua = { "stylua" },

    -- Markdown
    markdown = { "prettier", "markdownfmt", "markdownlint" }, -- "doctoc"

    -- You can use a function here to determine the formatters dynamically
    python = { "ruff_format", "isort", "black", stop_after_first = true },

    -- Rust
    rust = { "rustfmt" },

    -- SQL
    sql = { "sql_formatter" },

    -- Terraform
    terraform = { "terraform_fmt" },
    tf = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },

    -- TOML
    toml = { "taplo" },

    -- YAML, Ansible
    yaml = { "prettier", "yamlfix", "yamlfmt" },

    -- Use a sub-list to run only the first available formatter
    -- Conform will run the first available formatter
    -- TypeScript/JavaScript
    typescript = {
      "prettierd",
      "prettier",
      "eslint_d",
      stop_after_first = true,
    },
    javascript = {
      "prettierd",
      "prettier",
      "eslint_d",
      stop_after_first = true,
    },

    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "codespell", "typos", "trim_whitespace" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
      return
    end

    return {
      -- These options will be passed to conform.format()
      timeout_ms = 5000,
      lsp_format = "fallback",
    }
  end,
  -- If this is set, Conform will run the formatter asynchronously after save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_after_save = {
    lsp_format = "fallback",
  },

  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
  -- Conform will notify you when no formatters are available for the buffer
  notify_no_formatters = true,

  -- Custom formatters and overrides for built-in formatters
  formatters = {
    hadolint = {
      -- This can be a string or a function that returns a string.
      -- When defining a new formatter, this is the only field that is required
      command = "hadolint",
      -- A list of strings, or a function that returns a list of strings
      -- Return a single string instead of a list to run the command in a shell
      args = { "$FILENAME" },
      -- If the formatter supports range formatting, create the range arguments here
      -- Send file contents to stdin, read new contents from stdout (default true)
      -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
      -- file is assumed to be modified in-place by the format command.
      stdin = false,
      -- A function that calculates the directory to run the command in
      -- cwd = require("conform.util").root_file({ ".editorconfig", "package.json", "Dockerfile" }),
      -- When cwd is not found, don't run the formatter (default false)
      require_cwd = true,
      -- When returns false, the formatter will not be used
      condition = function(self, ctx)
        return vim.fs.basename(ctx.filename) ~= "Dockerfile"
      end,
      -- Exit codes that indicate success (default { 0 })
      exit_codes = { 0 },
    },
  },
})

vim.api.nvim_create_user_command("AutoFormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("AutoFormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
