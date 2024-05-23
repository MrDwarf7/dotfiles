print("Vscode specific autocmds file loads...")
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local highlight = vim.highlight

local VsLastPost = augroup("LastPost", { clear = true })
local VsTextYank = augroup("TextYank", { clear = true })
local VsStripWhiteSpace = augroup("StripWhiteSpace", { clear = true })

autocmd("BufReadPost", {
	callback = function()
		require("util.last_pos").last_pos()
	end,
	group = VsLastPost,
})

autocmd("TextYankPost", {
	callback = function()
		highlight.on_yank({ timeout = 60 })
	end,
	group = VsTextYank,
})

autocmd({ "BufWritePre" }, {
	desc = "Strips white space on save",
	pattern = "*",
	command = [[%s/\s\+$//e]],
	group = VsStripWhiteSpace,
})
