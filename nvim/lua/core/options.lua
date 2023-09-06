-- Options can be tested out via :options
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
opt.scrolloff = 10 --Scrolloff maintains a margin at top or bottom of screen.
vim.opt.splitkeep = "screen" -- Keep the same position on the page when h-split

-- Case in-sensitive searching
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
opt.cursorlineopt = "line"
opt.showmode = true -- TEMP - On until install of lua line/buffline etc etc.

opt.termguicolors = true
opt.incsearch = true
opt.hlsearch = true


opt.updatetime = 250 
opt.timeoutlen = 300 -- Time to wait for mapped sequence to comp.



-- Window splitting
opt.splitbelow = true
opt.splitright = true

opt.wrap = false
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace setting
opt.backspace = "indent,eol,start"


-- Clipboard
opt.clipboard:append("unnamedplus")


-- Disable swapfile
opt.swapfile = false
