local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local full_spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "lazyvim.plugins.extras.lang.python" },
  -- { import = "lazyvim.plugins.extras.vscode" },
  { import = "plugins" },
}
local vs_code_spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "lazyvim.plugins.extras.lang.python" },
  -- { import = "lazyvim.plugins.extras.vscode" },
  { import = "plugins", opts = { colorscheme = "" } },
}

if not vim.g.vscode then
  require("lazy").setup({
    spec = full_spec,
    defaults = {
      lazy = false,
      version = false, -- always use the latest git commit
    },
    -- install = {
    --   colorscheme = { "tokyonight", "habamax" },
    -- },
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
else
  require("lazy").setup({
    spec = vs_code_spec,
    defaults = {
      lazy = false,
      version = false, -- always use the latest git commit
    },
    colorscheme = { enabled = false, "" },
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
end
