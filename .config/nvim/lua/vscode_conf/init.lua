-- local vscode = require("vscode-neovim")
print("Vscode specific init file loads...")

local moveCursor = function(d)
	return function()
		if vim.v.count == 0 and vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
			return "g" .. d
		else
			return d
		end
	end
end

---@return table
local setup = function()
	if not vim.g.vscode then
		vim.g.vscode = nil
		return {}
	end

	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank({ timeout = 60 })
		end,
		group = vim.api.nvim_create_augroup("TextYank", { clear = true }),
	})

	vim.g.vscode_clipboard = vim.g.vscode_clipboard or "unnamedplus"
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	vim.keymap.set("", "k", moveCursor("k"), {
		expr = true,
		remap = true,
		silent = true,
	})

	vim.keymap.set("", "j", moveCursor("j"), {
		expr = true,
		remap = true,
		silent = true,
	})

	return {
		print("Init. returning..."),
		vim.cmd([[
		set clipboard+=unnamedplus
		]]),
	}
end

return {
	setup(),
}
