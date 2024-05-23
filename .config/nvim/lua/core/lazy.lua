-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
-- 	vim.fn.system({
-- 		"git",
-- 		"clone",
-- 		"--filter=blob:none",
-- 		"https://github.com/folke/lazy.nvim.git",
-- 		"--branch=stable", -- latest stable release
-- 		lazypath,
-- 	})
-- end
-- vim.opt.rtp:prepend(lazypath)

-- local view_config = require("lazy.view.config")

-- The custom settings for lazy, to keep the table handed over a bit cleaner
-- local lazy_custom_config = require("util.lazy_config_table").lazy_custom_config()

require("lazy").setup({
	-- spec = {
	import = "core.lazy_registrations",
	-- },
	-- require("core.lazy_registrations"),
}, {
	defaults = { lazy = true },
	performance = {
		cache = {
			enabled = true,
			path = vim.fn.stdpath("cache") .. "/lazy",
			-- disable_events = { "VimEnter", "BufReadPre" },
			ttl = 3600 * 24 * 7,
		},
		reset_packagepath = true,
		rtp = {
			reset = true,
			disabled_plugins = {
				"2html_plugin",
				"bugreport",
				"compiler",
				"ftplugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"matchit",
				-- "netrw",
				"netrwFileHandlers",
				-- "netrwPlugin",
				"netrwSettings",
				"optwin",
				"rplugin",
				"rrhelper",
				"spellfile_plugin",
				"synmenu",
				"syntax",
				"tar",
				"tarPlugin",
				"tohtml",
				"tutor",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
			},
		},
	},
	ui = {
		size = { width = 0.7, height = 0.7 },
		border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
	},
})

-- require("util.lazy_config_table").lazy_custom_config())
