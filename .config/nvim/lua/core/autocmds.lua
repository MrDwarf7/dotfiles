
return {
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank({ timeout = 55 })
		end,
		group = vim.api.nvim_create_augroup("UserAutoCmd", { clear = true }),
	}),

	-- Set filetype for certain file-patterns.
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "gitconfig",
		callback = function()
			vim.opt.filetype = "gitconfig"
		end,
		group = vim.api.nvim_create_augroup("GitConfig", { clear = true }),
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

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local lsp_restart = function()
				vim.lsp.stop_client(vim.lsp.get_active_clients())
				vim.cmd([[ LspRestart<CR> ]])
			end

			vim.keymap.set("n", "<Leader>l%", function()
				lsp_restart()
			end, { desc = "Restart" })
		end,
	}),

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end,
	}),

	-- vim.api.nvim_create_autocmd("BufWritePre", {
	-- 	pattern = "*.go",
	-- 	callback = function()
	-- 		require("go.format").gofmt()
	-- 	end,
	-- 	group = vim.api.nvim_create_augroup("GoFormat", {}),
	-- })
}
