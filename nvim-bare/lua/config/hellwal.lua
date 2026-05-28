local M = {}

local colors_vim_file = vim.fn.expand '~/.cache/hellwal/colors.vim'
local colors_lua_file = vim.fn.expand '~/.cache/hellwal/hellwal.lua'

local function notify_missing()
  vim.notify(
    "[HELLWAL]: no palette found in '~/.cache/hellwal/'. Run 'hellwal' first.",
    vim.log.levels.WARN
  )
end

local function load_palette_from_lua()
  if vim.fn.filereadable(colors_lua_file) == 0 then
    return nil
  end

  local lines = vim.fn.readfile(colors_lua_file)
  local palette = {}

  for _, line in ipairs(lines) do
    local key, value =
      line:match('^%s*([%w_]+)%s*=%s*["\'](#%x%x%x%x%x%x)["\']')
    if key and value then
      palette[key] = value
    end
  end

  if not palette.background or not palette.foreground or not palette.color0 then
    return nil
  end

  return {
    bg = palette.background,
    fg = palette.foreground,
    border = palette.border or palette.foreground,
    cursor = palette.cursor or palette.foreground,
    color_0 = palette.color0,
    color_1 = palette.color1,
    color_2 = palette.color2,
    color_3 = palette.color3,
    color_4 = palette.color4,
    color_5 = palette.color5,
    color_6 = palette.color6,
    color_7 = palette.color7,
    color_8 = palette.color8,
    color_9 = palette.color9,
    color_10 = palette.color10,
    color_11 = palette.color11,
    color_12 = palette.color12,
    color_13 = palette.color13,
    color_14 = palette.color14,
    color_15 = palette.color15,
  }
end

local function load_palette()
  if vim.fn.filereadable(colors_vim_file) == 1 then
    vim.cmd.source(vim.fn.fnameescape(colors_vim_file))

    if vim.g.hellwal_0 ~= nil then
      return {
        bg = vim.g.hellwal_background,
        fg = vim.g.hellwal_foreground,
        border = vim.g.hellwal_border,
        cursor = vim.g.hellwal_cursor,
        color_0 = vim.g.hellwal_0,
        color_1 = vim.g.hellwal_1,
        color_2 = vim.g.hellwal_2,
        color_3 = vim.g.hellwal_3,
        color_4 = vim.g.hellwal_4,
        color_5 = vim.g.hellwal_5,
        color_6 = vim.g.hellwal_6,
        color_7 = vim.g.hellwal_7,
        color_8 = vim.g.hellwal_8,
        color_9 = vim.g.hellwal_9,
        color_10 = vim.g.hellwal_10,
        color_11 = vim.g.hellwal_11,
        color_12 = vim.g.hellwal_12,
        color_13 = vim.g.hellwal_13,
        color_14 = vim.g.hellwal_14,
        color_15 = vim.g.hellwal_15,
      }
    end
  end

  local lua_palette = load_palette_from_lua()
  if lua_palette then
    return lua_palette
  end

  notify_missing()
  return nil
end

local function set_terminal_colors(c)
  vim.g.terminal_color_0 = c.color_0
  vim.g.terminal_color_1 = c.color_1
  vim.g.terminal_color_2 = c.color_2
  vim.g.terminal_color_3 = c.color_3
  vim.g.terminal_color_4 = c.color_4
  vim.g.terminal_color_5 = c.color_5
  vim.g.terminal_color_6 = c.color_6
  vim.g.terminal_color_7 = c.color_7
  vim.g.terminal_color_8 = c.color_8
  vim.g.terminal_color_9 = c.color_9
  vim.g.terminal_color_10 = c.color_10
  vim.g.terminal_color_11 = c.color_11
  vim.g.terminal_color_12 = c.color_12
  vim.g.terminal_color_13 = c.color_13
  vim.g.terminal_color_14 = c.color_14
  vim.g.terminal_color_15 = c.color_15
  vim.g.terminal_color_background = c.bg
  vim.g.terminal_color_foreground = c.fg
end

local function apply_groups(c)
  local groups = {
    ColorColumn = { bg = c.color_0 },
    Cursor = { fg = c.bg, bg = c.cursor },
    CursorColumn = { bg = c.color_8 },
    CursorLine = { bg = c.color_0 },
    CursorLineNr = { fg = c.color_8 },
    DiffAdd = { bg = c.color_2, bold = true },
    DiffChange = { bg = c.color_3, italic = true },
    DiffDelete = { fg = c.color_1, bg = 'NONE', bold = true },
    DiffText = { bg = c.color_4, bold = true },
    Directory = { fg = c.color_4 },
    Error = { fg = c.color_1, bg = c.color_0, bold = true },
    ErrorMsg = { link = 'Error' },
    FoldColumn = { fg = c.color_8, bg = c.bg },
    Folded = { fg = c.color_8, bg = c.bg, italic = true },
    IncSearch = { fg = c.color_0, bg = c.color_3, bold = true },
    LineNr = { fg = c.color_8, bg = 'NONE' },
    MatchParen = { fg = c.color_6, bg = 'NONE', bold = true },
    MoreMsg = { fg = c.color_4 },
    NonText = { fg = c.color_8, bg = 'NONE' },
    Normal = { fg = c.fg, bg = c.bg },
    NormalFloat = { fg = c.fg, bg = c.bg },
    FloatBorder = { fg = c.border, bg = c.bg },
    Pmenu = { fg = c.fg, bg = c.color_1 },
    PmenuSel = { fg = c.color_7, bg = c.color_2, bold = true },
    Question = { fg = c.color_6 },
    Search = { fg = c.color_0, bg = c.color_3, bold = true },
    SignColumn = { fg = c.fg, bg = c.bg },
    StatusLine = { fg = c.fg, bg = c.border, bold = true },
    StatusLineNC = { fg = c.color_8, bg = c.border, bold = true },
    Title = { fg = c.color_4, bold = true },
    Underlined = { fg = c.color_6, underline = true },
    VertSplit = { fg = c.color_8, bg = c.bg },
    WinSeparator = { link = 'VertSplit' },
    Visual = { bg = c.color_4 },
    WarningMsg = { fg = c.color_11, bold = true },
    WildMenu = { fg = c.color_7, bg = c.color_3, bold = true },

    Boolean = { fg = c.color_3 },
    Character = { fg = c.color_7 },
    Comment = { fg = c.color_2, italic = true },
    Conditional = { fg = c.color_5 },
    Constant = { fg = c.color_3, bold = true },
    Define = { fg = c.color_10 },
    Float = { fg = c.color_4 },
    Function = { fg = c.color_4 },
    Identifier = { fg = c.color_9 },
    Keyword = { fg = c.color_5, italic = true },
    Label = { fg = c.color_3 },
    Number = { fg = c.color_7 },
    Operator = { fg = c.color_9, bold = true },
    PreCondit = { fg = c.color_6 },
    PreProc = { fg = c.color_12, italic = true },
    Repeat = { fg = c.color_4 },
    Special = { fg = c.color_14, bold = true },
    SpecialComment = { fg = c.color_13, italic = true },
    SpecialKey = { fg = c.color_6 },
    SpellBad = { sp = c.color_1, undercurl = true },
    SpellCap = { fg = c.color_11 },
    SpellRare = { fg = c.color_8 },
    SpellLocal = { fg = c.color_12 },
    Statement = { fg = c.color_11, bold = true },
    StorageClass = { fg = c.color_14 },
    String = { fg = c.color_10, italic = true },
    Structure = { fg = c.color_7 },
    Tag = { fg = c.color_3, bold = true },
    Todo = { fg = c.color_15, bg = c.color_0, bold = true, italic = true },
    Type = { fg = c.color_6, bold = true },

    DiagnosticError = { fg = c.color_1 },
    DiagnosticWarn = { fg = c.color_11 },
    DiagnosticInfo = { fg = c.color_4 },
    DiagnosticHint = { fg = c.color_6 },
    DiagnosticUnderlineError = { sp = c.color_1, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.color_11, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.color_4, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.color_6, undercurl = true },

    cssAttr = { fg = c.color_12, bold = true },
    cssClassName = { fg = c.color_7 },
    cssColor = { fg = c.color_4 },
    cssFunctionName = { fg = c.color_3 },
    cssTagName = { fg = c.color_11 },

    javaScriptBoolean = { fg = c.color_9 },
    javaScriptFunction = { fg = c.color_4, bold = true },
    javaScriptOperator = { fg = c.color_8 },
    javaScriptStatement = { fg = c.color_7 },

    markdownCode = { fg = c.color_4, italic = true },
    markdownCodeBlock = { fg = c.color_4, bg = c.color_0 },
    markdownCodeDelimiter = { fg = c.color_9 },
    markdownHeadingDelimiter = { fg = c.color_9, bold = true },
    markdownUrl = { fg = c.color_6, underline = true },
    markdownLinkText = { fg = c.color_10, underline = true },
    markdownLinkDelimiter = { fg = c.color_8 },
    markdownLinkTitle = { fg = c.color_11 },
    markdownBold = { fg = c.color_3, bold = true },
    markdownItalic = { fg = c.color_2, italic = true },
    markdownBlockquote = { fg = c.color_5, italic = true },
    markdownListMarker = { fg = c.color_7, bold = true },
    markdownRule = { fg = c.color_12, bold = true },
    markdownIdDeclaration = { fg = c.color_13, bold = true },
    markdownStrikethrough = { fg = c.color_14, strikethrough = true },
    markdownTableDelimiter = { fg = c.color_9 },
    markdownFootnote = { fg = c.color_6, italic = true },
    markdownFootnoteDefinition = { fg = c.color_8, italic = true },
    markdownTask = { fg = c.color_4, bold = true },
    markdownMath = { fg = c.color_12, italic = true },
    markdownH1 = { fg = c.color_1, bold = true },
    markdownH2 = { fg = c.color_2, bold = true },
    markdownH3 = { fg = c.color_3, bold = true },
    markdownH4 = { fg = c.color_4, bold = true },
    markdownH5 = { fg = c.color_5, bold = true },
    markdownH6 = { fg = c.color_6, bold = true },
  }

  for group, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

function M.apply()
  local colors = load_palette()
  if not colors then
    return
  end

  vim.o.background = 'dark'
  vim.o.termguicolors = true
  vim.cmd 'highlight clear'
  if vim.fn.exists 'syntax_on' == 1 then
    vim.cmd 'syntax reset'
  end
  vim.g.colors_name = 'hellwal'

  set_terminal_colors(colors)
  apply_groups(colors)
end

function M.setup()
  vim.api.nvim_create_user_command('HellwalReload', function()
    M.apply()
  end, { desc = 'Reload Hellwal colors from ~/.cache/hellwal/' })

  M.apply()
end

return M
