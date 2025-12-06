return {
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
      local icons = require("doty.config").icons

      -- Configure format on save using the native LSP format functionality
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.lua", "*.go", "*.rust" },
        callback = function(args)
          local clients = vim.lsp.get_clients({ bufnr = args.buf })
          for _, client in pairs(clients) do
            if client.supports_method("textDocument/formatting") then
              local timeout_ms = 10000
              vim.lsp.buf.format({
                async = false,
                timeout_ms = timeout_ms,
                filter = function(format_client)
                  return format_client.name == client.name
                end,
              })
              break
            end
          end
        end,
      })

      vim.filetype.add({
        extension = {
          ["alloy"] = "hcl.alloy",
        },
        pattern = {
          ["openapi.*%.ya?ml"] = "yaml.openapi",
          ["openapi.*%.json"] = "json.openapi",
          [".*openapi%.ya?ml"] = "yaml.openapi",
          [".*openapi%.json"] = "json.openapi",
          ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
          ["%.gitlab%-ci.*%.ya?ml"] = "yaml.gitlab",
          [".*/gitlab%-ci/.*%.ya?ml"] = "yaml.gitlab",
        },
      })

      -----------------------------------------------------------
      -- UI settings
      -----------------------------------------------------------
      -- Set up diagnostic UI configuration
      local border_style = vim.g.lsp_zero_ui_float_border
      if border_style == nil then
        border_style = "rounded"
      end

      if type(border_style) == "string" then
        vim.diagnostic.config({
          virtual_text = false,
          severity_sort = true,
          signs = true,
          underline = true,
          update_in_insert = true,
          float = {
            focusable = false,
            style = "minimal",
            border = border_style,
            source = "always",
            header = "",
            prefix = "",
          },
        })
      end

      -- Set up diagnostic signs with icons
      local sign_define = function(name, text, texthl)
        vim.fn.sign_define(name, { text = text, texthl = texthl, numhl = "" })
      end

      sign_define("DiagnosticSignError", icons.error, "DiagnosticSignError")
      sign_define("DiagnosticSignWarn", icons.warning, "DiagnosticSignWarn")
      sign_define("DiagnosticSignInfo", icons.info, "DiagnosticSignInfo")
      sign_define("DiagnosticSignHint", icons.hint, "DiagnosticSignHint")
    end,
  },
}
