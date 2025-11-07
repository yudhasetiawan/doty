--Enable (broadcasting) snippet capability for completion
local capabilitiesSnippet = vim.lsp.protocol.make_client_capabilities()
capabilitiesSnippet.textDocument.completion.completionItem.snippetSupport = true

return {
  capabilities = capabilitiesSnippet,
  settings = {
    json = {
      schema = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}
