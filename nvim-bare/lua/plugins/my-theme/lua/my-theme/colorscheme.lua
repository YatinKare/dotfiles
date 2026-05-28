local config = require 'my-theme.config'
local utils = require 'my-theme.utils'

local function read_hellwal_palette(path)
  local file = io.open(path, 'r')
  if not file then
    return nil
  end

  local palette = {}
  for line in file:lines() do
    local key, hex = line:match("^%s*([%w_]+)%s*=%s*['\"](#%x%x%x%x%x%x)['\"]")
    if key and hex then
      palette[key] = hex
    end
  end
  file:close()

  if not palette.background or not palette.foreground then
    return nil
  end

  return palette
end

local function from_hellwal()
  if not config.hellwal or not config.hellwal.enabled then
    return nil
  end

  local palette_file = vim.fn.expand(config.hellwal.palette_file)
  local palette = read_hellwal_palette(palette_file)
  if not palette then
    return nil
  end

  local bg = palette.background
  local fg = palette.foreground
  local border = palette.border or palette.color8 or palette.color7

  return {
    standardWhite = '#ffffff',
    standardBlack = '#1e1e1e',

    editorBackground = bg,
    sidebarBackground = utils.shade(bg, 0.1),
    popupBackground = utils.shade(bg, 0.15),
    floatingWindowBackground = utils.shade(bg, 0.18),
    menuOptionBackground = utils.shade(bg, 0.25),

    mainText = fg,
    emphasisText = palette.color15 or fg,
    commandText = palette.color7 or fg,
    inactiveText = palette.color8 or palette.color0,
    disabledText = utils.mix(fg, bg, 0.5),
    lineNumberText = palette.color8 or utils.mix(fg, bg, 0.45),
    selectedText = palette.color15 or fg,
    inactiveSelectionText = palette.color7 or fg,

    windowBorder = border,
    focusedBorder = palette.cursor or border,
    emphasizedBorder = palette.color7 or border,

    syntaxError = palette.color1 or palette.color9,
    syntaxFunction = palette.color4 or palette.color12,
    warningText = palette.color11 or palette.color3,
    syntaxKeyword = palette.color5 or palette.color13,
    linkText = palette.color6 or palette.color14,
    stringText = palette.color2 or palette.color10,
    warningEmphasis = palette.color3 or palette.color11,
    successText = palette.color10 or palette.color2,
    errorText = palette.color9 or palette.color1,
    specialKeyword = palette.color13 or palette.color5,
    commentText = palette.color8 or palette.color7,
    syntaxOperator = palette.color12 or palette.color4,
    foregroundEmphasis = palette.color15 or fg,
    terminalGray = palette.color8 or palette.color0,
  }
end

local colorscheme = {
  standardWhite = '#ffffff',
  standardBlack = '#1e1e1e',
}

local hellwal_colors = from_hellwal()
if hellwal_colors then
  return hellwal_colors
end

if vim.o.background == 'light' then
  colorscheme.editorBackground = '#ffffff'
  colorscheme.sidebarBackground = '#dddddd'
  colorscheme.popupBackground = '#f6f6f6'
  colorscheme.floatingWindowBackground = '#e0e0e0'
  colorscheme.menuOptionBackground = '#ededed'

  colorscheme.mainText = '#616161'
  colorscheme.emphasisText = '#212121'
  colorscheme.commandText = '#333333'
  colorscheme.inactiveText = '#9e9e9e'
  colorscheme.disabledText = '#d0d0d0'
  colorscheme.lineNumberText = '#a1a1a1'
  colorscheme.selectedText = '#424242'
  colorscheme.inactiveSelectionText = '#757575'

  colorscheme.windowBorder = '#c2c3c5'
  colorscheme.focusedBorder = '#aaaaaa'
  colorscheme.emphasizedBorder = '#999999'

  colorscheme.syntaxFunction = '#6871ff'
  colorscheme.syntaxError = '#d6656a'
  colorscheme.syntaxKeyword = '#9966cc'
  colorscheme.errorText = '#d32f2f'
  colorscheme.warningText = '#f29718'
  colorscheme.linkText = '#1976d2'
  colorscheme.commentText = '#848484'
  colorscheme.stringText = '#dd8500'
  colorscheme.successText = '#22863a'
  colorscheme.warningEmphasis = '#cd9731'
  colorscheme.specialKeyword = '#800080'
  colorscheme.syntaxOperator = '#a1a1a1'
  colorscheme.foregroundEmphasis = '#000000'
  colorscheme.terminalGray = '#333333'
else
  colorscheme.editorBackground = '#212121'
  colorscheme.sidebarBackground = '#1a1a1a'
  colorscheme.popupBackground = '#292929'
  colorscheme.floatingWindowBackground = '#383838'
  colorscheme.menuOptionBackground = '#282828'

  colorscheme.mainText = '#c1c1c1'
  colorscheme.emphasisText = '#fafafa'
  colorscheme.commandText = '#e0e0e0'
  colorscheme.inactiveText = '#484848'
  colorscheme.disabledText = '#848484'
  colorscheme.lineNumberText = '#727272'
  colorscheme.selectedText = '#eaeaea'
  colorscheme.inactiveSelectionText = '#f5f5f5'

  colorscheme.windowBorder = '#2a2a2a'
  colorscheme.focusedBorder = '#444444'
  colorscheme.emphasizedBorder = '#363636'

  colorscheme.syntaxError = '#ff7a84'
  colorscheme.syntaxFunction = '#79b8ff'
  colorscheme.warningText = '#ff9800'
  colorscheme.syntaxKeyword = '#b392f0'
  colorscheme.linkText = '#9db1c5'
  colorscheme.stringText = '#ffab70'
  colorscheme.warningEmphasis = '#cd9731'
  colorscheme.successText = '#22863a'
  colorscheme.errorText = '#cd3131'
  colorscheme.specialKeyword = '#800080'
  colorscheme.commentText = '#6b737c'
  colorscheme.syntaxOperator = '#bbbbbb'
  colorscheme.foregroundEmphasis = '#ffffff'
  colorscheme.terminalGray = '#5c5c5c'
end

return colorscheme
