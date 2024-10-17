-- local architecture =
local opt = vim.opt
local g = vim.g
local check = require("util.check_if")

vim.lsp.inlay_hint.enable()

--- THIS WORKS............
vim.g.os = require("util.architecture").get_os()
if vim.g.os == "Windows_NT" then
	local powershell_opts = {
		shell = "pwsh",
		shellcmdflag = "-NoProfile -NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;",
		shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode',
		shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode',
		shellquote = "",
		shellxquote = "",

		-- Original settings
		-- shell = "pwsh",
		-- shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		-- shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		-- shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		-- shellquote = "",
		-- shellxquote = "",
	}
	for k, v in pairs(powershell_opts) do
		vim.o[k] = v
	end
end

if vim.g.os == "Windows_NT" then
	if check.smkdir(vim.g.os, "C:\\nvim_dev") then
		vim.g.my_dev = "C:\\nvim_dev"
	end
else
	local nix_dev = vim.fn.expand("$HOME") .. "/documents/nvim_dev"
	if check.smkdir(vim.g.os, nix_dev) then
		vim.g.my_dev = nix_dev
	end
end

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
	nbsp = "␣",
}

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

opt.pumblend = 15 -- Popup blend
opt.pumheight = 30 -- Maximum number of entries in a popup

opt.autowrite = true -- Enable auto write, so that modified buffers are written when switching buffers.
opt.conceallevel = 0
opt.formatoptions = "jcroqlnt" -- tcqj
opt.inccommand = "nosplit" -- preview incremental substitute
opt.shiftround = true -- Round indent
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 6 -- Minimum window width
vim.g.markdown_recommended_style = 0
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

opt.showtabline = 2
opt.mouse = "a"
opt.backupcopy = "yes"
opt.undolevels = 1000
opt.shortmess = { c = true, s = true, C = true, F = true, I = true, S = true, W = true }
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

opt.laststatus = 3
opt.timeoutlen = 350
if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "topline"
end

-- Buffer
opt.fileformat = "unix"
opt.tabstop = 4
opt.spelllang = "en"
opt.softtabstop = 4
opt.swapfile = false
opt.undofile = true

---@diagnostic disable-next-line: assign-type-mismatch
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

-- if vim.fn.has("nvim-0.10") == 1 then
opt.smoothscroll = true
-- end

-- g.loaded_node_provider = 1
-- g.loaded_python3_provider = 1
-- g.loaded_ruby_provider = 1

g.sql_type_default = "mssql"

-- Use ripgrep as grep tool
vim.o.grepprg = "rg --vimgrep --no-heading --smartcase --hidden"
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
vim.cmd("colorscheme default")
