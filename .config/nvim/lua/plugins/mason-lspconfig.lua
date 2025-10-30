---@type LazyPluginBase
return {
  "mason-org/mason-lspconfig.nvim",
  -- lazy = false,
  lazy = true,
  -- ---@type LazyEventSpec
  -- event = "VeryLazy",
  dependencies = {
    { "mason-org/mason.nvim", lazy = true },
    { "neovim/nvim-lspconfig", lazy = true },
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
