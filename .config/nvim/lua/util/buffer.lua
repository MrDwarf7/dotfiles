local M = {}

M.is_large = function(buf)
	local max_filesize = 1000 * 1024
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
		return true
	else
		return false
	end
end

return M
