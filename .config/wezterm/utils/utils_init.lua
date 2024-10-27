---@type config.Utils: table

---@class Utils: config.Utils
---@field envtoint fun(number: string): number|string|nil
---@field env fun(value: string): string|nil
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

return setmetatable(Utils, {
	__index = Utils,
	__path = (...):match("(.*[\\/])"),
})
