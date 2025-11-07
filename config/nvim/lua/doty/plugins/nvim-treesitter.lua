-- Treesitter configuration
-- This file sets up syntax parsing for various languages
-- It provides enhanced syntax highlighting and structural text objects
require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    "awk",
    "bash",
    "c",
    "cmake",
    "comment",
    "csv",
    "dockerfile",
    "dot",
    "editorconfig",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "gpg",
    "graphql",
    "hcl",
    "helm",
    "html",
    "http",
    "ini",
    "javascript",
    "jq",
    "json",
    "json5",
    "jsonnet",
    "llvm",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "mermaid",
    "nginx",
    "perl",
    "promql",
    "python",
    "query",
    "readline",
    "regex",
    "requirements",
    "rst",
    "sql",
    "rust",
    "scheme",
    "ssh_config",
    "terraform",
    "tmux",
    "todotxt",
    "toml",
    "tsv",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  indent = { enable = true },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>vv",
      node_incremental = "+",
      scope_incremental = false,
      node_decremental = "_",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "around a function" },
        ["if"] = {
          query = "@function.inner",
          desc = "inner part of a function",
        },
        ["ac"] = { query = "@class.outer", desc = "around a class" },
        ["ic"] = { query = "@class.inner", desc = "inner part of a class" },
        ["ai"] = {
          query = "@conditional.outer",
          desc = "around an if statement",
        },
        ["ii"] = {
          query = "@conditional.inner",
          desc = "inner part of an if statement",
        },
        ["al"] = { query = "@loop.outer", desc = "around a loop" },
        ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
        ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
        ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
      },
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@parameter.inner"] = "v", -- charwise
        ["@function.outer"] = "v", -- charwise
        ["@conditional.outer"] = "V", -- linewise
        ["@loop.outer"] = "V", -- linewise
        ["@class.outer"] = "<c-v>", -- blockwise
      },
      include_surrounding_whitespace = false,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "Previous function" },
        ["[c"] = { query = "@class.outer", desc = "Previous class" },
        ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
      },
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "Next function" },
        ["]c"] = { query = "@class.outer", desc = "Next class" },
        ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
})

-- Check for deprecated APIs
local api_level = vim.api.nvim_buf_line_count(0) -- Just to check if we're using current API
if vim.fn.has("nvim-0.10") == 1 then
  -- Enable newer features available in Neovim 0.10+
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
end

-- Only apply the highlighting on mise files instead of all toml files, the is-mise? predicate is used.
-- If you don't care for this distinction, the lines containing (#is-mise?) can be removed.
-- Otherwise, make sure to also create the predicate somewhere in your neovim config.
-- See: https://mise.jdx.dev/mise-cookbook/neovim.html#code-highlight-for-run-commands
require("vim.treesitter.query").add_predicate(
  "is-mise?",
  function(_, _, bufnr, _)
    local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
    local filename = vim.fn.fnamemodify(filepath, ":t")
    return string.match(filename, ".*mise.*%.toml$") ~= nil
  end,
  { force = true, all = false }
)
