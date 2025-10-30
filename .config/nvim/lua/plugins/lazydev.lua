---@type LazyPluginBase
return {
  "folke/lazydev.nvim",
  -- lazy = true,
  ft = "lua",
  opts = {
    library = {
      { path = "LazyVim", words = { "LazyVim" } },
      { path = "wezterm-types", words = { "wezterm" } },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
