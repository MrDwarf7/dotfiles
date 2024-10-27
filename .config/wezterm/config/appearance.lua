local utils = require("utils.utils_init")
local gpu_adapter = require("utils.gpu_adapter")

local function set_blink_ease_in()
	local anim = utils.envtoint("WZT_ANIM_FPS")
	if anim ~= 144 then
		return "Constant"
	else
		return "Linear"
	end
end

local function set_blink_ease_out()
	local anim = utils.envtoint("WZT_ANIM_FPS")
	if anim ~= 144 then
		return "Constant"
	else
		return "EaseOut"
	end
end

return {
	window_decorations = "RESIZE", -- Border

	animation_fps = utils.envtoint("WZT_ANIM_FPS"), -- Animation FPS
	max_fps = utils.envtoint("WZT_MAX_FPS"), -- Total possible/MAX fps
	front_end = utils.env("WZT_GPU_FRONTEND"), -- Frontend for rendering
	webgpu_power_preference = utils.env("WZT_GPU_POWER_PREF"), -- power pref
	-- NOTE:
	webgpu_preferred_adapter = gpu_adapter:pick_best(), -- chooser for the adapter

	color_scheme = "Tokyo Night Storm", -- Colorscheme
	-- -- Dark THemes
	-- color_scheme = "Tokyo Night",
	-- color_scheme = "tokyonight_night",
	-- color_scheme = "Tokyo Night Moon",
	-- -- Light Themes
	-- color_scheme = "tokyonight-day",
	-- color_scheme = "Tokyo Night Day",
	-- color_scheme = "Tokyo Night Light (Gogh)",

	-- Tabs
	-- enable_tab_bar = true,
	tab_bar_at_bottom = true,
	tab_max_width = 18,
	use_fancy_tab_bar = false,
	show_tab_index_in_tab_bar = true,
	switch_to_last_active_tab_when_closing_tab = false,

	initial_cols = 150,
	initial_rows = 32,

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	window_background_opacity = 1.0,
	inactive_pane_hsb = {
		saturation = 0.92,
		brightness = 0.80,
	},

	-- Cursor
	cursor_blink_ease_in = set_blink_ease_in(),
	cursor_blink_ease_out = set_blink_ease_out(),
	default_cursor_style = "SteadyBlock",
	cursor_blink_rate = 960,
}
