-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

vim.g.maplocalleader = " "

vim.g.lazyvim_statuscolumn = {
	folds_open = true, -- show fold sign when fold is open
	folds_githl = true, -- highlight fold sign with git sign color
}

LazyVim.terminal.setup("pwsh")

opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
-- Use ripgrep as grep tool
vim.o.grepprg = "rg --vimgrep --no-heading"

----- Disabled to fiddle with sizes later
opt.pumblend = 15 -- Popup blend
opt.pumheight = 30 -- Maximum number of entries in a popup

opt.scrolloff = 6
opt.shiftwidth = 4
opt.shortmess:append({ s = true, F = true, S = true })
opt.splitkeep = "topline"
opt.tabstop = 4
vim.o.updatetime = 250
opt.winminwidth = 6 -- Minimum window width

--opt.timeoutlen = 350

---@diagnostic disable-next-line: assign-type-mismatch
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- opt.showcmd = true

--------- My stuff below that is from original nvim

opt.backspace = "indent,eol,start" -- Added
opt.wrapscan = true
opt.hidden = true
opt.autowrite = true -- Enable auto write, so that modified buffers are written when switching buffers.

opt.listchars = {
	tab = ">>>",
	trail = "·",
	nbsp = "␣",
}

-- opt.foldcolumn = "1"
-- opt.foldlevelstart = 99
-- opt.foldenable = true
opt.foldnestmax = 4
--
-- opt.conceallevel = 0
--
-- opt.showtabline = 2
-- opt.backupcopy = "yes"
-- opt.backup = false
-- opt.writebackup = false
-- opt.showmatch = true
-- opt.hlsearch = true
-- opt.errorbells = false
-- opt.joinspaces = false
-- opt.title = true
opt.encoding = "UTF-8"
--
-- vim.cmd([[
-- set clipboard+=unnamedplus
-- ]])
--
-- Buffer
opt.fileformat = "unix"
-- opt.softtabstop = 4
-- opt.swapfile = false
--
-- ---@diagnostic disable-next-line: assign-type-mismatch
-- opt.undodir = vim.fn.stdpath("data") .. "/undodir"
-- opt.expandtab = true
-- -- Window
-- opt.colorcolumn = "+1"
-- opt.cursorline = true
--
-- -- if vim.fn.has("nvim-0.10") == 1 then
-- -- end
--
-- -- g.loaded_node_provider = 1
-- -- g.loaded_python3_provider = 1
-- -- g.loaded_ruby_provider = 1
--
-- vim.o.foldcolumn = "1"
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true
--
-- -- New things I added from his config
-- vim.o.breakindent = true
-- vim.wo.number = true
--vim.wo.signcolumn = "yes"
vim.g.skip_ts_context_commentstring_module = true

vim.cmd("colorscheme default")
