-- https://github.com/bluz71/dotfiles/blob/master/nvim/init.lua
local fn = vim.fn

if fn.has("nvim-0.9") == 1 then
	vim.loader.enable()
end

if vim.g.neovide then
	require("core.neovide")
	require("core.options")
	require("core.mappings")
	-- require("core.autocmds")
end

if vim.g.vscode then
	print("Welcome to VSCode Neovim...")
	require("vscode-neovim")
	print("Local vscode required -> ")
	local v = require("vscode_conf").setup()
	-- require("core.options")
	-- require("core.mappings")
	-- require("core.autocmds")
	return v
end

require("core.options")
require("core.mappings")
require("core.autocmds")
require("core.lazy")

----------------------------
