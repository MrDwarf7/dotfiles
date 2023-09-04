-- map = KEYMAPPINGS
local map = vim.api.nvim_set_keymap

-- opt = OPTIONS
local opt = vim.opt

-- Tab config
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- UI Config (bool)
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.splitbelow = true
opt.splitright = true
opt.showmode = true -- TEMP - On until install of lua line/buffline etc etc.
opt.termguicolors = true
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
