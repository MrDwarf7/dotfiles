---@deprecated

local M = {}

M.moveInLine = function(d)
	require("vscode-neovim").action("cursorMove", {
		args = {
			{
				to = d == "end" and "wrappedLineEnd" or "wrappedLineStart",
				by = "wrappedLine",
				-- by = 'line',
				-- value = vim.v.count1,
				-- value = vim.v.count,
				value = 0,
				select = true,
			},
		},
	})
	return "<Ignore>"
end

-- 行间移动
M.moveLine = function(d)
	-- local current_mode = vim.api.nvim_get_mode().mode
	require("vscode-neovim").action("cursorMove", {
		args = {
			{
				to = d == "j" and "down" or "up",
				by = "wrappedLine",
				-- by = "line",
				value = vim.v.count1,
				-- value = vim.v.count,
				select = true,
			},
		},
	})
	return "<Ignore>"
end

M.move = function(d)
	return function()
		-- 获取当前编辑模式
		local current_mode = vim.api.nvim_get_mode().mode
		if current_mode == "V" then
			M.moveLine(d)
			if d == "j" then
				M.moveInLine("end")
			else
				M.moveInLine("start")
			end
		else
			local start_pos = vim.api.nvim_buf_get_mark(0, "<")
			local end_pos = vim.api.nvim_buf_get_mark(0, ">")
			local start_line = start_pos[1]
			local start_col = start_pos[2]
			local end_line = end_pos[1]
			local end_col = end_pos[2]
			local selected_end_line_text = vim.fn.getline(end_line)
			local cursor = vim.api.nvim_win_get_cursor(0)
			local current_line = cursor[1]
			if start_col == 0 and end_col + 1 == #selected_end_line_text and start_line == end_line then
				M.moveLine(d)
				if d == "j" then
					M.moveInLine("end")
				else
					M.moveInLine("start")
				end
				return "<Ignore>"
			end

			M.moveLine(d)

			if end_col + 1 == #selected_end_line_text and current_line < end_line then
				M.moveInLine("start")
				-- return 'V'
			end
			if start_col == 0 and current_line > start_line then
				M.moveInLine("end")
				-- return 'V'
			end
		end
		return "<Ignore>"
	end
end

M.moveCursor = function(d)
	return function()
		if vim.v.count == 0 and vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
			return "g" .. d
		else
			return d
		end
	end
end

return M
