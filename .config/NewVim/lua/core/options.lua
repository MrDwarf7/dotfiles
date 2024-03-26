--------

local architecture = require("util.architecture")
local env = vim.env
local opt = vim.opt
local g = vim.g
local fn = vim.fn
local cmd = vim.cmd

local exists = vim.fn.exists

-- Enable the Lua loader byte-compilation cache.
-- g.did_load_filetypes = 1

if architecture.is_windows() == true then
	vim.g.os = "win32"
elseif architecture.is_windows() == false then
	vim.g.os = "unix"
end

-- if architecture == "unix" then
-- 	vim.g.os = "unix"
-- elseif architecture == "win32" then
-- 	vim.g.os = "win32"
-- end

-- Global
opt.fillchars = {
	fold = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.listchars = {
	tab = ">>>",
	trail = "·",
	--[[ precedes = "←", ]]
	--[[ extends = "→",eol = "↲", ]]
	nbsp = "␣",
}

if architecture.is_windows() == true then
	opt.shell = "pwsh"
elseif architecture.is_windows() == false then
	opt.shell = "zsh"
end

opt.scrolloff = 6
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldnestmax = 4
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldexpr = "indent"
-- opt.foldmethod = "syntax"
--
opt.showtabline = 2
opt.mouse = "a"
opt.backupcopy = "yes"
opt.undolevels = 1000
opt.shortmess:append({ c = true, S = true })
opt.shortmess = vim.opt.shortmess + { c = true, s = true, C = true, F = true, I = true, S = true, W = true }
opt.showmode = false
opt.hidden = true
opt.splitright = true
opt.splitbelow = true
opt.wrapscan = true
opt.wrap = false -- Added, test with other plugins etc
opt.backup = false
opt.writebackup = false
opt.showcmd = true
opt.showmatch = true
opt.ignorecase = true
opt.hlsearch = true
opt.smartcase = true
opt.errorbells = false
opt.joinspaces = false
opt.title = true
opt.backspace = "indent,eol,start" -- Added
opt.encoding = "UTF-8"
opt.completeopt = { "menu", "menuone", "noselect" }

vim.cmd([[
set clipboard+=unnamedplus
]])

-- if vim.fn.has("unnamedplus") == 1 then
--     opt.clipboard = { "unnamed", "unnamedplus" }
-- else
--     opt.clipboard = "unnamed"
-- end

-- opt.clipboard = "unnamedplus"

opt.laststatus = 3
opt.timeoutlen = 350
if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "topline"
end

-- opt.wildcharm = vim.fn.char2nr("		")
-- opt.wildcharm = 3

-- Buffer
opt.fileformat = "unix"
opt.tabstop = 4
opt.spelllang = "en"
opt.softtabstop = 4
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 4
-- Window
opt.number = true
opt.colorcolumn = "+1"
opt.list = true
opt.signcolumn = "yes"
opt.relativenumber = true
opt.cursorline = true

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

g.loaded_node_provider = 1
g.loaded_python3_provider = 1
g.loaded_ruby_provider = 1

-- Use ripgrep as grep tool
vim.o.grepprg = "rg --vimgrep --no-heading"
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- New things I added from his config
vim.o.breakindent = true
vim.wo.number = true
vim.o.updatetime = 250
--vim.wo.signcolumn = "yes"
vim.o.termguicolors = true -- Disabled as moved to init for lazy/notfiy
g.skip_ts_context_commentstring_module = true
vim.cmd("colorscheme habamax")
