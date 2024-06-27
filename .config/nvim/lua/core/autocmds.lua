local UserAutoCmd = vim.api.nvim_create_augroup("UserAutoCmd", { clear = true })
local GitConfig = vim.api.nvim_create_augroup("GitConfig", { clear = true })

return {
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank({ timeout = 55 })
		end,
		group = UserAutoCmd,
	}),

	-- Set filetype for certain file-patterns.
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "gitconfig",
		callback = function()
			vim.opt.filetype = "gitconfig"
		end,
		group = GitConfig,
	}),

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			require("go.format").gofmt()
		end,
		group = vim.api.nvim_create_augroup("GoFormat", {}),
	}),

	-- Niche autocmd to fix TS highlinging in preview buffer windows
	vim.api.nvim_create_autocmd("User", {
		pattern = "TelescopePreviewwerLoaded",
		callback = function()
			vim.opt_local.splitkeep = "cursor"
		end,
		group = vim.api.nvim_create_augroup("TelescopePluginEvents", {}),
	}),

	-- vim.api.nvim_create_autocmd("BufWritePre", {
	-- 	pattern = "*.go",
	-- 	callback = function()
	-- 		require("go.format").gofmt()
	-- 	end,
	-- 	group = vim.api.nvim_create_augroup("GoFormat", {}),
	-- })
}
