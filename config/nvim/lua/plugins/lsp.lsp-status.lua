return {
  {
    "nvim-lua/lsp-status.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local lsp_status = require("lsp-status")
      local icons = require("doty.config").icons

      -- completion_customize_lsp_label as used in completion-nvim
      -- Optional: customize the kind labels used in identifying the current function.
      -- g:completion_customize_lsp_label is a dict mapping from LSP symbol kind
      -- to the string you want to display as a label
      -- lsp_status.config { kind_labels = vim.g.completion_customize_lsp_label }

      -- Put this somewhere near lsp_status.register_progress()
      lsp_status.config({
        indicator_errors = " " .. icons.error,
        indicator_warnings = " " .. icons.warning,
        indicator_info = " " .. icons.info,
        indicator_hint = " " .. icons.hint,
        indicator_ok = " " .. icons.ok,
      })

      ---Attach lsp-status to capable LSPs on their initialization
      -- after the language server attaches to the current buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP Status Attacher",
        group = vim.api.nvim_create_augroup(
          "doty.lsp-status",
          { clear = true }
        ),
        callback = function(evt)
          local client = vim.lsp.get_client_by_id(evt.data.client_id)

          require("lsp-status").on_attach(client, evt.buf)
        end,
      })
    end,
  },
}
