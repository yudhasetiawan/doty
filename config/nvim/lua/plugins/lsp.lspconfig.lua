return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup format on save using native vim.lsp formatting
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.lua", "*.go", "*.rust" },
        callback = function()
          -- Use native vim.lsp.buf.format
          vim.lsp.buf.format({ async = true })
        end,
      })

      -- Set up formatexpr for gq operator using native LSP formatting
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.supports_method("textDocument/formatting") then
            -- Set up formatexpr to use LSP formatting for gq operator
            vim.bo[buffer].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})"
            
            -- Also set up format-on-save for all filetypes with LSP formatting support
            if not vim.b[buffer].native_format_on_save then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = buffer,
                callback = function()
                  vim.lsp.buf.format({ bufnr = buffer, timeout_ms = 5000 })
                end,
                desc = "Format file on save",
                group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false }),
              })
              vim.b[buffer].native_format_on_save = true
            end
          end
        end,
        desc = "LSP formatting setup",
      })

      -- Add custom file type detection
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
          [".*gitlab%-ci.*%.ya?ml"] = "yaml.gitlab",
          [".*/gitlab%-ci/.*%.ya?ml"] = "yaml.gitlab",
        },
      })

      -- Configure diagnostics with enhanced native vim.diagnostic features in v0.12+
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", -- Use a more subtle indicator
          spacing = 4,
          source = "if_many", -- Show source only if more than one
          format = function(diagnostic)
            -- Enhance diagnostic display with more context
            if diagnostic.source then
              return string.format("%s (%s)", diagnostic.message, diagnostic.source)
            end
            return diagnostic.message
          end,
        },
        severity_sort = true,
        signs = true,
        underline = true,
        update_in_insert = false, -- Changed to false for better performance
        float = {
          focusable = true, -- Allow focusing the diagnostic float
          style = "minimal",
          border = "rounded",
          source = "always",
          header = { "Diagnostic", "DiagnosticHeader" },
          prefix = "",
          max_width = 80,
          max_height = 20,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
        },
      })

      -- Set up diagnostic signs using native vim.fn.sign_define
      local icons = require("doty.config").icons
      for type, icon in pairs(icons) do
        local name = "DiagnosticSign" .. type:sub(1, 1):upper() .. type:sub(2)
        if icon then
          vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
        end
      end
    end,
  },
}