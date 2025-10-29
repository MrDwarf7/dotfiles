-- local vscode = require("vscode-neovim")
print("Vscode specific init file loads...")
local vscode = require("vscode-neovim")

---@return table
local setup = function()
	if not vim.g.vscode then
		vim.g.vscode = nil
		return {}
	end
	local function mapMove(key, direction)
		-- print("Mapping move key: ", key, direction)
		vim.keymap.set("n", key, function()
			local count = vim.v.count
			local v = 1
			local style = "wrappedLine"
			if count > 0 then
				v = count
				style = "line"
			end
			vscode.action("cursorMove", {
				args = {
					to = direction,
					by = style,
					value = v,
				},
			})
		end)
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

	require("vscode_conf.actions")
	require("vscode_conf.mappings")
	require("vscode_conf.options")
	require("vscode_conf.plugins")

	return {
		mapMove("k", "up"),
		mapMove("j", "down"),
		print("Init. returning..."),
		vim.cmd([[
		set clipboard+=unnamedplus
		]]),
	}
end

return {
	setup(),
}
