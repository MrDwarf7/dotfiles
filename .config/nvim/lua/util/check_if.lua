--- Items prefixed with `s` are `'safe'` functions
--- Meaning they will return with a notification or a false,
--- instead of taking the expected action.
local M = {}

setmetatable(M, {
	__index = function(_, key)
		vim.notify("Key not found: " .. key, vim.log.levels.WARN)
		return function()
			return false
		end
	end,
	__call = function(m, ...)
		return m.check_if(...)
	end,
	__metatable = "You're trying to access a private metatable via metatable",
	-- __newindex = function()
	-- 	vim.notify("You're trying to write to a private table", vim.log.levels.WARN)
	-- end,
})

M.check_if = function(condition, false_fn, true_fn)
	if not condition then
		return false_fn()
	else
		return true_fn()
	end
end

-- name: string, flags?: string, prot?: any
M.smkdir = function(os, name, flags, prot)
	if not os then
		vim.notify("OS not defined", vim.log.levels.WARN)
		return false
	end
	if not vim.loop.fs_stat(name) then
		vim.fn.mkdir(name, flags, prot)
	end
	return true
end

return M
