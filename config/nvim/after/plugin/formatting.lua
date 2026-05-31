-- Global formatting options
vim.o.formatoptions = vim.o.formatoptions
    -- Don't continue comments when using o or O
    :gsub("r", "")
    -- Don't continue comments when using gq
    :gsub("c", "")
    -- Add to the above set
    .. "n" -- Smart autoindenting inside numbered lists
    .. "j" -- Remove comment leader when joining lines
    .. "l" -- Long lines are not broken in insert mode
    .. "t" -- Auto-wrap text using textwidth

-- Format settings for specific file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "json", "jsonc", "yaml", "markdown",
    "lua", "python", "rust", "go", "javascript", "typescript",
    "terraform", "sh"
  },
  callback = function()
    -- Set text width for these file types
    vim.bo.textwidth = 80
    vim.wo.wrap = false
  end,
})

-- Add commands for formatting
vim.api.nvim_create_user_command("FormatDocument", function(args)
  local clients = vim.lsp.get_clients({ bufnr = args.buf })
  for _, client in pairs(clients) do
    if client.supports_method("textDocument/formatting") then
      -- Use native vim.lsp.buf.format with async capabilities from v0.12+
      require("conform").format({
        async = true,
        timeout_ms = 10000, -- Allow more time for formatting in v0.12+
        bufnr = args.buf,
        lsp_format = "fallback",
        filter = function(format_client)
          return format_client.name == client.name
        end,
      })
      break
    end
  end
end, { desc = "Format current document" })

vim.api.nvim_create_user_command("FormatDocumentToggle", function()
  if vim.b.disable_autoformat == true or vim.g.disable_autoformat == true then
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    vim.notify("Auto formatting enabled", vim.log.levels.INFO)
  else
    vim.b.disable_autoformat = true
    vim.g.disable_autoformat = true
    vim.notify("Auto formatting disabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle autoformat on save" })

vim.api.nvim_create_user_command("FormatDocumentDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
    vim.notify("Auto formatting disabled for this buffer", vim.log.levels.INFO)
  else
    vim.g.disable_autoformat = true
    vim.notify("Auto formatting disabled", vim.log.levels.INFO)
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatDocumentEnable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = false
    vim.notify("Auto formatting enabled for this buffer", vim.log.levels.INFO)
  else
    vim.g.disable_autoformat = false
    vim.notify("Auto formatting enabled", vim.log.levels.INFO)
  end
end, {
  desc = "Re-enable autoformat-on-save",
  bang = true,
})
