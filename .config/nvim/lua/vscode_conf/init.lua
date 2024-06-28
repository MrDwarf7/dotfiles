local V = {}

---@return nil
V.setup = function()
	-- local vscode = require("vscode-neovim")
	if not vim.g.vscode then
		vim.g.vscode = {}
		return
	end

	print("Vscode_conf loads after checking vscode global variable...")
	vim.g.vscode_clipboard = vim.g.vscode_clipboard or "unnamedplus"
	vim.cmd([[
	set clipboard+=unnamedplus
]])

	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	print("Vscode specific setup file loads...")
	require("vscode_conf.move_cursor")
	require("vscode_conf.actions")
	require("vscode_conf.options")
	require("vscode_conf.mappings")

	print("Vscode specific autocmds file loads...")
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank({ timeout = 60 })
		end,
		group = vim.api.nvim_create_augroup("TextYank", { clear = true }),
	})

	require("vscode_conf.plugins").vscode_plugins()



end

return V
