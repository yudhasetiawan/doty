return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "yamatsum/nvim-nonicons",
      "nvim-tree/nvim-web-devicons",
      "f-person/git-blame.nvim",
      "tjdevries/colorbuddy.nvim",
      "folke/trouble.nvim",
    },
    opts = function()
      local ayu_theme = require("lualine.themes.ayu_mirage")
      local cfg = require("doty.config")
      local git_blame = require("gitblame")
      local nonIcons = require("nvim-nonicons")
      local icons = cfg.icons
      local colors = cfg.colors.palette

      vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text

      -- Change the background of lualine_c section for normal mode
      ayu_theme.normal.c.bg = colors.bg

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      -- local trouble_symbols = require("trouble").statusline({
      --   mode = "lsp_document_symbols",
      --   groups = {},
      --   title = false,
      --   filter = { range = true },
      --   format = "{kind_icon}{symbol.name:Normal}",
      --   -- The following line is needed to fix the background color
      --   -- Set it to the lualine section you want to use
      --   hl_group = "lualine_c_normal",
      -- })

      local lint_progress = function()
        local linters = require("lint").get_running()
        if #linters == 0 then
          return "󰦕"
        end
        return "󱉶 " .. table.concat(linters, ", ")
      end

      return {
        options = {
          icons_enabled = true,
          theme = ayu_theme,
          component_separators = {
            left = icons.lualine.component_separators.left,
            right = icons.lualine.component_separators.right,
          },
          section_separators = {
            left = icons.lualine.section_separators.left,
            right = icons.lualine.section_separators.right,
          },
          always_divide_middle = true,
          refresh = {
            statusline = 500,
            tabline = 500,
            winbar = 500,
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                  n = colors.darkblue,
                  i = colors.green,
                  v = colors.blue,
                  -- [''] = colors.blue,
                  V = colors.blue,
                  c = colors.magenta,
                  no = colors.red,
                  s = colors.orange,
                  S = colors.orange,
                  [""] = colors.orange,
                  ic = colors.yellow,
                  R = colors.violet,
                  Rv = colors.violet,
                  cv = colors.red,
                  ce = colors.red,
                  r = colors.cyan,
                  rm = colors.cyan,
                  ["r?"] = colors.cyan,
                  ["!"] = colors.red,
                  t = colors.red,
                }
                return {
                  gui = "italic,bold",
                  fg = mode_color[vim.fn.mode()],
                }
              end,
              fmt = function(str)
                if icons.vim_mode[str] ~= nil then
                  return "" .. icons.vim_mode[str]
                end

                return str:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            {
              "branch",
              icon = icons.git.branch,
            },
            {
              "diff",
              colored = true,
              -- Is it me or the symbol for modified us really weird
              symbols = {
                added = icons.git.diff.add .. " ",
                modified = icons.git.diff.change .. " ",
                removed = icons.git.diff.delete .. " ",
              },
              diff_color = {
                added = "LuaLineDiffAdd", -- Changes the diff's added color
                modified = "LuaLineDiffChange", -- Changes the diff's modified color
                removed = "LuaLineDiffDelete", -- Changes the diff's removed color you
              },
              cond = conditions.hide_in_width,
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              always_visible = false,
              symbols = {
                error = icons.error .. " ",
                warn = icons.warning .. " ",
                info = icons.info .. " ",
                hint = icons.hint .. " ",
              },
              diagnostics_color = {
                error = "DiagnosticError", -- Changes diagnostics' error color.
                warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
                info = "DiagnosticInfo", -- Changes diagnostics' info color.
                hint = "DiagnosticHint", -- Changes diagnostics' hint color.
              },
            },
          },
          lualine_c = {
            {
              git_blame.get_current_blame_text,
              cond = git_blame.is_blame_text_available,
            },
            "data",
            -- {
            --   trouble_symbols.get,
            --   cond = trouble_symbols.has,
            -- },
          },
          lualine_x = {
            {
              -- Lsp server name .
              function()
                local status = require("lsp-status").status()
                if status ~= nil then
                  return status
                end

                local msg = "No Lsp"
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                  return icons.lsp .. " " .. msg
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return icons.lsp .. " " .. client.name
                  end
                end

                return icons.lsp .. " " .. msg
              end,
              icon = icons.lsp,
              color = {
                fg = cfg.colors.fg.hint,
                gui = "bold",
              },
            },
          },
          lualine_y = {
            lint_progress,
            {
              "encoding",
              -- Show '[BOM]' when the file has a byte-order mark
              show_bomb = true,
              cond = conditions.hide_in_width,
            },
            {
              "filesize",
              cond = conditions.hide_in_width,
            },
            {
              "fileformat",
              cond = conditions.hide_in_width,
            },
            "filetype",
          },
          lualine_z = {
            {
              "searchcount",
              maxcount = 999,
            },
            "progress",
            "location",
          },
        },
        tabline = {
          lualine_a = {
            {
              "buffers",
              show_filename_only = true, -- Shows shortened relative path when set to false.
              hide_filename_extension = false, -- Hide filename extension when set to true.
              show_modified_status = true, -- Shows indicator when the buffer is modified.

              mode = 0, -- 0: Shows buffer name
              -- 1: Shows buffer index
              -- 2: Shows buffer name + buffer index
              -- 3: Shows buffer number
              -- 4: Shows buffer name + buffer number

              -- max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
              -- it can also be a function that returns
              -- the value of `max_length` dynamically.
              -- filetype_names = {
              --   TelescopePrompt = 'Telescope',
              --   dashboard = 'Dashboard',
              --   packer = 'Packer',
              --   fzf = 'FZF',
              --   alpha = 'Alpha'
              -- }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

              -- Automatically updates active buffer color to match color of other components (will be overridden if buffers_color is set)
              use_mode_colors = false,

              -- buffers_color = {
              --   -- Same values as the general color option can be used here.
              --   active = 'lualine_{section}_normal',     -- Color for active buffer.
              --   inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
              -- },

              symbols = {
                modified = " ", -- Text to show when the buffer is modified
                alternate_file = "󰯟 ", -- Text to show to identify the alternate file
                directory = "", -- Text to show when the buffer is a directory
              },
            },
            -- {
            --   'tabs',
            --   -- tab_max_length = 40,  -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
            --   -- max_length = vim.o.columns / 3, -- Maximum width of tabs component.
            --                                   -- Note:
            --                                   -- It can also be a function that returns
            --                                   -- the value of `max_length` dynamically.
            --   mode = 1, -- 0: Shows tab_nr
            --             -- 1: Shows tab_name
            --             -- 2: Shows tab_nr + tab_name
            --   path = 0, -- 0: just shows the filename
            --             -- 1: shows the relative path and shorten $HOME to ~
            --             -- 2: shows the full path
            --             -- 3: shows the full path and shorten $HOME to ~
            --   -- Automatically updates active tab color to match color of other components (will be overridden if buffers_color is set)
            --   use_mode_colors = true,
            --   -- tabs_color = {
            --   --   -- Same values as the general color option can be used here.
            --   --   active = 'lualine_{section}_normal',     -- Color for active tab.
            --   --   inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
            --   -- },
            --   show_modified_status = false,  -- Shows a symbol next to the tab name if the file has been modified.
            --   fmt = function(name, context)
            --     -- Show + if buffer is modified in tab
            --     local buflist = vim.fn.tabpagebuflist(context.tabnr)
            --     local winnr = vim.fn.tabpagewinnr(context.tabnr)
            --     local bufnr = buflist[winnr]
            --     local mod = vim.fn.getbufvar(bufnr, '&mod')
            --     local file = require('lualine.utils.utils').stl_escape(vim.api.nvim_buf_get_name(bufnr))
            --     local icon, _ = require('nvim-web-devicons').get_icon(file, vim.fn.expand('#' .. bufnr .. ':e'))

            --     return icon .. ' ' .. (mod == 1 and '[' .. name .. '] ' or name)
            --   end,
            -- }
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              "windows",
              show_filename_only = true, -- Shows shortened relative path when set to false.
              show_modified_status = true, -- Shows indicator when the window is modified.
              mode = 0, -- 0: Shows window name
              -- 1: Shows window index
              -- 2: Shows window name + window index
              max_length = vim.o.columns * 2 / 3, -- Maximum width of windows component,
              -- it can also be a function that returns
              -- the value of `max_length` dynamically.
              -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )
              filetype_names = {
                TelescopePrompt = "Telescope",
                dashboard = "Dashboard",
                packer = "Packer",
                fzf = "FZF",
                alpha = "Alpha",
              },
              disabled_buftypes = { "quickfix", "prompt" }, -- Hide a window if its buffer's type is disabled
              -- Automatically updates active window color to match color of other components (will be overridden if buffers_color is set)
              use_mode_colors = true,
              -- windows_color = {
              --   -- Same values as the general color option can be used here.
              --   active = 'lualine_{section}_normal',     -- Color for active window.
              --   inactive = 'lualine_{section}_inactive', -- Color for inactive window.
              -- },
            },
          },
        },
        -- winbar = {
        --   lualine_a = {},
        --   lualine_b = {'branch'},
        --   lualine_c = {'filename'},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {}
        -- },
        -- inactive_winbar = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = {'filename'},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {}
        -- },
        extensions = {
          "lazy",
          "mason",
          "man",
          "nvim-tree",
          "nvim-dap-ui",
          "quickfix",
          "trouble",
        },
      }
    end,
  },
}
