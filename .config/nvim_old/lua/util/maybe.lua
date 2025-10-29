local M = {}

setmetatable(M, {
	-- NOTE: I will have to modify this in the future if I add more funcs to this lol
	__call = function(m, ...)
		return m.maybe_dev(...)
	end,
})

--- Check if a dev plugin dir exists for the plugin name
---
---
--- We attempt to format the plugin name
--- with the global vim.g.my_dev and return a boolean
---
---@param plugin_name string
---@return boolean
M.maybe_dev = function(plugin_name)
	--- Format the plugin name and return as a path string
	local dev_dir = string.format("%s\\%s", vim.g.my_dev, plugin_name)
	local dir = dev_dir or plugin_name or nil

	if dir ~= nil and vim.fn.isdirectory(dir) == 1 then --- 1 == true, 0 == false
		return true
	end
	return false
end

return M
