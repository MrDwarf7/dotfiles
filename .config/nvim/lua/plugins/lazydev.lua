---@type LazyPluginBase
return {
  "folke/lazydev.nvim",
  -- lazy = true,
  ft = "lua",
  opts = {
    library = {
      { path = "LazyVim", words = { "LazyVim" } },
      { path = "lazy.nvim", words = { "Lazy*" } },
      { path = "$VIMRUNTIME", words = { "vim" } },
      { path = "$VIMRUNTIME/lua", words = { "vim" } },
      { path = "lua", words = { "require", "pcall", "type", "vim" } },
      { path = "lua?.lua", words = { "require", "pcall", "type", "vim" } },
      { path = "lua/?/init.lua", words = { "require", "pcall", "type", "vim" } },

      { path = "neotest", words = { "neotest" } },
      { path = "plenary", words = { "plenary" } },

      { path = "wezterm-types", words = { "wezterm" } },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "${3rd}/busted/library", words = { "describe", "it", "before_each", "after_each" } },
      { path = "${3rd}/luaassert/library", words = { "assert" } },
    },
  },
}
