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
vim.loader.enable()

if vim.g.neovide == nil and vim.g.vscode == nil then
	return {
		require("util.lazy_loader_common"),
	}
elseif vim.g.vscode then
	print("Welcome to VSCode Neovim...")
	return { require("util.lazy_load_vscode") }
else
	return {
		require("core.neovide"),
		require("util.lazy_loader_common"),
	}
end
