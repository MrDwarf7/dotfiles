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

-- local view_config = require("lazy.view.config")

-- The custom settings for lazy, to keep the table handed over a bit cleaner
-- local lazy_custom_config = require("util.lazy_config_table").lazy_custom_config()

require("lazy").setup({
	require("core.lazy_registrations"),
}, require("util.lazy_config_table").lazy_custom_config())
