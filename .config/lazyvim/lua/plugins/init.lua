return {
  -- DISABLED
  --#region disabled
  { "catppuccin/nvim", enabled = false },
  { "flash.nvim", enabled = false },
  { "refactoring.nvim", enabled = false }, -- ThePrimegean plugin for refacotring
  -- { "noice.nvim", enabled = false },
  -- { "markdown-preview.nvim", enable = false },
  --#endregion disabled

  { "wsdjeg/vim-fetch" }, -- Allows easily opening a file at a given line number when passing in file:line on command line

  { "snacks.nvim", opts = { words = { enabled = false } } },
  { "vim-illuminate" }, -- Highlights hovered words (can also be done via autocmd(s))

  { "tpope/vim-obsession", lazy = false }, -- Continuously updated session files

  { "HawkinsT/pathfinder.nvim" }, -- Enhances the gf, gF, and gx commands
  { "tridactyl/vim-tridactyl", ft = "tridactyl", opts = {} }, -- Syntax HL for tridactylrc files
}
