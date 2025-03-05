---@type config.Utils: table

---@class Utils: config.Utils
---@field envtoint fun(number: string): number|string|nil
---@field env fun(value: string): string|nil
---@field tbl_deep_extend fun(behavior: string, ...): table
local Utils = {}
Utils.__index = Utils
-- Utils.vim = require("utils.vim_helpers")

--- Converts an environment variable to a number correctly
---@param number string
---@return number|string|nil
function Utils.envtoint(number)
	local env_v = os.getenv(number)
	if type(number) == "nil" or type(number) == nil then
		return error("Could not find environment variable '" .. number .. "'")
	end
	return math.floor(tonumber(env_v)) or error("Could not cast '" .. tostring(number) .. "' to number. '")
end

---@param value string
---@return string|nil
function Utils.env(value)
	return os.getenv(value) or error("Could not find environment variable '" .. value .. "'")
end

function Utils.set_blink_ease_in()
	local anim = Utils.envtoint("WZT_ANIM_FPS")
	if anim ~= 144 then
		return "Constant"
	else
		return "Linear"
	end
end

function Utils.set_blink_ease_out()
	local anim = Utils.envtoint("WZT_ANIM_FPS")
	if anim ~= 144 then
		return "Constant"
	else
		return "EaseOut"
	end
end

function Utils.merge_tables(base, overrides)
	for table_name, table_entries in pairs(overrides) do
		if not base[table_name] then
			base[table_name] = table_entries
		else
			for _, entry in ipairs(table_entries) do
				table.insert(base[table_name], entry)
			end
		end
	end
end

--- Merges recursively two or more tables.
---
---
---@generic T1: table
---@generic T2: table
---@param behavior 'error'|'keep'|'force' Decides what to do if a key is found in more than one map:
---      - "error": raise an error
---      - "keep":  use value from the leftmost map
---      - "force": use value from the rightmost map
---@param ... T2 Two or more tables
---@return T1|T2 (table) Merged table
function Utils.tbl_deep_extend(behavior, ...)
	assert(type(behavior) == "string", "behaviour must be a string")
	local n = select("#", ...)
	assert(n >= 2, "must provide at least two table to perform a merge")

	local function recurse(dest, src)
		if type(src) ~= "table" then
			return src
		end

		if type(dest) ~= "table" then
			dest = {}
		end

		for k, v in pairs(src) do
			local dv = dest[k]
			local vt = type(v)
			local dbt = type(dv)

			if vt == "table" then
				dest[k] = recurse(dv, v)
			else
				if dv ~= nil then
					if behavior == "error" then
						error(string.format("key '%s' already exists in the destination table", string.format("%s", k)))
					elseif behavior == "keep" then
					---- do nothing and keep existing value
					else
						---- "force" -> overwrite
						dest[k] = v
					end
				else
					dest[k] = v
				end
			end
		end
		return dest
	end

	local result = {}
	for i = 1, n do
		local t = select(i, ...)
		result = recurse(result, t)
	end
	return result
end

function Utils.url_matcher()
	local wezterm = require("wezterm")
	require("wezterm")
	return wezterm.action.QuickSelectArgs({
		label = "open url",
		patterns = {
			"\\((https?://\\S+)\\)",
			"\\[(https?://\\S+)\\]",
			"\\{(https?://\\S+)\\}",
			"<(https?://\\S+)>",
			"\\bhttps?://\\S+[)/a-zA-Z0-9-]+",
		},
		action = wezterm.action_callback(function(window, pane)
			local url = window:get_selection_text_for_pane(pane)
			wezterm.log_info("opening: " .. url)
			wezterm.open_with(url)
		end),
	})
end

return setmetatable(Utils, {
	__index = Utils,
	__path = (...):match("(.*[\\/])"),
})
