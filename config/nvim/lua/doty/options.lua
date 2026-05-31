-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- See: https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/options.lua
-- [2] Defaults - *nvim-defaults*
local g = vim.g     -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- Neovide
-----------------------------------------------------------
-- See: https://neovide.dev/configuration.html
if g.neovide then
  g.neovide_cursor_trail_length = 0
  g.neovide_cursor_animation_length = 0
  -- vim.o.guifont = "Jetbrains Mono"
  -- vim.o.guifont = "Source Code Pro:h14" -- text below applies for VimScript
  vim.o.guifont = "Cascasdia Code:h14"
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor((255 * g.transparency) or 0.8))
  end

  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  g.neovide_transparency = 0.0
  g.transparency = 0.85
  g.neovide_background_color = "#0f1117" .. alpha()

  -- Floating Blur Amount
  g.neovide_floating_blur_amount_x = 2.0
  g.neovide_floating_blur_amount_y = 2.0

  -- If set to true,
  -- quitting while having unsaved changes will require confirmation.
  g.neovide_confirm_quit = true

  -- Set cursor particles
  g.neovide_cursor_vfx_mode = "ripple"
end

-----------------------------------------------------------
-- Leader key
-----------------------------------------------------------
-- Change leader key
--
-- In general, it's a good idea to set this early in your config,
-- because otherwise if you have any mappings you set BEFORE doing this,
-- they will be set to the OLD leader.
g.mapleader = " "
g.maplocalleader = ","

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a"               -- Enable mouse support
opt.clipboard = "unnamedplus" -- allows neovim to Copy/paste to system clipboard
opt.syntax = "enable"
-- opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = "menu,menuone,noinsert,noselect" -- Autocomplete options
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"                             -- String-encoding used internally and for RPC communication.
opt.fileencoding = "utf-8"                         -- File-content encoding for the current buffer

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
if vim.env.TERM ~= "xterm" then
  opt.background = "dark"
end
opt.number = true          -- Show line number
opt.relativenumber = false -- Show relative number
opt.showmatch = true       -- Highlight matching parenthesis
-- opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.foldcolumn = "1"
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.colorcolumn = "120" -- Line length marker at 120 columns
-- opt.splitright = true       -- Vertical split to the right
-- opt.splitbelow = true       -- Horizontal split to the bottom
-- opt.ignorecase = true       -- Ignore case letters when search
-- opt.smartcase = true        -- Ignore lowercase for the whole pattern
-- opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.laststatus = 3       -- Set global statusline
opt.scrolloff = 5        -- Minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 5    -- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
opt.wrap = false
opt.whichwrap = "b,s,<,>,[,]"
-- opt.guicursor="n-v-c:ver25,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- mouse
-- opt.mouse = 'a' -- all previous modes
-- opt.mousemoveevent = true

-- -----------------------------------------------------------
-- -- Syntax, Highlight
-- -----------------------------------------------------------
opt.hlsearch = true   -- When there is a previous search pattern, highlight all its matches.
opt.incsearch = true  -- While typing a search command, show where the pattern, as it was typed so far, matches.
opt.ignorecase = true -- Ignore case in search patterns.
opt.smartcase = true  -- Override the 'ignorecase' option if the search pattern contains upper-case characters.
opt.list = true       -- List mode: By default, show tabs as ">", trailing spaces as "-", and non-breakable space characters as "+".
opt.cursorline = true -- Highlight the text line of the cursor with CursorLine hl-CursorLine.
opt.signcolumn = "yes"
opt.listchars = {
  tab = "",
  trail = "⭘", -- ·
  lead = "·",
  extends = "»",
  precedes = "«",
  nbsp = "×",
}

-- -----------------------------------------------------------
-- -- Tabs, indent
-- -----------------------------------------------------------
opt.autoindent = true
opt.expandtab = true             -- Use spaces instead of tabs
opt.shiftwidth = 4               -- Shift 4 spaces when tab
-- Number of spaces that a <Tab> in the file counts for.
opt.tabstop = 4                  -- 1 tab == 4 spaces
-- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
opt.softtabstop = 2              -- 1 tab == 2 spaces
opt.smartindent = true           -- Autoindent new lines
g.disable_autoformat = false     -- Enable autoformat on by default. Used on after/plugin/formatting.lua
vim.b.disable_autoformat = false -- Enable autoformat on by default. Used on after/plugin/formatting.lua

-- -----------------------------------------------------------
-- -- Memory, CPU
-- -----------------------------------------------------------
-- opt.hidden = true           -- Enable background buffers
opt.history = 100 -- Remember N lines in history
-- opt.lazyredraw = true       -- Faster scrolling
-- opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 200    -- ms to wait for trigger an CursorHold event
opt.timeout = true
opt.timeoutlen = 300    -- Time in milliseconds to wait for a mapped sequence to complete.
opt.swapfile = false    -- Use a swapfile for the buffer.
opt.backup = false      -- Make a backup before overwriting a file
opt.writebackup = false -- No backup before overwriting a file
-- When a file has been detected to have been changed outside of Vim and
-- it has not been changed inside of Vim, automatically read it again.
opt.autoread = true
vim.bo.autoread = true

-----------------------------------------------------------
-- Command completion
-----------------------------------------------------------
opt.wildignore = opt.wildignore
    + {
      "*/node_modules/*",
      "*/.git/*",
      "*/vendor/*",
      "*.jpg",
      "*.png",
      "*.gif",
      "*.img",
      "*.flv",
      "*.docx",
      "*.pdf",
      "*.xlsx",
      "*DS_STORE",
      "*.db",
      "*.pyc",
      "*.exe",
    }

-- API compatibility check
if vim.fn.has("nvim-0.9") == 1 then
  -- Use the new diagnostic signs for Neovim 0.9+
  vim.fn.sign_define(
    "DiagnosticSignError",
    { text = "●", texthl = "DiagnosticSignError" }
  )
  vim.fn.sign_define(
    "DiagnosticSignWarn",
    { text = "●", texthl = "DiagnosticSignWarn" }
  )
  vim.fn.sign_define(
    "DiagnosticSignInfo",
    { text = "●", texthl = "DiagnosticSignInfo" }
  )
  vim.fn.sign_define(
    "DiagnosticSignHint",
    { text = "●", texthl = "DiagnosticSignHint" }
  )
end

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- opt.shortmess:append("sI") -- Disable nvim intro
opt.shortmess:append("c") -- Don't show the dumb matching stuff.

-- Disable context_commentstring nvim-treesitter module to speed up loading",
-- as nvim-ts-context-commentstring is alreadey initialized separately.
g.skip_ts_context_commentstring_module = true
g.health = { style = "float" } -- display :checkhealth in a floating window instead of the default behavior

-- Disable builtin plugins
local disabled_built_ins = {
  "2html_plugin",
  "bugreport",
  "compiler",
  -- "ftplugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  -- disable netrw at the very start of your init.lua
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "optwin",
  "remote_plugins",
  "rplugin",
  "rrhelper",
  "spellfile_plugin",
  "synmenu",
  "tar",
  "tarPlugin",
  "toHtml",
  "tutor",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-- Add more performance optimizations
opt.sessionoptions =
"blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
