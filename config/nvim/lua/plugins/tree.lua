return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeRefresh",
    },
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local icons = require("doty.config").icons
      local nmap = require("doty.utils.functions").nmap

      local function default_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function map(key, action, desc)
          nmap(key, action, {
            desc = desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          })
        end

        -- BEGIN_DEFAULT_ON_ATTACH
        -- File Node
        map("<CR>", api.node.open.edit, "Open")
        map("<2-LeftMouse>", api.node.open.edit, "Open")
        map("<C-t>", api.node.open.tab, "Open: New Tab")
        map("<Tab>", api.node.open.preview, "Open Preview")
        map("<C-e>", api.node.open.replace_tree_buffer, "Open: In Place")

        map("<C-v>", api.node.open.vertical, "Open: Vertical Split")
        map("<C-x>", api.node.open.horizontal, "Open: Horizontal Split")
        map("L", api.node.open.toggle_group_empty, "Toggle Group Empty")
        map("O", api.node.open.no_window_picker, "Open: No Window Picker")

        map("<C-]>", api.tree.change_root_to_node, "CD")
        map("<2-RightMouse>", api.tree.change_root_to_node, "CD")
        map("-", api.tree.change_root_to_parent, "Up")
        map("<C-f>", api.tree.search_node, "Search")
        map("B", api.tree.toggle_no_buffer_filter, "Toggle Filter: No Buffer")
        map("C", api.tree.toggle_git_clean_filter, "Toggle Filter: Git Clean")
        map("H", api.tree.toggle_hidden_filter, "Toggle Filter: Dotfiles")
        map("I", api.tree.toggle_gitignore_filter, "Toggle Filter: Git Ignore")
        map(
          "M",
          api.tree.toggle_no_bookmark_filter,
          "Toggle Filter: No Bookmark"
        )
        map("U", api.tree.toggle_custom_filter, "Toggle Filter: Hidden")
        map("E", api.tree.expand_all, "Expand All")
        map("W", api.tree.collapse_all, "Collapse")
        map("R", api.tree.reload, "Refresh")
        map("q", api.tree.close, "Close")
        map("g?", api.tree.toggle_help, "Help")

        map("n", api.fs.create, "Create File Or Directory")
        map("x", api.fs.cut, "Cut")
        map("c", api.fs.copy.node, "Copy")
        map("p", api.fs.paste, "Paste")
        map("r", api.fs.rename, "Rename")
        map("u", api.fs.rename_full, "Rename: Full Path")
        map("e", api.fs.rename_basename, "Rename: Basename")
        map("<C-r>", api.fs.rename_sub, "Rename: Omit Filename")
        map("y", api.fs.copy.filename, "Copy Name")
        map("Y", api.fs.copy.relative_path, "Copy Relative Path")
        map("gy", api.fs.copy.absolute_path, "Copy Absolute Path")
        map("ge", api.fs.copy.basename, "Copy Basename")
        map("d", api.fs.trash, "Trash")
        map("D", api.fs.remove, "Delete")

        map("<C-k>", api.node.show_info_popup, "Info")
        map(".", api.node.run.cmd, "Run Command")
        map("s", api.node.run.system, "Run System")
        map("<BS>", api.node.navigate.parent_close, "Close Directory")
        map(">", api.node.navigate.sibling.next, "Next Sibling")
        map("<", api.node.navigate.sibling.prev, "Previous Sibling")
        map("[c", api.node.navigate.git.prev, "Prev Git")
        map("]c", api.node.navigate.git.next, "Next Git")
        map("]e", api.node.navigate.diagnostics.next, "Next Diagnostic")
        map("[e", api.node.navigate.diagnostics.prev, "Prev Diagnostic")
        map("J", api.node.navigate.sibling.last, "Last Sibling")
        map("K", api.node.navigate.sibling.first, "First Sibling")
        map("P", api.node.navigate.parent, "Parent Directory")

        map("m", api.marks.toggle, "Toggle Bookmark")
        map("bmv", api.marks.bulk.move, "Move Bookmarked")
        map("bt", api.marks.bulk.trash, "Trash Bookmarked")
        map("bd", api.marks.bulk.delete, "Delete Bookmarked")

        map("F", api.live_filter.clear, "Live Filter: Clear")
        map("f", api.live_filter.start, "Live Filter: Start")
        -- END_DEFAULT_ON_ATTACH

        -- custom mappings
        map("?", function()
          require("which-key").show({ global = false, buf = bufnr })
        end, "Nvim-Tree Keymaps")
        -- map('?', api.tree.toggle_help, 'Help')
      end

      require("nvim-tree").setup({
        on_attach = default_on_attach,
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        -- Add supports ahmedkhalf/project.nvim
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true,
          update_root = true,
        },
        -- END --
        -- sort_by = "case_sensitive",
        sort = {
          sorter = "case_sensitive",
        },
        filters = {
          dotfiles = false,
          custom = {
            "^.git$",
            "^.history$",
            "^.conform.",
            "^node_modules$",
            "^venv$",
            "^.venv$",
          },
        },
        git = {
          enable = false,
        },
        log = {
          enable = true,
          types = {
            diagnostics = true,
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          debounce_delay = 50,
          icons = {
            hint = icons.hint,
            info = icons.info,
            warning = icons.warning,
            error = icons.error,
          },
        },

        view = {
          width = 40,
          number = true,
          relativenumber = false,
        },
        -- respect_buf_cwd = true,
        renderer = {
          group_empty = true,
          highlight_git = true,
          special_files = {},
          icons = {
            glyphs = {
              default = "",
              symlink = icons.symlink,
              git = icons.git.state,
              folder = icons.folder,
            },
          },
        },
      })
    end,
  },
}
