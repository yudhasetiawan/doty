-- Global formatting options
vim.o.formatoptions = vim.o.formatoptions
  -- Disable automatic commenting on newline
  :gsub("o", "")
  -- Don't continue comments when using o or O
  :gsub("r", "")
  -- Don't continue comments when using gq
  :gsub("c", "")
  -- Add to the above set
  .. "n"  -- Smart autoindenting inside numbered lists
  .. "j"  -- Remove comment leader when joining lines
  .. "l"  -- Long lines are not broken in insert mode
  .. "t"  -- Auto-wrap text using textwidth

-- Format settings for specific file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "json", "jsonc", "yaml", "markdown",
    "lua", "python", "rust", "go", "javascript", "typescript"
  },
  callback = function()
    -- Set text width for these file types
    vim.bo.textwidth = 80
    vim.wo.wrap = false
  end,
})

-- Add commands for formatting
vim.api.nvim_create_user_command("FormatToggle", function()
  if vim.b.autoformat == true or vim.g.autoformat == true then
    vim.b.autoformat = false
    vim.g.autoformat = false
    print("Autoformatting disabled")
  else
    vim.b.autoformat = true
    vim.g.autoformat = true
    print("Autoformatting enabled")
  end
end, { desc = "Toggle autoformat on save" })

-- Enable autoformat on by default
vim.g.autoformat = true
