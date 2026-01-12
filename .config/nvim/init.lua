-- local vimpack_path = vim.fn.stdpath("data") .. "/site/pack/core/opt"
-- vim.opt.rtp:prepend(vimpack_path)

require("config.options")
require("config.keymaps")
require("config.autocmds")

---@diagnostic disable-next-line: unused-local
local utils = require("utils")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

---@type LazyConfig
local lazy_opts = {
  -- debug = true,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,

    -- lazy = true,
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  },
  change_detection = {
    notify = false,
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = {
    path = require("utils.output").get_dev_dir(),
    -- path = "~/Documents/nvim_dev",
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy",
      -- disable_events = { "VimEnter", "BufReadPre" },
      ttl = 3600 * 24 * 7,
    },
    rtp = {
      -- disable some rtp plugins
      reset = true,
      disabled_plugins = {
        "2html_plugin",
        "bugreport",
        "compiler",
        "ftplugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        -- keep as disabled even after oil -- -- -- "netrw",
        -- "netrwFileHandlers",
        -- keep as disabled even after oil -- -- -- "netrwPlugin",
        -- "netrwSettings",
        "optwin",
        "rplugin",
        "rrhelper",
        "spellfile_plugin",
        "synmenu",
        "syntax",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
}

---@type Lazy
require("lazy").setup("plugins", lazy_opts)
-- lsp.setup({ binds_type = "builtin" })
local lsp = require("config.lsp")
lsp.setup({ binds_type = "fzf" })
