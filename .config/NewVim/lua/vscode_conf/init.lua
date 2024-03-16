if not vim.g.vscode then
	vim.g.vscode = {}
	return
end

print("Vscode_conf loads after checking vscode global variable...")

vim.g.vscode_clipboard = vim.g.vscode_clipboard or "unnamedplus"
vim.cmd([[
set clipboard+=unnamedplus
]])

local V = {}
local vscode = require("vscode-neovim")

V.vscode_setup = function()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	-- vim.g.vscode.mapleader = " "
	-- vim.g.vscode.maplocalleader = " "

	print("Vscode specific setup file loads...")
	require("vscode_conf.options")
	require("vscode_conf.mappings")
	require("vscode_conf.autocmds")
	require("vscode_conf.plugins")
	require("vscode_conf.actions")
end

V.setup = function()
	local setup = V.vscode_setup()
	return setup
end

return V
