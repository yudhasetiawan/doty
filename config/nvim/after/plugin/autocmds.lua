local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

--- Remove all trailing whitespace on save
api.nvim_create_autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true }),
})

-- Enable spell checking for certain file types
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  -- command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]]
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en"
  end,
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = api.nvim_buf_get_mark(0, '"')
    local lcount = api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = cursorGrp,
  pattern = "*",
  command = "set cursorline",
})
api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursorGrp,
  pattern = "*",
  command = "set nocursorline",
})

api.nvim_create_autocmd("LspAttach", {
  group = api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set(
        "n",
        keys,
        func,
        { buffer = event.buf, desc = "LSP: " .. desc }
      )
    end

    map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")

    map(
      "<leader>v",
      "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>",
      "Goto Definition in Vertical Split"
    )

    local wk = require("which-key")
    wk.add({
      {
        "<leader>la",
        vim.lsp.buf.code_action,
        desc = "Code Action",
      },
      {
        "<leader>lA",
        vim.lsp.buf.range_code_action,
        desc = "Range Code Actions",
      },
      {
        "<leader>ls",
        vim.lsp.buf.signature_help,
        desc = "Display Signature Information",
      },
      {
        "<leader>lr",
        vim.lsp.buf.rename,
        desc = "Rename all references",
      },
      {
        "<leader>lf",
        vim.lsp.buf.format,
        desc = "Format",
      },
      {
        "<leader>lc",
        require("doty.utils.functions").copyFilePathAndLineNumber,
        desc = "Copy File Path and Line Number",
      },
      {
        "<leader>Wa",
        vim.lsp.buf.add_workspace_folder,
        desc = "Workspace Add Folder",
      },
      {
        "<leader>Wr",
        vim.lsp.buf.remove_workspace_folder,
        desc = "Workspace Remove Folder",
      },
      {
        "<leader>Wl",
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        desc = "Workspace List Folders",
      },
    })

    local function client_supports_method(client, method, bufnr)
      if vim.fn.has("nvim-0.11") == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client_supports_method(
        client,
        vim.lsp.protocol.Methods.textDocument_documentHighlight,
        event.buf
      )
    then
      local highlight_augroup =
        api.nvim_create_augroup("lsp-highlight", { clear = false })
      api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      api.nvim_create_autocmd("LspDetach", {
        group = api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          api.nvim_clear_autocmds({
            group = "lsp-highlight",
            buffer = event2.buf,
          })
        end,
      })
    end

    if
      client
      and client_supports_method(
        client,
        vim.lsp.protocol.Methods.textDocument_inlayHint,
        event.buf
      )
    then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
        )
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})

-- wrap words "softly" (no carriage return) in mail buffer
api.nvim_create_autocmd("Filetype", {
  pattern = "mail",
  callback = function()
    vim.opt.textwidth = 0
    vim.opt.wrapmargin = 0
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.columns = 80
    vim.opt.colorcolumn = "80"
  end,
})

-- auto close brackets
-- this
api.nvim_create_autocmd(
  "FileType",
  { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] }
)

-- close some filetypes with <q>
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "startuptime",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n",
      "q",
      "<cmd>close<cr>",
      { buffer = event.buf, silent = true }
    )
  end,
})

-- fix terraform and hcl comment string
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup(
    "FixTerraformCommentString",
    { clear = true }
  ),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,

  pattern = { "terraform", "hcl" },
})
api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Enable autoread and set up checking triggers
vim.o.autoread = true
api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = "*",
})

-- resize neovim split when terminal is resized
api.nvim_command("autocmd VimResized * wincmd =")

vim.cmd([[ set nofoldenable]])
