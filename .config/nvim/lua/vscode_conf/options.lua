print("Vscode specific options file loads...")
local vscode = require("vscode-neovim")
local opt = vim.opt
local g = vim.g
local fn = vim.fn
local cmd = vim.cmd

local exists = vim.fn.exists

vim.notify = vscode.notify

opt.shortmess:append({ c = true, S = true })
opt.shortmess = vim.opt.shortmess + { c = true, s = true, C = true, F = true, I = true, S = true, W = true }
opt.showmode = true

opt.hidden = true
opt.splitright = true
opt.splitbelow = true
opt.wrapscan = true
opt.wrap = false -- Added, test with other plugins etc
opt.backup = false
opt.writebackup = false
-- opt.showcmd = true
opt.showmatch = true
opt.ignorecase = true
opt.hlsearch = true
opt.smartcase = true
opt.errorbells = false
opt.joinspaces = false
-- opt.title = true
opt.backspace = "indent,eol,start" -- Added
opt.encoding = "UTF-8"
opt.completeopt = { "menu", "menuone", "noselect" }

vim.cmd([[
set clipboard+=unnamedplus
]])

opt.laststatus = 3
opt.timeoutlen = 350
if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "topline"
end

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

-- Use ripgrep as grep tool
vim.o.grepprg = "rg --vimgrep --no-heading"
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"

vim.o.breakindent = true
-- vim.wo.number = true
vim.o.updatetime = 250
--vim.wo.signcolumn = "yes"
vim.o.termguicolors = true -- Disabled as moved to init for lazy/notfiy
g.skip_ts_context_commentstring_module = true
