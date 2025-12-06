return {
  {
    -- Git
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
    },
    config = function()
      local neogit = require("neogit")

      neogit.setup({
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
        -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
        auto_refresh = true,
        -- Value used for `--sort` option for `git branch` command
        -- By default, branches will be sorted by commit date descending
        -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
        -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
        sort_branches = "-committerdate",
        disable_builtin_notifications = false,
        -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example
        -- below will use the native fzf sorter instead.
        telescope_sorter = function()
          return require("telescope").extensions.fzf.native_fzf_sorter()
        end,
        use_magit_keybindings = false,
        -- Change the default way of opening neogit
        kind = "tab",
        -- The time after which an output console is shown for slow running commands
        console_timeout = 2000,
        -- Automatically show console if a command takes more than console_timeout milliseconds
        auto_show_console = true,
        -- Persist the values of switches/options within and across sessions
        remember_settings = true,
        -- Scope persisted settings on a per-project basis
        use_per_project_settings = true,
        -- Array-like table of settings to never persist. Uses format "Filetype--cli-value"
        --   ie: `{ "NeogitCommitPopup--author", "NeogitCommitPopup--no-verify" }`
        ignored_settings = {},
        -- Change the default way of opening the commit popup
        commit_popup = { kind = "split" },
        -- Change the default way of opening the preview buffer
        preview_buffer = { kind = "split" },
        -- Change the default way of opening popups
        popup = { kind = "split" },
        -- customize displayed signs
        signs = {
          -- { CLOSED, OPENED }
          section = { ">", "v" },
          item = { ">", "v" },
          hunk = { "", "" },
        },
        -- Integrations are auto-detected, and enabled if available, but can be disabled by setting to "false"
        integrations = {
          -- If enabled, use telescope for menu selection rather than vim.ui.select.
          -- Allows multi-select and some things that vim.ui.select doesn't.
          telescope = false,

          -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
          -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
          --
          -- Requires you to have `sindrets/diffview.nvim` installed.
          -- use {
          --   'NeogitOrg/neogit',
          --   requires = {
          --     'nvim-lua/plenary.nvim',
          --     'sindrets/diffview.nvim'
          --   }
          -- }
          --
          diffview = true,
        },
        -- Setting any section to `false` will make the section not render at all
        sections = {
          untracked = { hidden = false },
          unstaged = { hidden = false },
          staged = { hidden = false },
          stashes = { hidden = true },
          unpulled = { folded = true, hidden = false },
          unmerged = { folded = false, hidden = false },
          recent = { hidden = true },
        },
        -- override/add mappings
        mappings = {
          -- modify status buffer mappings
          status = {
            -- Adds a mapping with "B" as key that does the "BranchPopup" command
            -- ["B"] = "BranchPopup",
            -- Removes the default mapping of "s"
            ["s"] = false,
          },
          -- Modify fuzzy-finder buffer mappings
          -- finder = {
          --     -- Binds <cr> to trigger select action
          --     ["<cr>"] = "select",
          -- }
        },
      })

      -- hi NeogitNotificationInfo guifg=#80ff95
      -- hi NeogitNotificationWarning guifg=#fff454
      -- hi NeogitNotificationError guifg=#c44323
      -- hi def NeogitDiffAddHighlight guibg=#404040 guifg=#859900
      -- hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f
      -- hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2
      -- hi def NeogitHunkHeader guifg=#cccccc guibg=#404040
      -- hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d

      -- git config --global merge.conflictStyle diff3

      vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
      vim.g.lazygit_floating_window_border_chars =
        "['╭','─', '╮', '│', '╯','─', '╰', '│']" -- customize lazygit popup window border characters
      vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
      vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

      vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
      vim.g.lazygit_config_file_path = "" -- custom config file path
    end,
  },
}
