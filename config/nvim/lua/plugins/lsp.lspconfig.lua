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

      -- Configure diagnostics with native vim.diagnostic
      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
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