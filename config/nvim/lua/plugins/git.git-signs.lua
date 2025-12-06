return {
  {
    -- Super fast git decorations implemented purely in Lua
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    dependencies = {
      "tjdevries/colorbuddy.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      local signs = require("gitsigns")
      local c = require("colorbuddy.color").colors
      local Group = require("colorbuddy.group").Group

      Group.new("GitSignsAdd", c.green)
      Group.new("GitSignsChange", c.yellow)
      Group.new("GitSignsDelete", c.red)

      signs.setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "│" },
          change = { text = "┃" },
          delete = { text = "▁" },
          topdelete = { text = "▔" },
          changedelete = { text = "~" },
        },

        -- When opening a file, a libuv watcher is placed on the respective
        -- `.git` directory to detect when changes happen to use as a trigger to
        -- update signs.
        watch_gitdir = { follow_files = true },

        -- Enable/disable symbols in the sign column (Toggle with `:Gitsigns toggle_signs`).
        -- When enabled the highlights defined in `signs.*.hl` and symbols defined
        -- in `signs.*.text` are used.
        signcolumn = true,
        -- Highlights just the number part of the number column (Toggle with `:Gitsigns toggle_numhl`).
        -- When enabled the highlights defined in `signs.*.numhl` are used. If
        -- the highlight group does not exist, then it is automatically defined
        -- and linked to the corresponding highlight group in `signs.*.hl`.
        numhl = true,
        -- Highlights the _whole_ line (Toggle with `:Gitsigns toggle_linehl`).
        -- When enabled the highlights defined in `signs.*.linehl` are used. If
        -- the highlight group does not exist, then it is automatically defined
        -- and linked to the corresponding highlight group in `signs.*.hl`.
        linehl = false,
        -- Highlights just the part of the line that has changed (Toggle with `:Gitsigns toggle_word_diff`)
        word_diff = false,

        count_chars = {
          [1] = "₁",
          [2] = "₂",
          [3] = "₃",
          [4] = "₄",
          [5] = "₅",
          [6] = "₆",
          [7] = "₇",
          [8] = "₈",
          [9] = "₉",
          ["+"] = "₊",
        },
        -- Option overrides for the Gitsigns preview window.
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },

        attach_to_untracked = true, -- Attach to untracked files.
        update_debounce = 500, -- Debounce time for updates (in milliseconds).
        -- Adds an unobtrusive and customisable blame annotation at the end of the current line.
        -- Overlapped with `git-blame`
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "       <author>  <author_time:%R>  <summary>",

        sign_priority = 6, -- Priority to use for signs.
        -- status_formatter = function(status)
        --   local added, changed, removed = status.added, status.changed, status.removed
        --   local status_txt = {}
        --   if added and added > 0 then
        --     table.insert(status_txt, '+' .. added)
        --   end
        --   if changed and changed > 0 then
        --     table.insert(status_txt, '~' .. changed)
        --   end
        --   if removed and removed > 0 then
        --     table.insert(status_txt, '-' .. removed)
        --   end
        --   return table.concat(status_txt, ' ')
        -- end,

        on_attach = function(bufnr)
          local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend(
              "force",
              { noremap = true, silent = true },
              opts or {}
            )
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end

          -- Navigation
          map(
            "n",
            "]c",
            "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<CR>'",
            { expr = true }
          )
          map(
            "n",
            "[c",
            "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<CR>'",
            { expr = true }
          )

          -- Actions
          map("n", "<leader>hs", "<Cmd>Gitsigns stage_hunk<CR>")
          map("v", "<leader>hs", "<Cmd>Gitsigns stage_hunk<CR>")
          map("n", "<leader>hr", "<Cmd>Gitsigns reset_hunk<CR>")
          map("v", "<leader>hr", "<Cmd>Gitsigns reset_hunk<CR>")
          map("n", "<leader>hS", "<Cmd>Gitsigns stage_buffer<CR>")
          map("n", "<leader>hu", "<Cmd>Gitsigns undo_stage_hunk<CR>")
          map("n", "<leader>hR", "<Cmd>Gitsigns reset_buffer<CR>")
          map("n", "<leader>hp", "<Cmd>Gitsigns preview_hunk<CR>")
          map(
            "n",
            "<leader>hb",
            '<Cmd>lua require"gitsigns".blame_line{full=true}<CR>'
          )
          map("n", "<leader>tb", "<Cmd>Gitsigns toggle_current_line_blame<CR>")
          map("n", "<leader>hd", "<Cmd>Gitsigns diffthis<CR>")
          map("n", "<leader>hD", '<Cmd>lua require"gitsigns".diffthis("~")<CR>')
          map("n", "<leader>td", "<Cmd>Gitsigns toggle_deleted<CR>")

          -- Text object
          map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
          map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },
}
