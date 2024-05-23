local M = {}

M.lazy_custom_config = function()
	local table_set = {
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
	}
	return table_set
end

return M
