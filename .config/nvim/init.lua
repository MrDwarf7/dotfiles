-- https://github.com/bluz71/dotfiles/blob/master/nvim/init.lua
-- local fn = vim.fn

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- if fn.has("nvim-0.9") == 1 then
vim.loader.enable()
-- end

if vim.g.neovide then
	require("core.neovide")
	require("core.options")
	require("core.mappings")
	-- require("core.autocmds")
else
	if vim.g.vscode then
		print("Welcome to VSCode Neovim...")
		require("vscode-neovim")
		print("Local vscode required -> ")
		return require("vscode_conf").setup()
	end
end

require("core.options")
require("core.mappings")
require("core.autocmds")
require("core.lazy")

----------------------------
