-- vim.g.vscode = true

vim.cmd([[
nnoremap gd <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>
nnoremap gD <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Global
--
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
-- Powershell over CMD
vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag =
"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

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

-- New things I added from his config
vim.o.breakindent = true
vim.wo.number = true
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
vim.o.termguicolors = true -- Disabled as moved to init for lazy/notfiy


vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end


vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("base.plugins_list_vscode", {
	defaults = {
		lazy = true,
		vscode = true,
	},
	performance = {
		cache = {
			enabled = false,
			-- disable_events = {},
		},
		rtp = {
			disabled_plugins = {
				"indent-blankline.nvim",
				"gzip",
				--[[ "matchit", ]]
				--[[ "matchparen", ]]
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = {
		size = { width = 0.9, height = 0.9 },
		border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
	},
	checker = {
		-- automatically check for plugin updates
		enabled = false,
	},
})
