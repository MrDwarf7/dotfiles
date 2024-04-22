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

	local function moveCursor(direction)
		if vim.v.count == 0 and (vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "") then
			return ("g" .. direction)
		else
			return direction
		end
	end

	vim.keymap.set("n", "j", function()
		return moveCursor("j")
	end, { expr = true, remap = true })

	vim.keymap.set("n", "k", function()
		return moveCursor("k")
	end, { expr = true, remap = true })
	--

	print("Vscode specific setup file loads...")
	require("vscode_conf.actions")
	require("vscode_conf.options")
	require("vscode_conf.mappings")
	require("vscode_conf.autocmds")
	require("vscode_conf.plugins").vscode_plugins()
end

return V
