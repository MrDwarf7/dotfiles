local M = {}

--- A single character string alias
---@alias Char string

--- Insert a line of text with a prefix and suffix
---@param line_cap_char Char
---@param line_cap_len integer
---@param filler_char Char
---@param filler_line_len integer
M.text_breaker_line = function(
	--
	line_cap_char,
	line_cap_len,
	--
	filler_char,
	filler_line_len
)
	if not line_cap_char or nil == line_cap_char then
		line_cap_char = "#"
	end

	if not line_cap_len or nil == line_cap_len then
		line_cap_len = 5
	end

	if not filler_char or nil == filler_char then
		filler_char = "-"
	end

	if not filler_line_len or nil == filler_line_len then
		filler_line_len = 100
	end

	local line_cap = string.rep(line_cap_char, line_cap_len)
	local filler_line = string.rep(filler_char, filler_line_len)
	local line = line_cap .. " " .. filler_line .. " " .. line_cap
	-- local line_len = string.len(line)
	-- local line_diff = filler_line_len - line_len

	vim.api.nvim_put({ line }, "l", false, true)

	-- vim.api.nvim_put({ "##### " .. string.rep("-", 100) .. " #####" }, "l", true, true)
end

return M
