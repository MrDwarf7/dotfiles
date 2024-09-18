---@alias PathBuf string

---@class convert_filepath
---@field __index convert_filepath
---@field __tostring fun(): string
---@field __call fun(filepath: PathBuf): PathBuf
---@field handle_filepath fun(filepath: PathBuf): PathBuf
---@return convert_filepath
local M = {}

--- Convert filepath
setmetatable(M, {
	__index = M,
	__tostring = function()
		return string.format("convert_filepath")
	end,
	__call = function(_, ...)
		return M.handle_filepath(...)
	end,
	__metatable = "convert_filepath",
})

--- Handles filepath for oil buffers
--- [ oil:///C/Users/NAME/dotfiles/.config/nvim/ ]
--- and converts it to
--- [ C:\Users\NAME\dotfiles\.config\nvim ]
---
---- Note:
--- This works for oil buffers, but provides relative path for normal buffers.
---
---@return PathBuf
---@param filepath PathBuf
M.handle_filepath = function(filepath)
	filepath = filepath or ""
	if vim.g.os == "Windows_NT" then
		if vim.startswith(filepath, "oil:///") then
			filepath = string.gsub(filepath, "oil:///", "")
			filepath = string.gsub(filepath, "/", "\\")
			filepath = string.sub(filepath, 1, 1) .. ":" .. string.sub(filepath, 2)
			filepath = string.sub(filepath, 1, -2)
			-- Inside the oil dir/browser thing
			return filepath
		end
		-- Inside a file
		return filepath
	end
	return filepath
end

-- M.__index = M
return M
