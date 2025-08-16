---@class mywez.Debug
---@field init fun(self: mywez.Debug): mywez.Debug
---@field recursive_print fun(data: any, indent_level?: number, visited?: table, max_depth?: number)
local Debug = {}

---@private
Debug.__index = Debug

--- Recursive function to print data, will continue calling itself recursively until all
--- data and fields are printed.
function Debug.recursive_print(data, indent_level, visited, max_depth)
	---@type Wezterm
	local wezterm = require("wezterm")

	-- Set up default parameters for the recursive calls
	indent_level = indent_level or 0 -- Track how deep we are for indentation
	visited = visited or {} -- Track visited tables to prevent infinite loops
	max_depth = max_depth or 20 -- Prevent runaway recursion in very deep structures

	-- Base case: if we've gone too deep, stop recursing
	if indent_level > max_depth then
		wezterm.log_info(string.rep("  ", indent_level) .. "... (max depth reached)")
		return
	end

	-- Create indentation string for current level
	local indent = string.rep("  ", indent_level)

	-- Handle different data types appropriately
	local data_type = type(data)

	if data_type == "nil" then
		wezterm.log_info(indent .. "nil")
	elseif data_type == "boolean" then
		wezterm.log_info(indent .. tostring(data))
	elseif data_type == "number" then
		wezterm.log_info(indent .. tostring(data))
	elseif data_type == "string" then
		-- Show strings with quotes to make them clearly identifiable
		wezterm.log_info(indent .. '"' .. data .. '"')
	elseif data_type == "function" then
		-- Functions can't be meaningfully printed, just show their type
		wezterm.log_info(indent .. "<function>")
	elseif data_type == "userdata" or data_type == "thread" then
		-- These are opaque types from C code, just show their type
		wezterm.log_info(indent .. "<" .. data_type .. ">")
	elseif data_type == "table" then
		-- This is where the real work happens - tables are the complex case

		-- Check if we've already visited this table (circular reference detection)
		if visited[data] then
			wezterm.log_info(indent .. "<circular reference>")
			return
		end

		-- Mark this table as visited before we start processing it
		visited[data] = true

		-- Check if table has a metatable with a custom __tostring method
		local mt = getmetatable(data)
		if mt and mt.__tostring then
			wezterm.log_info(indent .. "metatable: " .. tostring(data))
		end

		wezterm.log_info(indent .. "{")

		-- Count entries to show if table is empty
		local count = 0
		for _ in pairs(data) do
			count = count + 1
		end

		if count == 0 then
			wezterm.log_info(indent .. "  <empty table>")
		else
			-- Print all key-value pairs in the table
			for key, value in pairs(data) do
				-- Format the key appropriately based on its type
				local key_str
				if type(key) == "string" then
					-- String keys that are valid identifiers don't need quotes
					if key:match("^[a-zA-Z_][a-zA-Z0-9_]*$") then
						key_str = key
					else
						key_str = '["' .. key .. '"]'
					end
				elseif type(key) == "number" then
					key_str = "[" .. tostring(key) .. "]"
				else
					key_str = "[" .. type(key) .. "]"
				end

				wezterm.log_info(indent .. "  " .. key_str .. " = ")

				-- Recursively print the value with increased indentation
				Debug.recursive_print(value, indent_level + 2, visited, max_depth)
			end
		end

		wezterm.log_info(indent .. "}")

		-- Unmark this table as visited after we're done with it
		-- This allows the same table to appear in different branches
		visited[data] = nil
	end
end

function Debug:init()
	-- Set the metatable to itself
	setmetatable(self, {
		__index = Debug,
	})

	return self
end

function Debug:info(data)
	---@type Wezterm
	local wezterm = require("wezterm")
	local prefix = "Debug Info: "

	if type(data) == "nil" then
		wezterm.log_info(prefix .. "nil")
		return
	end

	wezterm.log_info("Debug Info:" .. data)
end

function Debug:warn(data)
	---@type Wezterm
	local wezterm = require("wezterm")
	local prefix = "Debug Warn: "

	if type(data) == "nil" then
		wezterm.log_warn(prefix .. "nil")
		return
	end

	wezterm.log_warn(prefix .. data)
end

function Debug:error(data)
	---@type Wezterm
	local wezterm = require("wezterm")
	local prefix = "Debug Error: "

	if type(data) == "nil" then
		wezterm.log_error(prefix .. "nil")
		return
	end

	wezterm.log_error(prefix .. data)
end

---@return mywez.Debug
return Debug:init()
