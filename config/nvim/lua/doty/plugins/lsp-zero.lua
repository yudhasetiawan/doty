local lsp_status = require("lsp-status")
local lsp_zero = require("lsp-zero")
local icons = require("doty.config").icons
local keymap = require("doty.utils.functions").keymap

lsp_zero.extend_lspconfig({
  capabilities = vim.tbl_deep_extend("force", {
    textDocument = {
      -- Tell the server the capability of foldingRange,
      -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  }, lsp_status.capabilities),
})

lsp_zero.format_on_save({
  format_opts = { async = false, timeout_ms = 10000 },
  servers = {
    ["lua_ls"] = { "lua" },
    ["rust_analyzer"] = { "rust" },
    ["gopls"] = { "go" },
  },
})



-----------------------------------------------------------
-- UI settings
-----------------------------------------------------------
-- In `v3.x` lsp-zero doesn't configure diagnostics anymore,
-- you just get the default Neovim behaviour.
-- If you want to get the icons and the config, add this code.
local border_style = vim.g.lsp_zero_ui_float_border
if border_style == nil then
  border_style = "rounded"
end

if type(border_style) == "string" then
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    float = {
      focusable = false,
      style = "minimal",
      border = border_style,
      source = "always",
      header = "",
      prefix = "",
    },
  })
end

lsp_zero.set_sign_icons({
  hint = icons.hint,
  info = icons.info,
  warning = icons.warning,
  error = icons.error,
})

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
lsp_zero.on_attach(function(client, bufnr)
  -- lsp_zero.default_keymaps({ buffer = bufnr })

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
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

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-T>.
  map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header
  map("gD", vim.lsp.buf.declaration, "Goto Declaration")

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map(
    "gi",
    require("telescope.builtin").lsp_implementations,
    "Goto Implementation"
  )

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map(
    "gt",
    require("telescope.builtin").lsp_type_definitions,
    "Type Definition"
  )

  -- Find references for the word under your cursor.
  map("gr", require("telescope.builtin").lsp_references, "Goto References")

  -- Show function signature.
  map("gs", vim.lsp.buf.signature_help, "Show function signature")

  -- Opens a popup that displays documentation about the word under your cursor
  map("k", vim.lsp.buf.hover, "Show Definition Documentation")

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map(
    "<leader>ld",
    require("telescope.builtin").lsp_document_symbols,
    "Document Symbols"
  )

  -- Fuzzy find all the symbols in your current workspace
  --  Similar to document symbols, except searches over your whole project.
  map(
    "<leader>lw",
    require("telescope.builtin").lsp_dynamic_workspace_symbols,
    "Workspace Symbols"
  )

  -- Rename the variable under your cursor
  --  Most Language Servers support renaming across files, etc.
  map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
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

  map("<C-f>", "<Cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format file")
  kmap(
    "x",
    "<C-f>",
    "<Cmd>lua vim.lsp.buf.format({async = true})<CR>",
    "Format selection"
  )

  -- Restarting LSP Server
  map("<leader>R", "<Cmd>LspRestart<CR>", "Restart LSP")
end)
