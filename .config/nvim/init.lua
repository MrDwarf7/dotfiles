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
	return require("vscode_conf").setup()
end

require("core.options")
require("core.mappings")
require("core.autocmds")
require("core.lazy")

----------------------------
