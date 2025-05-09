-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.g.snacks_animate = true
vim.lsp.inlay_hint.enable()

vim.g.os = require("utils.arch").get_os()
vim.g.lazyvim_prettier_needs_config = true

-- vim.highlight = 55
