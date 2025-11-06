local actions = require("telescope.actions")
local config = require("doty.config")
local icons = require("nvim-nonicons")
local telescope = require("telescope")

telescope.setup({
  extensions = {
    heading = {
      treesitter = true,
      picker_opts = {
        layout_config = { width = 0.8, preview_width = 0.5 },
        layout_strategy = "horizontal",
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
    file_browser = {
      theme = "ivy",
      hijack_netrw = false,
      hidden = true,
      mappings = {
        i = {
          ["<c-n>"] = telescope.extensions.file_browser.actions.create,
          ["<c-r>"] = telescope.extensions.file_browser.actions.rename,
          ["<c-h>"] = telescope.extensions.file_browser.actions.toggle_hidden,
          ["<c-x>"] = telescope.extensions.file_browser.actions.remove,
          ["<c-p>"] = telescope.extensions.file_browser.actions.move,
          ["<c-y>"] = telescope.extensions.file_browser.actions.copy,
          ["<c-a>"] = telescope.extensions.file_browser.actions.select_all,

          ["<C-h>"] = function()
            require("which-key").show({ global = false })
          end,
        },
      },
    },
  },
  pickers = {
    find_files = {
      hidden = false,
    },
    oldfiles = {
      cwd_only = true,
    },
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
    live_grep = {
      -- sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts),
      only_sort_text = true, -- grep for content and not file name/path
      mappings = {
        i = {
          ["<c-f>"] = actions.to_fuzzy_refine,

          ["<C-h>"] = function()
            require("which-key").show({ global = false })
          end,
        },
      },
    },
  },
  defaults = {
    selection_strategy = "follow",
    prompt_prefix = "  " .. icons.get("telescope") .. "  ",
    selection_caret = "❯ ",
    multi_icon = "",
    entry_prefix = "   ",
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    file_ignore_patterns = config.telescope_file_ignore_patterns,
    initial_mode = "insert",
    scroll_strategy = "cycle",
    sorting_strategy = "descending",
    -- layout_strategy = "vertical",
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = "top",
      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },
      vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
      flex = { horizontal = { preview_width = 0.9 } },
    },
    -- Format path and add custom highlighting
    -- path_display = { 'smart' },
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)
      path = string.format("%s (%s)", tail, path)

      local highlights = {
        {
          {
            0,       -- highlight start position
            #path,   -- highlight end position
          },
          "Comment", -- highlight group name
        },
      }

      return path, highlights
    end,
    mappings = {
      i = {
        ["<LeftMouse>"] = {
          actions.mouse_click,
          type = "action",
          opts = { expr = true },
        },
        ["<2-LeftMouse>"] = {
          actions.double_mouse_click,
          type = "action",
          opts = { expr = true },
        },

        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-f>"] = actions.preview_scrolling_left,
        ["<C-k>"] = actions.preview_scrolling_right,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<M-f>"] = actions.results_scrolling_left,
        ["<M-k>"] = actions.results_scrolling_right,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = false,
        ["<C-w>"] = { "<c-s-w>", type = "command" },
        ["<C-r><C-w>"] = actions.insert_original_cword,
        ["<C-r><C-a>"] = actions.insert_original_cWORD,
        ["<C-r><C-f>"] = actions.insert_original_cfile,
        ["<C-r><C-l>"] = actions.insert_original_cline,

        -- disable c-j because we dont want to allow new lines #2123
        ["<C-j>"] = actions.nop,
        -- actions.which_key shows the mappings for your picker,
        -- ["<C-h>"] = actions.which_key,
        ["<C-h>"] = function()
          require("which-key").show({ global = false })
        end,
      },
      n = {
        ["<LeftMouse>"] = {
          actions.mouse_click,
          type = "action",
          opts = { expr = true },
        },
        ["<2-LeftMouse>"] = {
          actions.double_mouse_click,
          type = "action",
          opts = { expr = true },
        },

        ["<esc>"] = actions.close,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        -- TODO: This would be weird if we switch the ordering.
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-f>"] = actions.preview_scrolling_left,
        ["<C-k>"] = actions.preview_scrolling_right,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<M-f>"] = actions.results_scrolling_left,
        ["<M-k>"] = actions.results_scrolling_right,

        -- ["?"] = actions.which_key,
        ["?"] = function()
          require("which-key").show({ global = false })
        end,
      },
    },
    preview = {
      treesitter = true,
    },
  },
})

-- telescope.load_extension("dap")
telescope.load_extension("file_browser")
telescope.load_extension("heading")
telescope.load_extension("lazygit")
telescope.load_extension("noice")
telescope.load_extension("notify")
telescope.load_extension("projects")
telescope.load_extension("ui-select")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup(
    "DotyTelescopeMakefile",
    { clear = true }
  ),
  pattern = { "makefile" },
  desc = "Enable telescope for makefile",
  callback = function()
    telescope.load_extension("make")
  end,
})
