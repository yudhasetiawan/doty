-- Install semver.lua module
local semverpath = vim.fn.stdpath("data")
  .. "/site/pack/kikito/start/semver.lua/lua"
if not vim.loop.fs_stat(semverpath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/kikito/semver.lua.git",
    "--branch=master", -- latest stable release
    semverpath,
  })
end
package.path = semverpath .. "/semver.lua;" .. package.path
local v = require("semver")

local required_programs = {
  go = "Some Go related features might not work",
  cargo = "Some Rust related features might not work",
  python3 = "Some Python related features might not work",
  node = "Mason will not be able to install some LSPs/tools",
  tectonic = "Latex build command will not work",
  rg = "a highly recommended grep alternative (ripgrep is the package name)",
  fd = "a highly recommended find alternative",
}

local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error
local info = vim.health.info or vim.health.report_info

local M = {}

--- Check if the minimum Neovim version is supported.
---@param version string
---@return boolean
local function isNeovimVersionSupported(version)
  return v(
    string.format(
      "%d.%d.%d",
      vim.version().major,
      vim.version().minor,
      vim.version().patch
    )
  ) >= v(version)
end

function M.check()
  start("Doty")

  print(
    "═══════════════════════════════════"
  )
  print("      NEOVIM CONFIGURATION HEALTH   ")
  print(
    "═══════════════════════════════════"
  )
  print("")

  -- make sure setup function parameters are ok
  for command, msg in pairs(required_programs) do
    if vim.fn.executable(command) == 1 then
      ok(string.format("%s: binary found", command))
    else
      warn(string.format("%s: binary not found in PATH - %s", command, msg))
    end
  end

  -- do some more checking
  if not isNeovimVersionSupported("0.9") then
    error("This config probably won't work very well with Neovim < 0.9")
  end

  -- Check Mason tools
  print("🔧 MASON TOOLS:")
  local mason_verify = require("doty.utils.mason")
  mason_verify.verify_tools()
  print("")

  -- Check LSP status
  print("󰒋 LSP STATUS:")
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients > 0 then
    for _, client in ipairs(clients) do
      print("  ✓ " .. client.name .. " (ID: " .. client.id .. ")")
    end
  else
    print("  ⚠ No LSP clients attached to current buffer")
  end
  print("")

  -- Check formatters
  print("󰉿 FORMATTERS:")
  local ok, conform = pcall(require, "conform")
  if ok then
    local formatters = conform.list_formatters_to_run(0)
    if #formatters > 0 then
      for _, formatter in ipairs(formatters) do
        print("  ✓ " .. formatter.name)
      end
    else
      print("  ⚠ No formatters available for " .. vim.bo.filetype)
    end
  else
    print("  ✗ Conform.nvim not loaded")
  end
  print("")

  -- Check linters
  -- print("󰁨 LINTERS:")
  -- local ok, lint = pcall(require, "lint")
  -- if ok then
  --   local linters = lint.linters_by_ft[vim.bo.filetype] or {}
  --   if #linters > 0 then
  --     for _, linter in ipairs(linters) do
  --       print("  ✓ " .. linter)
  --     end
  --   else
  --     print("  ⚠ No linters configured for " .. vim.bo.filetype)
  --   end
  -- else
  --   print("  ✗ nvim-lint not loaded")
  -- end
  -- print("")

  -- Check key plugins
  print("📦 KEY PLUGINS:")
  local plugins_to_check = {
    { name = "mason", module = "mason" },
    { name = "conform", module = "conform" },
    -- { name = "lint", module = "lint" },
    { name = "trouble", module = "trouble" },
    { name = "dap", module = "dap" },
    { name = "treesitter", module = "nvim-treesitter" },
  }

  for _, plugin in ipairs(plugins_to_check) do
    local ok, _ = pcall(require, plugin.module)
    if ok then
      print("  ✓ " .. plugin.name)
    else
      print("  ✗ " .. plugin.name .. " (not loaded)")
    end
  end
  print("")

  print("Run :checkhealth for detailed Neovim health information")
  print("Run :MasonVerify for detailed Mason tool verification")
end

return M
