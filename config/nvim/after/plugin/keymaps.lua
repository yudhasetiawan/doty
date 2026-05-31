local funcs = require("doty.utils.functions")
local wk = require("which-key")
local imap = funcs.imap
local nmap = funcs.nmap
local vmap = funcs.vmap

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CloseWithQ", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "startuptime",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n",
      "q",
      "<cmd>close<cr>",
      { buffer = event.buf, silent = true }
    )
  end,
})

-- Remap command key
-- nmap('<leader><leader>', ':')
-- nmap('<C-p>', ':', {})

-- window
-- This is going to get me cancelled
nmap("<C-x>", "<Cmd>x<CR>")
nmap("<C-c>", "<Cmd>q!<CR>")
nmap("<C-s>", "<Cmd>w<CR>")
imap("<C-s>", "<Esc><cmd>w<cr>")

-- Window movement
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- buffer navigation
wk.add({
  -- Option - Z
  { "Ω", "<Cmd>undo<CR>", desc = "Undo", mode = { "i", "n", "v" } },

  { "<C-J>", ":m .+1<CR>==", desc = "Move line up", mode = { "n" } },
  { "<C-K>", ":m .-2<CR>==", desc = "Move line up", mode = { "n" } },
  {
    "<C-J>",
    "<Esc>:m .+1<CR>==<Insert>",
    desc = "Move line down",
    mode = { "i" },
  },
  {
    "<C-K>",
    "<Esc>:m .-2<CR>==<Insert>",
    desc = "Move line up",
    mode = { "i" },
  },

  -- TODO: Keymap not smooth?
  {
    "<C-a>",
    "<Esc><CR>gg<S-v>G",
    desc = "Select All",
    mode = { "i", "n", "v" },
  },
  {
    "<C-Del>",
    "1C",
    desc = "Delete All Right",
    mode = { "n", "v" },
  },

  -- This works in Insert mode: press CTRL-u to make the
  -- word before the cursor uppercase. Handy to type
  -- words in lowercase and then make them uppercase.
  {
    "gU",
    desc = "Transform to Uppercase",
    noremap = true,
    mode = { "n", "v" },
  },
  {
    "gUgU",
    desc = "Transform Line to Uppercase",
    noremap = true,
    mode = { "n", "v" },
  },
  {
    "gu",
    desc = "Transform to Lowercase",
    noremap = true,
    mode = { "n", "v" },
  },
  {
    "gugu",
    desc = "Transform Line to Lowercase",
    noremap = true,
    mode = { "n", "v" },
  },

  -- Tab Groups navigation
  {
    "<leader>bn",
    "<Cmd>bnext<CR>",
    desc = "Buffer: Next",
    mode = { "n", "v" },
  },
  {
    "<leader>bp",
    "<Cmd>bprev<CR>",
    desc = "Buffer: Previous",
    mode = { "n", "v" },
  },
  {
    "<leader>bd",
    "<Cmd>bdelete<CR>",
    desc = "Buffer: Close current",
    mode = { "n", "v" },
  },
  {
    "<C-PageUp>",
    "<Cmd>tabnext<CR>",
    desc = "View: Go to next tab",
    noremap = true,
  },
  {
    "<C-PageDown>",
    "<Cmd>tabprevious<CR>",
    desc = "View: Go to previous tab",
    noremap = true,
  },
  -- { '<C-w>', '<Cmd>tabclose<CR>', desc = 'View: Close current tab', noremap = true },
})

-- WhichKey ---------------------------------------------------------
wk.add({
  {
    "<C-h>",
    "<Cmd>WhichKey<CR>",
    desc = "Open Keyboard Shortcuts (which-key)",
    mode = { "n", "i", "v" },
  },
})

-- Lazy plugin management -------------------------------------------
wk.add({
  { "<leader>p",  group = "Plugin Management" },
  { "<leader>pc", "<Cmd>Lazy check<CR>",      desc = "Check plugins" },
  { "<leader>pu", "<Cmd>Lazy update<CR>",     desc = "Update plugins" },
  { "<leader>ps", "<Cmd>Lazy show<CR>",       desc = "Show plugins" },
  { "<leader>pp", "<Cmd>Lazy profile<CR>",    desc = "Profile" },
  { "<leader>pl", "<Cmd>Lazy log<CR>",        desc = "Logs" },
  {
    "<leader>pr",
    "<Cmd>Lazy restore<CR>",
    desc = "Restore plugins from lockfile",
  },
  { "<leader>px", "<Cmd>Lazy clear<CR>", desc = "Clear uninstalled plugins" },
  { "<leader>ph", "<Cmd>Lazy help<CR>",  desc = "Show Help" },
})

-- Telescope --------------------------------------------------------
wk.add({
  -- Files
  { "<leader>f",  group = "File" },
  {
    "<leader>fB",
    "<cmd>Telescope file_browser grouped=true<cr>",
    desc = "File browser",
  },
  { "<leader>fn", "<Cmd>new<CR>",                  desc = "New file" },
  { "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
  {
    "<leader>fr",
    "<Cmd>Telescope oldfiles<CR>",
    desc = "Open recent file ('.' for repeat)",
    noremap = false,
  },
  { "<leader>fj", "<Cmd>Telescope jumplist<CR>",  desc = "Jump list" },
  { "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Search in files" },
  { "<leader>fb", "<Cmd>Telescope buffers<CR>",   desc = "Lists open buffers" },
  { "<leader>fm", "<Cmd>Telescope marks<CR>",     desc = "Marks" },
  {
    "<leader>fs",
    "<Cmd>Telescope grep_string<CR>",
    desc = "Select Current Word",
  },

  -- Search
  { "<leader>s",  group = "Search" },
  {
    "<leader>sb",
    "<Cmd>Telescope builtin<CR>",
    desc = "Search Select Telescope",
  },
  {
    "<leader>sB",
    "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    desc = "Search in buffer",
  },
  { "<leader>sc", "<Cmd>Telescope commands<CR>", desc = "Commands" },
  {
    "<leader>sf",
    function()
      require("telescope.builtin").grep_string({
        shorten_path = true,
        word_match = "-w",
        only_sort_text = true,
        search = "",
      })
    end,
    desc = "Fuzzy search",
  },
  {
    "<leader>sH",
    "<Cmd>Telescope command_history<CR>",
    desc = "Command history",
  },
  { "<leader>sh", "<Cmd>Telescope heading<CR>",     desc = "Headings" },
  { "<leader>sd", "<Cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
  { "<leader>sk", "<Cmd>Telescope keymaps<CR>",     desc = "Keymaps" },
  { "<leader>sO", "<Cmd>Telescope vim_options<CR>", desc = "Vim Options" },
  { "<leader>sp", "<Cmd>Telescope projects<CR>",    desc = "Projects" },
  { "<leader>sr", "<Cmd>Telescope resume<CR>",      desc = "Search Resume" },
  { "<leader>sS", "<Cmd>Telescope symbols<CR>",     desc = "Emoji" },
  {
    "<leader>s:",
    "<Cmd>Telescope search_history<CR>",
    desc = "Search History",
  },
  -- Shortcut for searching your neovim configuration files
  {
    "<leader>sN",
    function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
    end,
    desc = "Search Neovim files",
  },
  -- Slightly advanced example of overriding default behavior and theme
  {
    "<leader>/",
    function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        })
      )
    end,
    desc = "Fuzzily search in current buffer",
  },
  -- Also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  {
    "<leader>s/",
    function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end,
    desc = "Search in Open Files",
  },

  -- DAP
  { "<leader>d",  group = "DAP" },
  {
    "<leader>db",
    "<cmd>Telescope dap list_breakpoints<cr>",
    desc = "List Breakpoints",
  },
  { "<leader>dc", "<cmd>Telescope dap commands<cr>", desc = "Commands" },
  {
    "<leader>do",
    "<cmd>Telescope dap configurations<cr>",
    desc = "Configurations",
  },
  { "<leader>dv", "<cmd>Telescope dap variables<cr>", desc = "Variables" },
  { "<leader>df", "<cmd>Telescope dap frames<cr>",    desc = "Frames" },

  -- Make
  { "<leader>m",  group = "Make" },
  { "<leader>mm", "<cmd>Telescope make<cr>",          desc = "Run make" },

  -- Other
  { "<leader>qq", "<Cmd>Telescope Quickfix<CR>",      desc = "Quickfix" },
  {
    "<leader>?",
    "<Cmd>Telescope help_tags<CR>",
    desc = "Lists available help tags",
  },
})

-- Nvim-Tree --------------------------------------------------------
wk.add({
  { "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "NvimTree: Toggle" },
  -- { "<leader>r", "<Cmd>NvimTreeRefresh<CR>", desc = "NvimTree: Refresh Tree" },
  -- { "q", "<Cmd>NvimTreeClose<CR>", desc = "NvimTree: Close" },
  -- { "-", "<Cmd>NvimTreeCollapse<CR>", desc = "NvimTree: Collapse all" },
})

-- Mason ------------------------------------------------------------
wk.add({
  { "<leader>X", "<Cmd>Mason<CR>", desc = "Mason: Open status window" },
})

-- Git --------------------------------------------------------------
wk.add({
  { "<leader>g",  group = "Git" },
  { "<leader>gg", "<cmd>LazyGit<cr>",                desc = "LazyGit Toggle" },
  { "<leader>gB", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
  { "<leader>gC", "<cmd>Telescope git_commits<cr>",  desc = "Commits" },
  {
    "<leader>gj",
    "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
    desc = "Next Hunk",
  },
  {
    "<leader>gk",
    "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
    desc = "Prev Hunk",
  },
  { "<Leader>gm", "<Plug>(git-messenger)",         desc = "Show git message" },
  {
    "<leader>gp",
    "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
    desc = "Preview Hunk",
  },
  { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
})

-- Breadcrumb -------------------------------------------------------
wk.add({
  {
    "<leader>bc",
    function()
      local off = vim.b["barbecue_entries"] == nil
      require("barbecue.ui").toggle(off and true or nil)
    end,
    desc = "Breadcrumbs: Toggle navigation",
  },
})

-- Twilight ---------------------------------------------------------
wk.add({
  { "<C-r>", "<Cmd>Twilight<CR>", desc = "Twilight: Toggle" },
})

-- vim-visual-multi -------------------------------------------------
-- wk.add({{ "<C-n>", "<Plug>(VM-Select-Operator)", desc = "Select Operator" }})

-- Conform ----------------------------------------------------------
wk.add({
  -- Leave visual mode after range format
  -- If you call `conform.format` when in visual mode,
  -- conform will perform a range format on the selected region.
  -- If you want it to leave visual mode afterwards (similar to the default `gw` or `gq` behavior), use this mapping:
  {
    "<M-F>",
    function()
      require("conform").format({ async = true }, function(err)
        if not err then
          local mode = vim.api.nvim_get_mode().mode
          if vim.startswith(string.lower(mode), "v") then
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
              "n",
              true
            )
          end
        end
      end)
    end,
    desc = "Format code",
    mode = { "v" },
  },
})

-- Trouble ----------------------------------------------------------
wk.add({
  { "<leader>x", group = "Diagnostics" },
  {
    "<leader>xx",
    "<Cmd>Trouble diagnostics toggle<CR>",
    desc = "Trouble: Diagnostics",
  },
  {
    "<leader>xd",
    "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
    desc = "Trouble: Diagnostics document",
  },
  {
    "<leader>xl",
    "<Cmd>Trouble loclist toggle<CR>",
    desc = "Trouble: Location list",
  },
  {
    "<leader>xf",
    "<Cmd>Trouble quickfix toggle<CR>",
    desc = "Trouble: Quick fix...",
  },
  {
    "<leader>xq",
    "<Cmd>Trouble qflist toggle<CR>",
    desc = "Trouble: Quickfix list",
  },
  {
    "<leader>xs",
    "<Cmd>Trouble symbols toggle focus=false<CR>",
    desc = "Trouble: Symbols",
  },
  {
    "<leader>xr",
    "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
    desc = "Trouble: LSP definitions/references/...",
  },
  {
    "gR",
    "<Cmd>Trouble lsp_references toggle<CR>",
    desc = "Trouble: LSP reference",
  },

  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  {
    "<leader>xD",
    function()
      vim.diagnostic.open_float(0, { scope = "line" })
    end,
    desc = "Diagnostics: Show",
  },
  {
    "<leader>xL",
    vim.diagnostic.setloclist,
    desc = "Diagnostics: Set loc list",
  },
  {
    "[d",
    function()
      vim.diagnostic.goto_next({
        severity = get_highest_error_severity(),
        wrap = true,
        float = true,
      })
    end,
    desc = "Diagnostics: Next",
  },
  {
    "]d",
    function()
      vim.diagnostic.goto_prev({
        severity = get_highest_error_severity(),
        wrap = true,
        float = true,
      })
    end,
    desc = "Diagnostics: Previous",
  },
})

-- noice.nvim notifications ----------------------------------------
wk.add({
  {
    "<leader>nn",
    function()
      if package.loaded["notify"] ~= nil then
        require("notify").dismiss({ silent = true, pending = true })
      else
        require("noice").cmd("dismiss")
      end
    end,
    desc = "Notification: Dismiss all",
  },
})

-- LSP --------------------------------------------------------------
wk.add({
  { "cc",          group = "Comment" },
  { "<C>F", "<Cmd>FormatDocument<CR>", group = "Format" },
  {
    "<leader>ln",
    "<Cmd>NavBuddy<CR>",
    desc = "NavBuddy: Show symbol navigation",
  },
  -- toggle completion menu
  -- If the completion menu is visible it cancels the process.
  -- Else, it triggers the completion menu.
  {
    "<C-Space>",
    "<Cmd>lua require('cmp').complete()<CR>",
    desc = "Show auto-complete suggestion",
    mode = { "i" },
  },

  ---
  -- Folding
  ---
  {
    "zR",
    function()
      require("ufo").openAllFolds()
    end,
    desc = "Fold: Open all",
  },
  {
    "zM",
    function()
      require("ufo").closeAllFolds()
    end,
    desc = "Fold: Close all",
  },
  {
    "zr",
    function()
      require("ufo").openFoldsExceptKinds()
    end,
    desc = "Fold: Open except kinds",
  },
  {
    "zm",
    function()
      require("ufo").closeFoldsWith()
    end,
    desc = "Fold: Close with",
  },
  {
    "zK",
    function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end,
    desc = "Fold: Hover Definitions",
  },
  {
    "z[",
    function()
      local ufo = require("ufo")
      ufo.goPreviousClosedFold()
      ufo.peekFoldedLinesUnderCursor()
    end,
    desc = "Fold: Go previous closed",
  },
  {
    "z]",
    function()
      local ufo = require("ufo")
      ufo.goNextClosedFold()
      ufo.peekFoldedLinesUnderCursor()
    end,
    desc = "Fold: Go next closed",
  },

  -- TODO: Default Presets ???
  -- { "z<CR>", desc = "Top this line" },
  -- { "z=", desc = "Spelling suggestions" },
  -- { "zA", desc = "Toggle all folds under cursor" },
  -- { "zC", desc = "Close all folds under cursor" },
  -- { "zD", desc = "Delete all folds under cursor" },
  -- { "zE", desc = "Delete all folds in file" },
  -- { "zH", desc = "Half screen to the left" },
  -- { "zL", desc = "Half screen to the right" },
  -- { "zM", desc = "Close all folds" },
  -- { "zO", desc = "Open all folds under cursor" },
  -- { "zR", desc = "Open all folds" },
  -- { "za", desc = "Toggle fold under cursor" },
  -- { "zb", desc = "Bottom this line" },
  -- { "zc", desc = "Close fold under cursor" },
  -- { "zd", desc = "Delete fold under cursor" },
  -- { "ze", desc = "Right this line" },
  -- { "zg", desc = "Add word to spell list" },
  -- { "zi", desc = "Toggle folding" },
  -- { "zm", desc = "Fold more" },
  -- { "zo", desc = "Open fold under cursor" },
  -- { "zr", desc = "Fold less" },
  -- { "zs", desc = "Left this line" },
  -- { "zt", desc = "Top this line" },
  -- { "zv", desc = "Show cursor line" },
  -- { "zw", desc = "Mark word as bad/misspelling" },
  -- { "zx", desc = "Update folds" },
  -- { "zz", desc = "Center this line" },
})

-- ZenMode ----------------------------------------------------------
wk.add({
  { "Z", "<Cmd>ZenMode<CR>", desc = "ZenMode: Toggle", mode = { "n" } },
})
