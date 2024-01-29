vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Global
vim.opt.fillchars = {
	fold = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
vim.opt.listchars = {
	tab = ">>>",
	trail = "·",
	--[[ precedes = "←", ]]
	--[[ extends = "→",eol = "↲", ]]
	nbsp = "␣",
}

vim.opt.shell = "zsh"
vim.opt.scrolloff = 6
vim.opt.foldnestmax = 4
vim.opt.foldlevel = 1
vim.opt.foldcolumn = "1"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.showtabline = 2
vim.opt.mouse = "a"
vim.opt.backupcopy = "yes"
vim.opt.undolevels = 1000
vim.opt.shortmess:append({ c = true, S = true })
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrapscan = true
vim.opt.wrap = false -- Added, test with other plugins etc
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.errorbells = false
vim.opt.joinspaces = false
vim.opt.title = true
vim.opt.backspace = "indent,eol,start" -- Added
vim.opt.encoding = "UTF-8"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 3
vim.opt.timeoutlen = 350
if vim.fn.has("nvim-0.9.0") == 1 then
	vim.opt.splitkeep = "screen"
end
-- Buffer
vim.opt.fileformat = "unix"
vim.opt.tabstop = 4
vim.opt.spelllang = "en"
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
-- Window
vim.opt.number = true
vim.opt.colorcolumn = "+1"
vim.opt.list = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.cursorline = true

if vim.fn.has("nvim-0.10") == 1 then
	vim.opt.smoothscroll = true
end

-- New things I added from his config
vim.o.breakindent = true
vim.wo.number = true
vim.o.updatetime = 250
--vim.wo.signcolumn = "yes"
vim.o.termguicolors = true -- Disabled as moved to init for lazy/notfiy
vim.cmd("colorscheme habamax")
