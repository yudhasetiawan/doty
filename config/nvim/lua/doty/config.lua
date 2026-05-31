local M = {}

M.icons = {
  file = "",
  module = "",
  namespace = "",
  package = "",
  class = "",
  method = "",
  property = "",
  field = "",
  constructor = "",
  enum = "",
  interface = "",
  functions = "",
  variable = "󰫧",
  constant = "",
  string = "󰙩",
  number = "",
  boolean = "",
  array = "",
  object = "",
  key = "",
  null = "󰟢",
  enumMember = "",
  struct = "",
  event = "",
  operator = "",
  typeParameter = "",
  lsp = "",
  text = "󰉿",

  -- Log level
  ok = "",
  error = "",
  warning = "",
  info = "",
  hint = "",
  debug = "",
  trace = "✎",
  unknown_level = "",

  -- Comment
  fix = "",
  todo = "",
  hack = "󰈸",
  performance = "󰓅",
  test = "󰇉",

  -- Collapsible
  collapsible_open = "", -- icon used for open folds
  collapsible_closed = "", -- icon used for closed folds
  fold = "",

  symlink = "",

  status = {
    success = "",
    failure = "✗",
    pending = "➜",
  },

  dap = {
    expanded = "",
    collapsed = "",
    current_frame = "➜",
    controls = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
      disconnect = "",
    },
  },

  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },

  git = {
    branch = "",
    state = {
      unstaged = "✗",
      staged = "✓",
      unmerged = "",
      renamed = "➜",
      untracked = "★",
      deleted = "",
      ignored = "◌",
    },
    diff = {
      add = "",
      change = "󰝤",
      delete = "",
    },
  },

  vim_mode = {
    ["NORMAL"] = "󰒂",
    ["VISUAL"] = "",
    ["V-BLOCK"] = "",
    ["V-LINE"] = "󰕢", -- "󱂔",
    ["SELECT"] = "󰒅",
    ["S-LINE"] = "",
    ["S-BLOCK"] = "󰩬",
    ["REPLACE"] = "",
    ["V-REPLACE"] = "󰛔",
    ["INSERT"] = "󱚌", -- "󱅄",
    ["COMMAND"] = "",
    ["EX"] = "",
    ["MORE"] = "󰴤",
    ["CONFIRM"] = "󰔘",
    ["TERMINAL"] = "",
  },

  lualine = {
    component_separators = {
      left = "",
      right = "",
    },
    section_separators = {
      left = "",
      right = "",
    },
  },
}

M.symbols = {
  ---Modification indicator.
  ---
  ---@type string
  modified = "●",

  ---Truncation indicator.
  ---
  ---@type string
  ellipsis = "…",

  ---Entry separator.
  ---
  ---@type string
  separator = "",
}

M.colors = {
  bg = {
    sidebar = "#1f2430",
    editor = "#242936",
  },
  fg = {
    git = {
      ignore = "#707a8c",
    },
    diff = {
      add = "#87d96c",
      change = "#80bfff",
      delete = "#f27983",
      text = "#394b70",
    },

    comment = "#5c6773",

    error = "#ff6666",
    info = "#5ccfe6",
    warning = "#ffd173",
    hint = "#d5ff80",
    test = "#242936",
    unknown_title = "#7c3aed",
  },
  -- Color table for highlights
  -- stylua: ignore
  palette = {
    bg = '#242936',
    fg = '#cccac2',
    blue = '#51afef',
    cyan = '#008080',
    green = '#98be65',
    magenta = '#c678dd',
    orange = '#ff8800',
    red = '#ec5f67',
    yellow = '#ecbe7b',
    darkblue = '#081633',
    violet = '#a9a1e1',
    black = "#000000",
    white = "#ffffff",

    accent = "#ffd173",
    comment = "#5c6773",
    constant = "#d4bfff",
    entity = "#73d0ff",
    error = "#ff3333",
    fg_idle = "#607080",
    func = "#ffd580",
    guide_active = "#576070",
    guide_normal = "#383e4c",
    gutter_active = "#5f687a",
    gutter_normal = "#404755",
    keyword = "#ffa759",
    line = "#191e2a",
    lsp_parameter = "#d3b8f9",
    markup = "#f28779",
    operator = "#f29e74",
    panel_bg = "#232834",
    panel_border = "#101521",
    panel_shadow = "#141925",
    regexp = "#95e6cb",
    selection_bg = "#33415e",
    selection_border = "#232a4c",
    selection_inactive = "#323a4c",
    special = "#ffe6b3",
    string = "#bae67e",
    tag = "#5ccfe6",
    ui = "#707a8c",
    vcs_added = "#a6cc70",
    vcs_added_bg = "#313d37",
    vcs_modified = "#77a8d9",
    vcs_removed = "#f27983",
    vcs_removed_bg = "#3e373a",
    warning = "#ffa759",
  },
}

M.theme = "ayu" -- tokyonight-moon, ayu-mirage

-- enable greping in hidden files
M.telescope_grep_hidden = false

-- which patterns to ignore in file switcher
M.telescope_file_ignore_patterns = {
  "%.7z",
  "%.JPEG",
  "%.JPG",
  "%.MOV",
  "%.RAF",
  "%.burp",
  "%.bz2",
  "%.cache",
  "%.class",
  "%.dll",
  "%.docx",
  "%.dylib",
  "%.epub",
  "%.exe",
  "%.flac",
  "%.ico",
  "%.ipynb",
  "%.jar",
  "%.jpeg",
  "%.jpg",
  "%.lock",
  "%.mkv",
  "%.mov",
  "%.mp4",
  "%.otf",
  "%.pdb",
  "%.pdf",
  "%.png",
  "%.rar",
  "%.sqlite3",
  "%.svg",
  "%.tar",
  "%.tar.gz",
  "%.ttf",
  "%.webp",
  "%.zip",
  ".git/",
  ".gradle/",
  ".idea/",
  ".settings/",
  ".vale/",
  ".vscode/",
  "__pycache__/*",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "package-lock.json",
  "smalljre_*/*",
  "target/",
  "vendor/*",
}

return M
