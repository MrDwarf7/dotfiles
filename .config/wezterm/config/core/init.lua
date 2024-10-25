---@alias config.core.Core table

local wezterm = require("wezterm")
local utils = require("config.utils")

---@class Core: config.core.Core
local Core = {}

function Core.set_blink_ease_in()
	local anim = utils.envtoint("WZT_ANIM_FPS")
	if anim ~= 144 then
		return "Constant"
	else
		return "Linear"
	end
end

function Core.set_blink_ease_out()
	local anim = utils.envtoint("WZT_ANIM_FPS")
	if anim ~= 144 then
		return "Constant"
	else
		return "EaseOut"
	end
end

function Core.shell()
	return utils.env("SHELL") or "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe" -- TODO: Move to shell/launchers module
end

function Core.setup()
	return {

		-- -- Generic look & feel
		enable_tab_bar = true,
		tab_bar_at_bottom = true,
		tab_max_width = 18,
		use_fancy_tab_bar = false,
		show_tab_index_in_tab_bar = true,
		switch_to_last_active_tab_when_closing_tab = false,
		status_update_interval = 10000,
		enable_wayland = false,
		exit_behavior_messaging = "Verbose",
		audible_bell = "Disabled",
		enable_scroll_bar = true,
		window_decorations = "RESIZE",
		window_close_confirmation = "NeverPrompt",
		automatically_reload_config = true,
		swallow_mouse_click_on_pane_focus = false,

		color_scheme = "Tokyo Night Storm",
		-- -- Dark THemes
		-- color_scheme = "Tokyo Night",
		-- color_scheme = "tokyonight_night",
		-- color_scheme = "Tokyo Night Moon",
		-- -- Light Themes
		-- color_scheme = "tokyonight-day",
		-- color_scheme = "Tokyo Night Day",
		-- color_scheme = "Tokyo Night Light (Gogh)",

		window_padding = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
		},
		window_background_opacity = 0.8,
		inactive_pane_hsb = {
			saturation = 0.92,
			brightness = 0.80,
		},

		initial_cols = 150,
		initial_rows = 32,
		scrollback_lines = 3000,

		-- -- Font
		font = wezterm.font("Mononoki Nerd Font Mono", { italic = false, stretch = "Normal" }),
		font_size = 11.0,
		harfbuzz_features = { "calt=0", "clig=0", "liga=0", "zero" },
		text_background_opacity = 1.0, --0.6

		-- -- Cursor
		cursor_blink_ease_in = Core.set_blink_ease_in(),
		cursor_blink_ease_out = Core.set_blink_ease_out(),
		default_cursor_style = "SteadyBlock",
		cursor_blink_rate = 960,

		-- -- Perf & Rendering
		max_fps = utils.envtoint("WZT_MAX_FPS"),
		animation_fps = utils.envtoint("WZT_ANIM_FPS"),
		front_end = utils.env("WZT_GPU_FRONTEND"),
		webgpu_power_preference = utils.env("WZT_GPU_POWER_PREF"),

		default_prog = { Core.shell(), "-NoLogo" },

		-- home_dir = utils.env("HOME"),
	}
end

return setmetatable(Core, {
	-- __call = Core.setup(),
	__path = (...):match("(.*[\\/])"),
})
