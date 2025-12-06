return {
  {
    "kevinhwang91/nvim-ufo", -- Enable folds with nvim-ufo
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      local ufo = require("ufo")
      local icons = require("doty.config").icons

      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local function fallbackSelector(bufnr)
        local function handleFallbackException(err, providerName)
          if type(err) == "string" and err:match("UfoFallbackException") then
            return require("ufo").getFolds(bufnr, providerName)
          else
            return require("promise").reject(err)
          end
        end

        return require("ufo")
          .getFolds(bufnr, "lsp")
          :catch(function(err)
            return handleFallbackException(err, "treesitter")
          end)
          :catch(function(err)
            return handleFallbackException(err, "indent")
          end)
      end

      -- If ufo detect `foldmethod` option is not `diff` or `marker`, it will request the providers to get
      -- the folds, the request strategy is formed by the main and the fallback. The default value of main is
      -- `lsp` and the default value of fallback is `indent` which implemented by ufo.
      --
      -- For example, Changing the text in a buffer will request the providers for folds.
      --
      -- > `foldmethod` option will finally become `manual` if ufo is working.
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

      ufo.setup({
        -- a selector for fold providers. For now,
        -- there are 'lsp' and 'treesitter' as main provider, 'indent' as fallback provider.
        -- (Note: the `nvim-treesitter` plugin is *not* needed.)
        -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
        -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
        provider_selector = function(bufnr, filetype, buftype)
          -- if you prefer treesitter provider rather than lsp,
          local ftMap = {
            vim = "indent",
            python = { "indent" },
            git = "",
          }
          return ftMap[filetype] or fallbackSelector
        end,
        -- After the buffer is displayed (opened for the first time), close the
        -- folds whose range with `kind` field is included in this option. For now,
        -- 'lsp' provider's standardized kinds are 'comment', 'imports' and 'region',
        -- and the 'treesitter' provider exposes the underlying node types.
        -- This option is a table with filetype as key and fold kinds as value. Use a
        -- default value if value of filetype is absent.
        -- Run `UfoInspect` for details if your provider has extended the kinds.
        close_fold_kinds_for_ft = {
          default = { "imports", "comment" },
          json = { "array" },
          yaml = { "array" },
        },
        -- Configure the options for preview window and remap the keys for current
        -- buffer and preview buffer if the preview window is displayed.
        -- Never worry about the users's keymaps are overridden by ufo, ufo will save
        -- them and restore them if preview window is closed.
        preview = {
          win_config = {
            border = "rounded", -- {'', '─', '', '', '', '─', '', ''},
            winhighlight = "Normal:Folded",
            winblend = 10,
          },
          mappings = {
            -- | Function | Action                                                                                         | Def Key |
            -- | -------- | ---------------------------------------------------------------------------------------------- | ------- |
            -- | scrollB  | Type `CTRL-B` in preview window                                                                |         |
            -- | scrollF  | Type `CTRL-F` in preview window                                                                |         |
            -- | scrollU  | Type `CTRL-U` in preview window                                                                |         |
            -- | scrollD  | Type `CTRL-D` in preview window                                                                |         |
            -- | scrollE  | Type `CTRL-E` in preview window                                                                | `<C-E>` |
            -- | scrollY  | Type `CTRL-Y` in preview window                                                                | `<C-Y>` |
            -- | jumpTop  | Jump to top region in preview window                                                           |         |
            -- | jumpBot  | Jump to bottom region in preview window                                                        |         |
            -- | close    | In normal window: Close preview window<br>In preview window: Close preview window              | `q`     |
            -- | switch   | In normal window: Go to preview window<br>In preview window: Go to normal window               | `<Tab>` |
            -- | trace    | In normal window: Trace code based on topline<br>In preview window: Trace code based on cursor | `<CR>`  |
            scrollB = "<C-b>",
            scrollF = "<C-f>",
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            scrollE = "<C-E>",
            scrollY = "<C-Y>",
            jumpTop = "[",
            jumpBot = "]",
            close = "q",
            switch = "<Tab>",
            trace = "<CR>",
          },
        },
        -- A function customize fold virt text, see ### Customize fold text
        fold_virt_text_handler = function(
          virtText,
          lnum,
          endLnum,
          width,
          truncate
        )
          local newVirtText = {}
          local moreMessage = (" " .. icons.fold .. " %d"):format(
            endLnum - lnum
          )
          local suffix = " ⋯ "
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              -- str width returned from truncate() may less than 2nd argument, need padding
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix
                  .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { moreMessage, "MoreMsg" })
          table.insert(newVirtText, { suffix, "UfoFoldedEllipsis" })
          return newVirtText
        end,
      })

      ---Attach nvim-ufo to capable LSPs on their initialization
      -- after the language server attaches to the current buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP Status Attacher",
        group = vim.api.nvim_create_augroup("doty.nvim-ufo", { clear = true }),
        callback = function(evt)
          local client = vim.lsp.get_client_by_id(evt.data.client_id)

          require("ufo").attach(evt.buf)
        end,
      })
    end,
  },
}
