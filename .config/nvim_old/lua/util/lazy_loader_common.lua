local M = {}

M.core_setup = function()
	return {
		require("core.options"),
		require("core.mappings"),
		require("core.autocmds"),
	}
end

M.common_setup = function()
	return {
		require("lazy").setup("configs", {
			dev = {
				path = vim.g.my_dev,
				fallback = true,
			},
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
end

M.base = function()
	return {
		M.core_setup(),
		M.common_setup(),
	}
end

return {
	M.base(),
	-- M.core_setup(),
	-- M.common_setup(),
}
