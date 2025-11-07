local icons = require("doty.config").icons

require("mason").setup({
  -- The directory in which to install packages.
  -- install_root_dir = vim.fn.stdpath("data").."/mason",

  -- Where Mason should put its bin location in your PATH. Can be one of:
  -- - "prepend" (default, Mason's bin location is put first in PATH)
  -- - "append" (Mason's bin location is put at the end of PATH)
  -- - "skip" (doesn't modify PATH)
  ---@type '"prepend"' | '"append"' | '"skip"'
  PATH = "prepend",

  -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
  -- debugging issues with package installations.
  log_level = vim.log.levels.DEBUG,

  ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = true,

    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",

    -- Width of the window. Accepts:
    -- - Integer greater than 1 for fixed width.
    -- - Float in the range of 0-1 for a percentage of screen width.
    width = 0.8,
    -- Height of the window. Accepts:
    -- - Integer greater than 1 for fixed height.
    -- - Float in the range of 0-1 for a percentage of screen height.
    height = 0.9,

    icons = {
      -- The list icon to use for installed packages.
      package_installed = icons.status.success,
      -- The list icon to use for packages that are installing, or queued for installation.
      package_pending = icons.status.pending,
      -- The list icon to use for packages that are not installed.
      package_uninstalled = icons.status.failure,
    },

    keymaps = {
      -- Keymap to expand a package
      toggle_package_expand = "<Tab>",
      -- Keymap to install the package under the current cursor position
      install_package = "i",
      -- Keymap to reinstall/update the package under the current cursor position
      update_package = "u",
      -- Keymap to check for new version for the package under the current cursor position
      check_package_version = "c",
      -- Keymap to update all installed packages
      update_all_packages = "U",
      -- Keymap to check which installed packages are outdated
      check_outdated_packages = "C",
      -- Keymap to uninstall a package
      uninstall_package = "d",
      -- Keymap to cancel a package installation
      cancel_installation = "<C-c>",
      -- Keymap to apply language filter
      apply_language_filter = "<C-f>",
      -- Keymap to toggle viewing package installation log
      toggle_package_install_log = "<Tab>",
      -- Keymap to toggle the help view
      toggle_help = "<C-h>",
    },
  },
})
