---@class mywez.Validator
---@field init fun(self: mywez.Validator): mywez.Validator
---@field clean_prefix fun(prefix: string, module: string): string
---@field valid_modules fun(wezterm: Wezterm, prefix: string, module: mywez.Mod): mywez.Mod.table?
---@field leading_slash fun(str: string, keep_leading?: boolean): string
---@field trailing_slash fun(str: string, keep_trailing?: boolean): string
---@field path_segment fun(path: string, keep_leading?: boolean, keep_trailing?: boolean): table<string>
local Validator = {}

---@private
Validator.__index = Validator

--- Cleans the prefix from the options string
function Validator.clean_prefix(prefix, module)
	-- check if the string is already 'valid' ie: <prefix>.<module>, we return early
	if module:find("^" .. prefix .. "%." .. module .. "$") then
		-- we have everything we need
		return module
	end

	-- <prefix> -> <prefix>.<module>
	if not module:find("^" .. prefix .. "%.") then
		module = prefix .. "." .. module
		return module
	end

	-- module isn't malformed, it's fine (we shouldn't get here though tbf)
	return module
end

--- Type checks and converts the input to a module table
---
--- - string, it requires the module.
--- - table, it assumes it's already a module table.
function Validator.valid_modules(wezterm, prefix, module)
	-- can't find 'config', therefore we don't have either <config> or <config.>
	if type(module) == "string" and not module:find("^" .. prefix) then
		module = prefix .. "." .. module
	end

	-- is a string AND will now have, at a min, <prefix>.<module>
	if type(module) == "string" then
		module = Validator.clean_prefix(prefix, module)
		return require(module)
	end
	-- if it's a table, we assume it's already a module table
	if type(module) == "table" then
		return module
	end

	-- If its a function, we assume it's a module that returns a table
	if type(module) == "function" then
		-- if it's a function, we assume it's a module that returns a table
		local mod = module()
		if type(mod) == "table" then
			return mod
		end
	end

	-- If it's nil, we log a warning and return nil
	if type(module) == "nil" then
		wezterm.log_warn(
			"Invalid config options provided, expected a string, table, or function returning a table, got nil"
		)
		goto out
	end

	::out::
	return nil
end

--- Acts on a string to ensure or remove a leading slash.
--- If `keep_leading` is true, it keeps leading slashes.
---@param str string The string to process.
---@param keep_leading boolean? If true, keeps leading slashes; if false removes them.
---@return string with a leading slash.
function Validator.leading_slash(str, keep_leading)
	if keep_leading then
		-- If we want to keep leading slashes, ensure it starts with a slash
		if not str:find("^/") then
			return "/" .. str
		end
	else
		-- If we want to remove leading slashes, remove them
		str, _ = str:gsub("^/+", "")
		return str
	end
	return str
end

--- Acts on a string to ensure or remove a trailing slash.
--- If `keep_trailing` is true, it keeps trailing slashes.
---@param str string The string to process.
---@param keep_trailing boolean? If true, keeps trailing slashes; if false, ensures a
---@return string with a trailing slash.
function Validator.trailing_slash(str, keep_trailing)
	if keep_trailing then
		-- If we want to keep trailing slashes, ensure it ends with a slash
		if not str:find("/$") then
			return str .. "/"
		end
	else
		-- If we want to remove trailing slashes, remove them
		str, _ = str:gsub("/+$", "")
		return str
	end
	return str
end

--- Splits a path into segments, optionally keeping leading and trailing slashes.
--- - This handles normalization of Windows paths to Unix-style paths during the check.
---@param path string The path to split.
---@param keep_leading boolean? Whether to keep the leading slash. Default is false.
---@param keep_trailing boolean? Whether to keep the trailing slash. Default is false.
---@return string[] A table of path segments.
function Validator.path_segment(path, keep_leading, keep_trailing)
	---@type Wezterm
	local wezterm = require("wezterm")

	if not path or type(path) ~= "string" then
		return {}
	end

	-- normalize windows paths to unix
	if path:find("\\") then
		path, _ = path:gsub("\\", "/")
	end

	keep_leading = keep_leading or false
	keep_trailing = keep_leading or false

	if keep_leading then
		path = Validator.leading_slash(path, true)
	else
		path = Validator.leading_slash(path, false)
	end

	if keep_trailing then
		path = Validator.trailing_slash(path, true)
	else
		path = Validator.trailing_slash(path, false)
	end

	if path == "" then
		return { "" } -- Return a table with an empty string if the path is empty
	end

	if path:find("/") then
		-- Split the path by slashes
		local segments = {}
		for segment in path:gmatch("[^/]+") do
			table.insert(segments, segment)
		end
		return segments
	else
		-- If no slashes, return the whole path as a single segment
		return { path }
	end
end

-- function Validator:init()
-- 	-- Set the metatable to itself
-- 	setmetatable(self, {
-- 		__index = Validator,
-- 	})
-- 	return self
-- end

---@return mywez.Validator
return Validator
