local M = setmetatable({}, {
	__call = function(m, ...)
		return m.clear_encoding(...)
	end,
})

function M.clear_encoding(bufnr)
	-- save cursor position
	local current_pos = vim.api.nvim_win_get_cursor(0)
	local clear_reg =
		'\\v^(:?\\e?\\[[1-9].?)\\d+[:?m](:?\\w+)(:?\\e\\[0m\\s+)?\\=\\s?\\s?(\\[\\])?(:?\\[\\e\\[\\d+.)?(:?"\\w*[-\\/\\w+]?(:?\\w+)?(:?[\\/\\"\\w]?(\\w+)"))?.*/\\2 = \\4\\6'
	vim.api.nvim_buf_call(bufnr, function()
		---@diagnostic disable-next-line: param-type-mismatch
		pcall(vim.cmd, "silent %s/" .. clear_reg)
	end)

	-- restore cursor position
	pcall(vim.api.nvim_win_set_cursor, 0, current_pos)
end

return M
