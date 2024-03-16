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
					"tohtml",
					"getscript",
					"getscriptPlugin",
					"gzip",
					"logipat",
					-- "netrw",
					--"netrwPlugin",
					-- "netrwSettings",
					-- "netrwFileHandlers",
					"matchit",
					"tar",
					"tarPlugin",
					"rrhelper",
					"spellfile_plugin",
					"vimball",
					"vimballPlugin",
					"zip",
					"zipPlugin",
					"tutor",
					"rplugin",
					-- "syntax",
					-- "synmenu",
					-- "optwin",
					"compiler",
					"bugreport",
					"ftplugin",
				},
			},
		},
		ui = {
			size = { width = 0.8, height = 0.8 },
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		},
	}
	return table_set
end

return M
