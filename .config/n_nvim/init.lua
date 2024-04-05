if vim.fn.has("nvim-0.9") == 1 then
	vim.loader.enable()
end

if vim.g.neovide then
	require("neovide")
end

if vim.g.vscode then
	require("options")
	require("mappings")
	require("autocmds")
else
	require("options")

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

	local lazy = require("lazy")
	local view_config = require("lazy.view.config")

	-- The custom settings for lazy, to keep the table handed over a bit cleaner
	local lazy_custom_config = {
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
			size = { width = 0.9, height = 0.9 },
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		},
	}

	-- view_config.keys.close = "<Esc>"

	lazy.setup("configs", lazy_custom_config)

	require("mappings")
	require("autocmds")
end

----------------
-- end

-- local M = {}
--
-- M.silence_notify = function()
-- 	local notify = require("notify")
-- 	vim.notify = function(msg, ...)
-- 		if msg:match("warning: multiple different client offset_encodings detected for buffer, this is not supported yet") then
-- 			return
-- 		end
-- 		notify(msg, ...)
-- 	end
-- end
-- return M
