-- local V = {}

return {
	require("lazy").setup("vscode_conf", {
		defaults = { lazy = true },
		change_detection = {
			notify = false,
		},
		performance = {
			cache = {
				-- enabled = true,
				path = vim.fn.stdpath("cache") .. "/lazy",
				-- disable_events = { "VimEnter", "BufReadPre" },
				ttl = 3600 * 24 * 7,
			},
			-- reset_packagepath = true,
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
	}),
}
