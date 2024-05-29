local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local highlight = vim.highlight
local opt = vim.opt

local MainAutoCmdGroup = augroup("MainAutoCmdGroup", { clear = true })
local GitConfig = augroup("GitConfig", { clear = true })
-- local LspAuGroup = augroup("LspAuGroup", { clear = true })
local format_sync_grp = augroup("GoFormat", {})
local QToClose = augroup("QToClose", { clear = true })
local UrlHighliting = augroup("UrlHighliting", { clear = true })
local LastPost = augroup("LastPost", { clear = true })
local TextYank = augroup("TextYank", { clear = true })
local StripWhiteSpace = augroup("StripWhiteSpace", { clear = true })
local AutoResize = augroup("AutoResize", { clear = true })
local XmlParser = augroup("XmlParser", { clear = true })

autocmd("TextYankPost", {
	callback = function()
		highlight.on_yank({ timeout = 60 })
	end,
	group = TextYank,
})

-- Set filetype for certain file-patterns.
autocmd("BufEnter", {
	pattern = "gitconfig",
	callback = function()
		opt.filetype = "gitconfig"
	end,
	group = GitConfig,
})

autocmd("BufEnter", {
	pattern = "fonts.conf",
	callback = function()
		opt.filetype = "xml"
	end,
	group = XmlParser,
})

autocmd("BufWinEnter", {
	desc = "Make q close help, man, quickfix, dap floats", -- Telescope and Mason and various other things
	callback = function(args)
		local opt_val = vim.api.nvim_get_option_value
		local t_con = vim.tbl_contains
		local map = vim.keymap.set
		local fn = vim.fn

		local buftype = opt_val("buftype", { buf = args.buf })
		if
			t_con({
				"help",
				"nofile",
				"quickfix",
				"LspInfo",
				":LspSaga",
			}, buftype) and fn.maparg("q", "n") == ""
		then
			map("n", "q", "<cmd>close<cr>", {
				desc = "Close window",
				buffer = args.buf,
				silent = true,
				nowait = true,
			})
		end

		-- require("util.q_to_close").q_to_close(args)
	end,
	group = QToClose,
})

autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").gofmt()
	end,
	group = format_sync_grp,
})

-- autocmd({ "BufWritePost" }, {
-- 	callback = function()
-- 		require("lint").try_lint()
-- 	end,
-- })

-- autocmd("VimEnter", {
-- 	desc = "Auto select virtualenv Nvim open",
-- 	-- pattern = "*",
-- 	callback = function()
-- 		local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
-- 		if venv ~= "" then
-- 			require("venv-selector").retrieve_from_cache()
-- 		end
-- 	end,
-- 	once = true,
-- })

-----------------

-- autocmd("BufReadPost", {
-- 	callback = function()
-- 		local last_pos = vim.fn.line("'\"")
-- 		if last_pos > 0 and last_pos <= vim.fn.line("$") then
-- 			vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
-- 		end
-- 		-- require("util.last_pos").last_pos()
-- 	end,
-- 	group = LastPost,
-- })

-- autocmd({ "BufWritePre" }, {
-- 	desc = "Strips white space on save",
-- 	pattern = "*",
-- 	command = [[%s/\s\+$//e]],
-- 	group = StripWhiteSpace,
-- })

-- Auto resize window splits
-- autocmd("VimResized", {
-- 	command = "wincmd =",
-- 	group = AutoResize,
-- })

-- autocmd({ "VimEnter", "FileType", "BufReadPost" }, {
-- 	desc = "URL Highlighting",
-- 	pattern = "*.*",
-- 	callback = function()
-- 		local fn = vim.fn
-- 		local g = vim.g
--
-- 		vim.cmd([[
--     hi def link url Underlined
--     hi def link mailTo Underlined
--   ]])
-- 		local url_matcher =
-- 			"\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+"
-- 		--- Delete the syntax matching rules for URLs/URIs if set
-- 		local function delete_url_match()
-- 			for _, match in ipairs(fn.getmatches()) do
-- 				if match.group == "HighlightURL" then
-- 					fn.matchdelete(match.id)
-- 				end
-- 			end
-- 		end
-- 		--- Add syntax matching rules for highlighting URLs/URIs
-- 		local function set_url_match()
-- 			delete_url_match()
-- 			if g.highlighturl_enabled then
-- 				fn.matchadd("HighlightURL", url_matcher, 15)
-- 			end
-- 		end
-- 		set_url_match()
--
-- 		-- require("util.url_highlighting").url_highlight()
-- 	end,
-- 	group = UrlHighliting,
-- })
