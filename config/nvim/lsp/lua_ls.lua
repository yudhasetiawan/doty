return {
  -- Setup lua_ls and enable call snippets
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },

  on_init = function(client, result)
    -- Apply any existing on_init function
    if on_init then
      on_init(client, result)
    end

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
