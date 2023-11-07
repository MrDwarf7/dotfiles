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
