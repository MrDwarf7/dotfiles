local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local highlight = vim.highlight
local opt = vim.opt

local MainAutoCmdGroup = augroup("MainAutoCmdGroup", { clear = true })
local LspAuGroup = augroup("LspAuGroup ", { clear = true })
local format_sync_grp = augroup("GoFormat", {})

autocmd("BufReadPost", {
	callback = function()
		require("util.last_pos").last_pos()
	end,
	group = MainAutoCmdGroup,
})

autocmd("TextYankPost", {
	callback = function()
		highlight.on_yank({ timeout = 60 })
	end,
	group = MainAutoCmdGroup,
})

autocmd({ "BufWritePre" }, {
	desc = "Strips white space on save",
	pattern = "*",
	command = [[%s/\s\+$//e]],
	group = MainAutoCmdGroup,
})

-- Auto resize window splits
autocmd("VimResized", {
	command = "wincmd =",
	group = MainAutoCmdGroup,
})

-- Set filetype for certain file-patterns.
autocmd("BufEnter", {
	pattern = "gitconfig",
	callback = function()
		opt.filetype = "gitconfig"
	end,
	group = MainAutoCmdGroup,
})

autocmd("BufEnter", {
	pattern = "fonts.conf",
	callback = function()
		opt.filetype = "xml"
	end,
	group = MainAutoCmdGroup,
})

autocmd("BufWinEnter", {
	desc = "Make q close help, man, quickfix, dap floats", -- Telescope and Mason and various other things
	callback = function(args)
		require("util.q_to_close").q_to_close(args)
	end,
	group = MainAutoCmdGroup,
})

autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
	desc = "URL Highlighting",
	callback = function()
		require("util.url_highlighting").url_highlight()
	end,
	group = MainAutoCmdGroup,
})

autocmd("LspAttach", {
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		-- local opts = { buffer = ev.buf }
		-- local vimlspbuf = vim.lsp.buf
		local opts = { silent = true, nowait = true, buffer = ev.buf }
		require("util.lsp-mappings").lsp_binds(opts)
	end,
	group = LspAuGroup,
})

autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").gofmt()
	end,
	group = format_sync_grp,
})

autocmd("VimEnter", {
	desc = "Auto select virtualenv Nvim open",
	pattern = "*",
	callback = function()
		local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
		if venv ~= "" then
			require("venv-selector").retrieve_from_cache()
		end
	end,
	once = true,
})
