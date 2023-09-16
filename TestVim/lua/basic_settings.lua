local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4

opt.scrolloff = 8
opt.sidescrolloff = 4
opt.preserveindent = true
opt.conceallevel = 0
opt.backspace = "indent,eol,start"
opt.shell = "pwsh"
opt.shellcmdflag =
	"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
opt.shellquote = ""
opt.shellxquote = ""
opt.writebackup = false

opt.fillchars = { eob = " " } -- disable `~` on nonexistent line
---@diagnostic disable-next-line: assign-type-mismatch
opt.foldcolumn = vim.fn.has("nvim-0.9") == 1 and "1" or nil
opt.showtabline = 2

vim.o.modelines = 0
vim.o.compatible = false

vim.o.backup = false

vim.g.skip_defaults_vim = 1

vim.o.exrc = 1

vim.o.number = true
vim.o.autoindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4 -- Covered above already under opt, no o
vim.o.shiftwidth = 4 -- Covered above already under opt, no o
vim.o.expandtab = true
vim.o.showcmd = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.linebreak = true
vim.o.hidden = true
vim.o.laststatus = 3
vim.o.cmdheight = 1

vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menu,menuone,noselect"

-- don't fold any text at startup
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.g.mapleader = " "
-- vim.g.maplocalleader = [[  ]]

vim.o.mouse = "a"
-- vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.o.termguicolors = true
-- vim.opt.tags:append(".tags;") -- ; means upper search parent directory with .tags file

local gui_cursor = {
	"n-v-c:block",
	"i-ci-ve:ver70",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
	"sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- 'Sauce_Code_Pro_Nerd_Font_Complete:h15',
-- 'IntoneMono_Nerd_Font_Mono:h16',
-- 'SF_Mono_Regular:h15',
-- 'Space_Mono_Nerd_Font_Complete:h15',
-- 'Monego_Nerd_Font_Fix:h15',
-- 'CaskaydiaCove_Nerd_Font_Mono:h15',
vim.o.guifont = "CaskaydiaCove_Nerd_Font_Mono:h12"
vim.o.guicursor = table.concat(gui_cursor, ",")
