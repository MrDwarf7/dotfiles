if vim.g.neovide then
	require("neovide")
end

if vim.g.vscode then
	require("options")
	require("mappings")
	require("autocmds")
else
	require("options")
	require("mappings")
	require("autocmds")

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

	require("lazy").setup("configs", {
		defaults = { lazy = true },
		performance = {
			cache = {
				enabled = true,
			},

			rtp = {
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
	})
end
