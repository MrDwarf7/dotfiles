local function augroup(name, opts)
	opts = opts or { clear = true }
	return vim.api.nvim_create_augroup(name, opts)
end

return {
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank({ timeout = 55 })
		end,
		group = augroup("UserAutoCmd"),
		-- vim.api.nvim_create_augroup("UserAutoCmd", { clear = true }),
	}),

	-- Set filetype for certain file-patterns.
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "gitconfig",
		callback = function()
			vim.opt.filetype = "gitconfig"
		end,
		group = augroup("GitConfig"),
		-- vim.api.nvim_create_augroup("GitConfig", { clear = true }),
	}),

	-- Set filetype for certain file-patterns.
	-- vim.api.nvim_create_autocmd("BufEnter", {
	-- 	pattern = "*.surql",
	-- 	callback = function()
	-- 		vim.opt.filetype = "surrealdb"
	-- 		vim.opt.filetype = "sql"
	-- 	end,
	-- 	group = vim.api.nvim_create_augroup("GitConfig", { clear = true }),
	-- }),

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			require("go.format").gofmt()
		end,
		group = augroup("GoFormat", {}),
		-- vim.api.nvim_create_augroup("GoFormat", {}),
	}),

	-- Niche autocmd to fix TS highlinging in preview buffer windows
	vim.api.nvim_create_autocmd("User", {
		pattern = "TelescopePreviewwerLoaded",
		callback = function()
			vim.opt_local.splitkeep = "cursor"
		end,
		group = augroup("TelescopePluginEvents", {}),
		-- vim.api.nvim_create_augroup("TelescopePluginEvents", {}),
	}),

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local lsp_restart = function()
				vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = ev.buf }))
				vim.cmd([[ LspRestart ]])
			end

			vim.keymap.set("n", "<Leader>l%", function()
				lsp_restart()
			end, { desc = "Restart" })
		end,
	}),

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			local buf_name = vim.api.nvim_buf_get_name(0)
			if string.find(buf_name, ".obsidian.vimrc") then
				vim.api.nvim_buf_set_option(0, "filetype", "vim")
				return
			end
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

	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "*.txt",
		callback = function()
			vim.bo.textwidth = 0
			vim.bo.wrapmargin = 12
			vim.bo.formatoptions = "jcroqnt" -- jcroqnt
			vim.opt.wrap = true
			vim.bo.expandtab = false

			-- vim.cmd([[ set textwidth=0 ]])
			-- vim.cmd([[ set wrapmargin=8 ]])
			-- vim.cmd([[ set formatoptions+=t ]])
			-- vim.cmd([[ set formatoptions-=l ]])
		end,
		group = vim.api.nvim_create_augroup("NoExpandTab", { clear = true }),
	}),

	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "*.md",
		callback = function()
			vim.opt.textwidth = 80
			vim.opt.wrap = true
			vim.bo.expandtab = false
		end,
		group = vim.api.nvim_create_augroup("MarkdownOptions", { clear = true }),
	}),

	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		group = vim.api.nvim_create_augroup("AutoCreateDir", { clear = true }),
		callback = function(event)
			if event.match:match("^%w%w+:[\\/][\\/]") then
				return
			end
			local file = vim.uv.fs_realpath(event.match) or event.match
			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
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
