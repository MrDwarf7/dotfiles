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

if vim.g.neovide == nil and vim.g.vscode == nil then
	return {
		require("core.options"),
		require("core.mappings"),
		require("core.autocmds"),

		require("lazy").setup("configs", {
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

if vim.g.vscode then
	print("Welcome to VSCode Neovim...")
	require("vscode-neovim")
	print("Local vscode required -> ")
	return require("vscode_conf").setup()
end

if vim.g.neovide then
	-- require("core.neovide")
	-- require("core.options")
	-- require("core.mappings")
	return {
		require("core.options"),
		require("core.mappings"),
		require("core.autocmds"),

		require("lazy").setup("configs", {
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
