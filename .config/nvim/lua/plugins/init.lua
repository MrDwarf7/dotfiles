return {
  -- { "stevearc/oil.nvim" },
  --
  -- { "neovim/nvim-lspconfig" },
  --
  -- { "mason-org/mason.nvim" },
  -- { "mason-org/mason-lspconfig.nvim" },
  -- { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  --
  -- { "folke/lazydev.nvim" },
  --
  -- { "Saghen/blink.compat" },
  -- { "L3MON4D3/LuaSnip" },
  -- { "rafamadriz/friendly-snippets" },
  -- { "Saghen/blink.cmp" },
  --
  -- { "stevearc/conform.nvim" },

  { "wsdjeg/vim-fetch" }, -- Allows easily opening a file at a given line number when passing in file:line on command line

  -- TODO: literally just make an autoccmd
  -- {
  -- 	"RRethy/vim-illuminate",
  -- 	opts = {
  -- 		delay = 200,
  -- 		large_file_cutoff = 2000,
  -- 		large_file_overrides = {
  -- 			providers = { "lsp" },
  -- 		},
  -- 	},
  -- },                                                          -- Highlights hovered words (can also be done via autocmd(s))

  { "HawkinsT/pathfinder.nvim", lazy = true, event = "BufReadPost" }, -- Enhances the gf, gF, and gx commands

  { "tridactyl/vim-tridactyl", ft = "tridactyl" }, -- Syntax HL for tridactylrc files

  -- TODO: later --

  { "nvim-lualine/lualine.nvim", lazy = true, event = "CursorMoved" },

  { "j-hui/fidget.nvim", opts = {} },
}
