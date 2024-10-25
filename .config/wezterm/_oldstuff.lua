----local shell = utils.env("SHELL") or "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe"
----local max_fps = utils.envtoint("WZT_MAX_FPS") -- or 144
----local front_end = utils.env("WZT_GPU_FRONTEND") --or "WebGpu"
----local webgpu_power_preference = utils.env("WZT_GPU_POWER_PREF") -- or "HighPerformance"
----local animation_fps = utils.envtoint("WZT_ANIM_FPS") -- or 144
----local home_dir = utils.env("HOME")

-- config.automatically_reload_config = core.automatically_reload_config
-- config.enable_tab_bar = core.enable_tab_bar
-- config.enable_wayland = core.enable_wayland

-- config.default_prog = { core.shell, "-NoLogo" }
-- Config.window_close_confirmation = "NeverPrompt"

-- config.exit_behavior_messaging = core.exit_behavior_messaging
--
-- config.audible_bell = core.audible_bell
--
-- wezterm.home_dir = Config.home_dir

-- Font settings

-----@diagnostic disable-next-line: param-type-mismatch
-- config.font = core.font
-- config.font = wezterm.font("JetBrains Mono", { weight = "Medium", italic = false, stretch = "Normal" })

-- config.font_size = core.font_size
-- config.harfbuzz_features = core.harfbuzz_features

-- Visual
-- -- Rendering settings
-- config.status_update_interval = core.status_update_interval

-- config.max_fps = core.max_fps
-- config.front_end = core.front_end
-- config.webgpu_power_preference = core.webgpu_power_preference

-- -- Cursor settings

-- config.animation_fps = core.animation_fps
-- config.cursor_blink_ease_in = core.cursor_blink_ease_in()
-- config.cursor_blink_ease_out = core.cursor_blink_ease_out()

-- if config.animation_fps ~= 144 then
-- 	config.cursor_blink_ease_in = "Constant"
-- 	config.cursor_blink_ease_out = "Constant"
-- else
-- 	config.cursor_blink_ease_in = "Linear"
-- 	config.cursor_blink_ease_out = "EaseOut"
-- end

-- config.default_cursor_style = core.default_cursor_style
-- config.cursor_blink_rate = core.cursor_blink_rate

-- -- Appearance settings
-- -- Dark THemes
-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = "tokyonight_night"
-- config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = core.color_scheme

-- -- Light Themes
-- config.color_scheme = "tokyonight-day"
-- config.color_scheme = "Tokyo Night Day"
-- config.color_scheme = "Tokyo Night Light (Gogh)"
--
--
-- config.colors.gutter

-- Config.window_background_opacity = 0.85
-- Config.window_padding = {
-- 	left = 0,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }
--
-- Config.initial_cols = 150
-- Config.initial_rows = 32

-- wezterm.on("gui-startup", function(cmd)
-- 	local x = 80
-- 	local y = 80
-- 	return window:set_position(x, y)
-- end)

-- Config.enable_scroll_bar = true
-- Config.window_decorations = "RESIZE"
-- Config.enable_tab_bar = true
-- Config.use_fancy_tab_bar = false
-- Config.show_tab_index_in_tab_bar = true
-- config.tab_bar_style = ""
-- Config.tab_max_width = 18
-- Config.tab_bar_at_bottom = true
-- Config.switch_to_last_active_tab_when_closing_tab = false
-- Config.text_background_opacity = 1 --0.6

-- Config.scrollback_lines = 3000

-- Config.inactive_pane_hsb = {
-- 	saturation = 0.92,
-- 	brightness = 0.80,
-- }
