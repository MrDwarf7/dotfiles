return {
  "mason-org/mason-lspconfig.nvim",
  -- lazy = false,
  lazy = true,
  -- event = "VeryLazy",
  event = "BufReadPost",
  dependencies = {
    { "mason-org/mason.nvim", event = "BufReadPost" },
    { "neovim/nvim-lspconfig", event = "BufReadPost" },
  },
  -- opts = {
  --
  --
  --
  -- NOT NEEDED IF
  -- using mason-tool-installer
  --
  -- LSP's only -
  -- ensure_installed = {
  -- 	"lua_ls",
  -- 	"stylua",
  -- 	"hyprls",
  -- 	"tinymist",
  -- 	"taplo",
  -- },
  --
  --
  --
  -- },
}
