local M = {}

M.is_windows = function()
	-- local os_type = function()
	if vim.fn.has("win32") == 1 then
		return true
	else
		return false
	end
end

return M
