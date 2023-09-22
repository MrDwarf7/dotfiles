local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local full_spec = {

  { "LazyVim/LazyVim",                            import = "lazyvim.plugins" },
  { import = "lazyvim.plugins.extras.lang.python" },

  -- add LazyVim and import its plugins
  -- { import = "lazyvim.plugins.extras.coding.copiot" },
  -- { import = "lazyvim.plugins.extras.linintg.eslint" },
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
  -- import any extras modules here
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.lang.json" },
  -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
  -- import/override with your plugins
  --
  { import = "plugins" },
}

require("lazy").setup({
  spec = full_spec,
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },
  checker = {
    enabled = true,
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
