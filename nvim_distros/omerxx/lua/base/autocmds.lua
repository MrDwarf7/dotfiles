local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local last_pos = vim.fn.line("'\"")
		if last_pos > 0 and last_pos <= vim.fn.line("$") then
			vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_group,
	callback = function()
		vim.highlight.on_yank({ timeout = 60 })
	end,
})


vim.api.nvim_create_autocmd("FileType", {
	pattern = "sh",
	callback = function()
		vim.lsp.start({
			name = "bash-language-server",
			cmd = { "bash-language-server", "start" },
		})
	end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	pattern = "slint",
	callback = function()
		vim.lsp.start({
			name = "slint",
			cmd = { "slint", "lsp" },
		})
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "vim",
	callback = function()
		vim.lsp.start({
			name = "vim-language-server",
			cmd = { "vim-language-server", "--stdio" },
		})
	end,
})


vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.lsp.start({
			name = "pyright",
			cmd = { "pyright-langserver", "--stdio" },
		})
	end,
})
