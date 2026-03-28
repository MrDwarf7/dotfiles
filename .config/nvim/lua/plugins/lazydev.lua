return {
  "folke/lazydev.nvim",
  -- lazy = true,
  lazy = false,
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
      { path = "nvim-dap-ui" },

      { path = "wezterm-types", words = { "wezterm" } },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "${3rd}/busted/library", words = { "describe", "it", "before_each", "after_each" } },
      { path = "${3rd}/luaassert/library", words = { "assert" } },
    },
    integrations = {
      -- Fixes lspconfig's workspace management for LuaLS
      -- Only create a new workspace if the buffer is not part
      -- of an existing workspace or one of its libraries
      lspconfig = true,
      -- add the cmp source for completion of:
      -- `require "modname"`
      -- `---@module "modname"`
      blink = true,
      blink_modules = true,
      -- cmp = true,
      -- same, but for Coq
      -- coq = false,
    },
    ---@type boolean|(fun(root:string):boolean?)
    enabled = function(root_dir)
      return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
    end,
  },
}
