return {
  settings = {
    Lua = {
      -- Configure completion settings
      completion = {
        callSnippet = "Replace",
      },
      -- Configure diagnostics
      diagnostics = {
        globals = { "vim" },
      },
      -- Configure workspace
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
  on_init = function(client, result)
    -- Set up the workspace configuration handler if lua_ls
    if client.name == "lua_ls" then
      client.handlers = vim.tbl_extend("error", {}, client.handlers)
      client.handlers["workspace/configuration"] = function(_, result, ctx)
        local client_id = ctx.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        if
            client
            and client.workspace_folders
            and #client.workspace_folders
        then
          if result.items and #result.items > 0 then
            if not result.items[1].scopeUri then
              return vim.tbl_map(function(_)
                return nil
              end, result.items)
            end
          end
        end

        return vim.lsp.handlers["workspace/configuration"](_, result, ctx)
      end
    end
  end
}
