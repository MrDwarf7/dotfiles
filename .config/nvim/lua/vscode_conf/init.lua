local V = {}

V.moveCursor = function(d)
	return function()
		if vim.v.count == 0 and vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
			return "g" .. d
		else
			return d
		end
	end
end

---@return nil
V.setup = function()
	-- local vscode = require("vscode-neovim")
	-- if not vim.g.vscode then
	-- 	vim.g.vscode = {}
	-- 	return
	-- end

	print("Vscode_conf loads after checking vscode global variable...")
	vim.g.vscode_clipboard = vim.g.vscode_clipboard or "unnamedplus"
	vim.cmd([[
	set clipboard+=unnamedplus
]])

	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	print("Vscode specific setup file loads...")
	local vs_nvim = require("vscode-neovim")
	-- local mvcur = require("vscode_conf.move_cursor")

	vim.keymap.set("", "k", V.moveCursor("k"), {
		expr = true,
		remap = true,
		silent = true,
	})

	vim.keymap.set("", "j", V.moveCursor("j"), {
		expr = true,
		remap = true,
		silent = true,
	})

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
