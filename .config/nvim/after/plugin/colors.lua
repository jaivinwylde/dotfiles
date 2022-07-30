local background = "#1c1c1c"
local highlight = "#353535"

require("gruvbox").setup {
  contrast = "hard",
  overrides = {
    Normal = {
      bg = background
    },
    QuickScopePrimary = {
      bold = true,
      bg = "#cccccc",
      fg = background
    },
    QuickScopeSecondary = {
      bold = true,
      bg = "#888888",
      fg = background
    },
    SignColumn = {
      bg = background
    },
    IndentBlankLineChar = {
      fg = highlight,
      nocombine = true
    },
    IndentBlankLineSpaceChar = {
      fg = highlight,
      nocombine = true
    },
  }
}

Cmd("colorscheme gruvbox")
