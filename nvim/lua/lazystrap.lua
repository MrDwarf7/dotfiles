-- Bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "plugins",
    defaults = { 
            lazy = false
        },
    concurrency = 35,
    install = {
        missing = true,
        colorscheme = { "tiagovla/tokyodark.nvim" },
    },
   checker = {
        enabled = true
    },
    change_detection = {
        notify = false,

    },
   -- ui = {
   --     size = {
   --         width = 0.9,
   --         height = 0.9,
   --     },
   -- },
   -- performance = {
   --     rtp = {
   --         disabled_plugins = {
   --             --items here,
   --         },
   --     },
   -- }
})

--
