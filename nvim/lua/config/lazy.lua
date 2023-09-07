--
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
-- Will want to setup a section to call the 'custom' dir, for being able to store and swap customizable components,
-- As well for an LSP folder to container all the LSP related nonesense.

require("lazy").setup("plugins", {
-- other plugin sub-dirs would go here as <, { import = "plugins.FOLDER" } > 
    -- spec = { "plugins" }, --Not currently using more than a single "module" // Dir of things.
   -- Also not using "sections" for things (Like "UI.lua" for all UI things) not super required atm.

    defaults = { 
            lazy = false
        },
   install = {
      missing = true,
      colorscheme = { "catppuccin" },
   },
   ui = {
      size = {
         width = 0.8, 
         height = 0.8
      },
      border = "rounded",
      -- icons = {},
   },
   browser = nil, -- Can specify a browser type as the PARENT here, so it will overwrite others below it during imports (I think)
   change_detection = {
      enabled = true,
      notify = false,
   },
   checker = {
      enabled = true,
      concurrency = 50, --Lower the number the lower updates are applied/installed when pulling or building
      notfiy = false,
      frequency = 3600 * 4, --Check once per hour
   },
   performance = {
      cache = {
         enabled = true,
         path = vim.fn.stdpath("cache") .. "/lazy/cache", -- Not sure I really have a reason to change the cache tbh.
         disable_events = { "VimEnter", "BufReadPre" },
         ttl = 3600 * 24 * 5, -- A time frame to keep modules (5 days here)
      },
      reset_packpath = true, -- Reset the package path to improve startup time
      rtp = {
         reset = true, -- Reset the runtime path to $VIMRUNTIME and your config dir ---- Not sure what this does tbh.
         disabled_plugins = {
            "gzip",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
         },
      },
   },
})
