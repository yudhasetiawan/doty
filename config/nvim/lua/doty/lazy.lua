-- Install neovim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
  print(
    "You need to install the plugin manager lazy.nvim\n"
    .. "in this folder: "
    .. lazypath
  )
  return
end

-- Define the DOTY_DIRECTORY variable to avoid repeated calls
local doty_directory = os.getenv("DOTY_DIRECTORY")

lazy.setup("plugins", {
  defaults = {
    lazy = false,
  },
  git = {
    -- defaults for the `Lazy log` command
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
    -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
    -- then set the below to false. This should work, but is NOT supported and will
    -- increase downloads a lot.
    filter = true,
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    colorscheme = { "ayu" },
  },
  dev = {
    -- directory where you store your local plugin projects
    path = doty_directory .. "/config/nvim/plugins",
    -- Fallback to git when local plugin doesn't exist
    fallback = false,
  },
  -- checker = { enabled = true },
  debug = true,
  -- spec = {
  --     -- import/override with your plugins configuration inside "lua/plugins" directory
  --     { import = "plugins" },
  -- },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    -- get a notification when changes are found
    notify = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {            -- add any custom paths here that you want to includes in the rtp
        doty_directory .. "/config/nvim/after",
        doty_directory .. "/config/nvim",
      },
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        "2html_plugin",
        "bugreport",
        "compiler",
        -- "ftplugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        -- disable netrw at the very start of your init.lua
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "optwin",
        "remote_plugins",
        "rplugin",
        "rrhelper",
        "spellfile_plugin",
        "synmenu",
        "tar",
        "tarPlugin",
        "toHtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },

  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true,       -- get a notification when new updates are found
    frequency = 3600,    -- check for updates every hour
    check_pinned = true, -- check for pinned packages that can't be updated
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    enabled = true,
    root = vim.fn.stdpath("state") .. "/lazy/readme",
    files = {
      "README.md",
      "lua/**/README.md",
    },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
  state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things

  -- Enable profiling of lazy.nvim. This will add some overhead,
  -- so only enable this when you are debugging lazy.nvim
  profiling = {
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders
    loader = false,
    -- Track each new require in the Lazy profiling tab
    require = false,
  },

  ui = {
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
    size = { width = 0.7, height = 0.7 }, -- a number <1 is a percentage., >1 is a fixed size
    wrap = true,                          -- wrap the lines in the ui
    title = nil, ---@type string only works when border is not "none"
    title_pos = "center", ---@type "center" | "left" | "right"
    -- Show pills on top of the Lazy window
    pills = true, ---@type boolean
    icons = {
      cmd = "⌘",
      config = "🛠 ",
      event = "📅",
      ft = "📂",
      init = "⚙",
      import = " ",
      keys = "🗝 ",
      lazy = "💤 ",
      list = { "●", "➜", "★", "‒" },
      loaded = "●",
      not_loaded = "○",
      plugin = "🔌",
      runtime = "💻",
      require = "󰢱 ",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
    custom_keys = {
      -- You can define custom key maps here. If present, the description will
      -- be shown in the help menu.
      -- To disable one of the defaults, set it to false.
      ["<localleader>l"] = {
        function(plugin)
          require("lazy.util").float_term({ "lazygit", "log" }, {
            cwd = plugin.dir,
          })
        end,
        desc = "Open lazygit log",
      },

      ["<localleader>t"] = {
        function(plugin)
          require("lazy.util").float_term(nil, {
            cwd = plugin.dir,
          })
        end,
        desc = "Open terminal in plugin dir",
      },
    },
  },
  build = {
    -- Plugins can provide a `build.lua` file that will be executed when the plugin is installed
    -- or updated. When the plugin spec also has a `build` command, the plugin's `build.lua` not be
    -- executed. In this case, a warning message will be shown.
    warn_on_override = true,
  },
})
