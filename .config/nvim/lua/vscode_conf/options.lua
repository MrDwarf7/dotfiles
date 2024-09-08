print("Vscode specific options file loads...")

local opts = function()
	vim.notify = require("vscode-neovim").notify

	vim.opt.shortmess:append({ c = true, S = true })
	vim.opt.shortmess = vim.opt.shortmess + { c = true, s = true, C = true, F = true, I = true, S = true, W = true }
	vim.opt.showmode = true

	vim.opt.hidden = true
	vim.opt.splitright = true
	vim.opt.splitbelow = true
	vim.opt.wrapscan = true
	vim.opt.wrap = false -- Added, test with other plugins etc
	vim.opt.backup = false
	vim.opt.writebackup = false
	vim.opt.showmatch = true
	vim.opt.ignorecase = true
	vim.opt.hlsearch = true
	vim.opt.smartcase = true
	vim.opt.errorbells = false
	vim.opt.joinspaces = false
	vim.opt.backspace = "indent,eol,start" -- Added
	vim.opt.encoding = "UTF-8"
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	vim.cmd([[
set clipboard+=unnamedplus
]])

	vim.opt.laststatus = 3
	vim.opt.timeoutlen = 350
	-- if vim.fn.has("nvim-0.9.0") == 1 then
	-- 	vim.opt.splitkeep = "topline"
	-- end

	-- if vim.fn.has("nvim-0.10") == 1 then
	-- 	vim.opt.smoothscroll = true
	-- end

	-- Use ripgrep as grep tool
	vim.o.grepprg = "rg --vimgrep --no-heading --no-ignore --hidden"
	vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
	vim.o.breakindent = true
	vim.o.updatetime = 250
	vim.o.termguicolors = true -- Disabled as moved to init for lazy/notfiy
	vim.g.skip_ts_context_commentstring_module = true
end

return {
	opts(),
}
