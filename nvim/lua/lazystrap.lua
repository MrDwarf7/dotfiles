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
    -- Will want to setup a section to call the 'custom' dir, for being able to store and swap customizable components,
    -- As well for an LSP folder to container all the LSP related nonesense.
    --
    spec = "plugins",
    defaults = { 
            lazy = false
        },
    concurrency = 50,
    install = {
        missing = true,
        -- colorscheme = { "tiagovla/tokyodark.nvim" },
    },
   checker = {
        enabled = true
        -- notfiy = false,
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
