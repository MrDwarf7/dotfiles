-- This fix is no longer needed, huzzah!
-- local V = {}
--
-- local moveCursor = function(d)
-- 	return function()
-- 		if vim.v.count == 0 and vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
-- 			return "g" .. d
-- 		else
-- 			return d
-- 		end
-- 	end
-- end
--
--
-- vim.keymap.set("", "k", moveCursor("k"), {
-- 	expr = true,
-- 	remap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("", "j", moveCursor("j"), {
-- 	expr = true,
-- 	remap = true,
-- 	silent = true,
-- })

---@return table
local setup = function()
	-- local vscode = require("vscode-neovim")
	-- if not vim.g.vscode then
	-- 	vim.g.vscode = {}
	-- 	return
	-- end

	vim.g.vscode_clipboard = vim.g.vscode_clipboard or "unnamedplus"
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	return {
		print("Vscode_conf loads after checking vscode global variable..."),
		vim.cmd([[
		set clipboard+=unnamedplus
		]]),

		print("Vscode init.lua loads..."),
		require("vscode_conf.actions"),
		require("vscode_conf.options"),
		require("vscode_conf.mappings"),
		require("vscode_conf.plugins"),

		print("Vscode specific autocmds section loads..."),
		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				vim.highlight.on_yank({ timeout = 60 })
			end,
			group = vim.api.nvim_create_augroup("TextYank", { clear = true }),
		}),
	}
end

return {
	setup(),
}

-- return V
