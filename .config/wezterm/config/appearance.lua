---@type mywez.Utils
local Utils = require("utils.utils_init")
---@type mywez.GpuAdapters
local GpuAdapter = require("utils.gpu_adapter")

---@class mywez.Appearance: Wezterm
---@field options Wezterm?
---@field computed mywez.Appearance.Computed
---@field init fun(self: mywez.Appearance): nil
local Appearance = {
	initialized = false,
}

---@private
Appearance.__index = Appearance

---@class mywez.Appearance.Computed
---@field cursor_blink_ease_in string
---@field cursor_blink_ease_out string
---@field animation_fps number?
---@field max_fps number?
---@field front_end string?
---@field webgpu_power_preference string?
---@field webgpu_preferred_adapter GpuInfo
local Computed = {
	initialized = false,
}

---@param to_check any
---@param type_of string
---@param fallback any
local check_valid = function(to_check, type_of, fallback)
	if not to_check or type(to_check) ~= type_of then
		return fallback
	end
	return to_check
end

function Computed.init()
	local inst = setmetatable({}, { __index = Computed })

	if inst.initialized then
		return inst
	end

	local cursor_blink_ease_in = Utils.set_blink_ease_in() -- These are stable, no nil
	local cursor_blink_ease_out = Utils.set_blink_ease_out()

	local animation_fps = Utils.envtoint("WZT_ANIM_FPS")
	local max_fps = Utils.envtoint("WZT_MAX_FPS")
	local front_end = Utils.env("WZT_GPU_FRONTEND")
	local webgpu_power_preference = Utils.env("WZT_GPU_POWER_PREF")

	inst.cursor_blink_ease_in = cursor_blink_ease_in
	inst.cursor_blink_ease_out = cursor_blink_ease_out

	inst.animation_fps = check_valid(animation_fps, "number", 60)
	inst.max_fps = check_valid(max_fps, "number", 144)
	inst.front_end = check_valid(front_end, "string", "WebGL")
	inst.webgpu_power_preference = check_valid(webgpu_power_preference, "string", "HighPerformance")

	local pref = GpuAdapter:pick_best()
	local manual = GpuAdapter:pick_manual("Vulkan", "DiscreteGpu")

	if type(pref) ~= "nil" then
		inst.webgpu_preferred_adapter = pref
	else
		if type(manual) ~= "nil" then
			inst.webgpu_preferred_adapter = manual
		else
			-- Fallback to a default adapter if no preferred adapter is found.
			-- This will let Wezterm decide the best adapter.
			inst.webgpu_preferred_adapter = nil
		end
	end

	inst.initialized = true

	return inst
end

function Appearance.init()
	-- local comped = Computed:init()

	local comped = Computed.init()
	local inst = setmetatable({}, { __index = Appearance })

	if inst.initialized then
		return inst
	end

	inst.animation_fps = comped.animation_fps
	inst.max_fps = comped.max_fps
	inst.front_end = comped.front_end
	inst.webgpu_power_preference = comped.webgpu_power_preference
	inst.webgpu_preferred_adapter = comped.webgpu_preferred_adapter

	inst.window_decorations = "RESIZE"

	inst.color_scheme = "Tokyo Night Storm"

	inst.tab_bar_at_bottom = true
	inst.tab_max_width = 18
	inst.use_fancy_tab_bar = false
	inst.show_tab_index_in_tab_bar = true
	inst.switch_to_last_active_tab_when_closing_tab = false

	inst.initial_cols = 150
	inst.initial_rows = 32

	inst.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}

	inst.window_background_opacity = 1.0
	inst.inactive_pane_hsb = {
		saturation = 0.92,
		brightness = 0.80,
	}

	inst.default_cursor_style = "SteadyBlock"
	inst.cursor_blink_rate = 960

	return inst
end

return Appearance:init()

------- original return code block -------
-- return {
-- 	animation_fps = Computed.animation_fps,
-- 	max_fps = Computed.max_fps,
-- 	front_end = Computed.front_end,
-- 	webgpu_power_preference = Computed.webgpu_power_preference,
-- 	webgpu_preferred_adapter = Computed.webgpu_preferred_adapter,
--
-- 	window_decorations = "RESIZE",
-- 	color_scheme = "Tokyo Night Storm",
--
-- 	tab_bar_at_bottom = true,
-- 	tab_max_width = 18,
-- 	use_fancy_tab_bar = false,
-- 	show_tab_index_in_tab_bar = true,
-- 	switch_to_last_active_tab_when_closing_tab = false,
--
-- 	initial_cols = 150,
-- 	initial_rows = 32,
--
-- 	window_padding = {
-- 		left = 0,
-- 		right = 0,
-- 		top = 0,
-- 		bottom = 0,
-- 	},
--
-- 	window_background_opacity = 1.0,
-- 	inactive_pane_hsb = {
-- 		saturation = 0.92,
-- 		brightness = 0.80,
-- 	},
--
-- 	cursor_blink_ease_in = Computed.cursor_blink_ease_in,
-- 	cursor_blink_ease_out = Computed.cursor_blink_ease_out,
--
-- 	default_cursor_style = "SteadyBlock",
-- 	cursor_blink_rate = 960,
-- }
