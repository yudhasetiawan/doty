local lsp_status = require("lsp-status")
local keymap = require("doty.utils.functions").keymap

-- Set up default capabilities with foldingRange support
local capabilities =
  vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
    textDocument = {
      -- Tell the server the capability of foldingRange,
      -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  }, lsp_status.capabilities)
-----------------------------------------------------------
-- On Attach function with keymaps
-----------------------------------------------------------
-- Attach lsp-status to the client
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Create a helper function for mappings
  local kmap = function(mode, keys, func, desc)
    keymap(
      mode,
      keys,
      func,
      { buffer = bufnr, silent = true, desc = "LSP: " .. desc }
    )
  end
  local map = function(keys, func, desc)
    kmap("n", keys, func, desc)
  end

  -- Jump to the definition of the word under your cursor
  map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")

  -- Jump to declaration
  map("gD", vim.lsp.buf.declaration, "Goto Declaration")

  -- Jump to the implementation of the word under your cursor
  map(
    "gi",
    require("telescope.builtin").lsp_implementations,
    "Goto Implementation"
  )

  -- Jump to the type of the word under your cursor
  map(
    "gt",
    require("telescope.builtin").lsp_type_definitions,
    "Type Definition"
  )

  -- Find references for the word under your cursor
  map("gr", require("telescope.builtin").lsp_references, "Goto References")

  -- Show function signature
  map("gs", vim.lsp.buf.signature_help, "Show function signature")

  -- Opens a popup that displays documentation about the word under your cursor
  map("k", vim.lsp.buf.hover, "Show Definition Documentation")

  -- Fuzzy find all the symbols in your current document
  map(
    "<leader>ld",
    require("telescope.builtin").lsp_document_symbols,
    "Document Symbols"
  )

  -- Fuzzy find all the symbols in your current workspace
  map(
    "<leader>lw",
    require("telescope.builtin").lsp_dynamic_workspace_symbols,
    "Workspace Symbols"
  )

  -- Rename the variable under your cursor
  map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")

  -- Execute a code action, usually your cursor needs to be on top of an error
  map("<leader>ca", vim.lsp.buf.code_action, "Execute code action")
  if vim.lsp.buf.range_code_action then
    kmap(
      "x",
      "<leader>ca",
      vim.lsp.buf.range_code_action,
      "Execute code action"
    )
  else
    kmap("x", "<leader>ca", vim.lsp.buf.code_action, "Execute code action")
  end

  -- Workspace folder management
  map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add folder to workspace")
  map(
    "<leader>wr",
    vim.lsp.buf.remove_workspace_folder,
    "Remove folder from workspace"
  )
  map(
    "<leader>wl",
    "<Cmd>lua vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    "List workspace folders"
  )

  -- Format file/selection
  map("<C-f>", "<Cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format file")
  kmap(
    "x",
    "<C-f>",
    "<Cmd>lua vim.lsp.buf.format({async = true})<CR>",
    "Format selection"
  )

  -- Restarting LSP Server
  map("<leader>R", "<Cmd>LspRestart<CR>", "Restart LSP")

  -- Attach lsp-status to the client
  lsp_status.on_attach(client, bufnr)
end

-----------------------------------------------------------
-- LSP Server Setup
-----------------------------------------------------------
-- Setup LSP servers with their specific configurations
-- Load configurations from separate files in the lsp directory
local lsp_servers = {
  "lua_ls",
  "rust_analyzer",
  "gopls",
  "ansiblels",
  "bashls",
  "dockerls",
  "docker_compose_language_service",
  "jsonls",
  "pylsp",
  "terraformls",
  "yamlls",
  "marksman",
  "taplo",
  "vimls",
  "eslint",
  "ts_ls",
  "tsp_server",
  "jsonnet_ls",
  "nginx_language_server",
  "vacuum",
  "diagnosticls",
  "typos_lsp",
  "dotls",
  "harper_ls",
  "helm_ls",
  "templ",
  "tflint",
}

for _, server in ipairs(lsp_servers) do
  local server_opts = {
    capabilities = capabilities,
    on_attach = on_attach,
  }

  -- Load server-specific configuration if it exists
  local server_config_ok, server_config = pcall(require, "lsp." .. server)
  if server_config_ok then
    server_opts = vim.tbl_deep_extend("force", server_opts, server_config)
  end

  -- Setup the server
  vim.lsp.config(server, server_opts)
end

-- Register the progress handler for lsp-status
lsp_status.register_progress()
