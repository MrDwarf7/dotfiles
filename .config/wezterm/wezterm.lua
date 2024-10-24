---@type Wezterm
local wezterm = require("wezterm")
---@type Action
local act = wezterm.action

---@diagnostic disable-next-line: unused-local
local mux = wezterm.mux

---@alias Error string

--- Converts an environment variable to a number correctly
---@param number string|number
---@return number|string|Error
local function EnvToInt(number)
	local env_v = os.getenv(number)
	return math.floor(tonumber(env_v)) or error("Could not cast '" .. tostring(number) .. "' to number. '")
end

local function env(value)
	return os.getenv(value) or error("Could not find environment variable '" .. value .. "'")
end

----@alias Work string
----@alias Home string
----@alias ENV Work | Home
--local ENV = os.getenv("HOME_PROFILE")

---@class Config
local config = {}
config.__index = config
-- This WILL break the config
-- config.__path = config.__path or (...):match('(.*[\\/])')

config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false
config.enable_wayland = false

local shell = env("SHELL") or "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe"
config.default_prog = { shell, "-NoLogo" }
config.window_close_confirmation = "NeverPrompt"

config.exit_behavior_messaging = "Verbose"

config.audible_bell = "Disabled"

wezterm.home_dir = env("USERPROFILE")

-- Font settings

---@diagnostic disable-next-line: param-type-mismatch
config.font = wezterm.font("Mononoki Nerd Font Mono", { weight = "Light", italic = false, stretch = "Normal" })
-- config.font = wezterm.font("JetBrains Mono", { weight = "Medium", italic = false, stretch = "Normal" })

config.font_size = 11
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0", "zero" }

-- Visual
-- -- Rendering settings
config.status_update_interval = 1000

config.animation_fps = 60

config.max_fps = EnvToInt("WZT_MAX_FPS") or 230
config.front_end = env("WZT_GPU_FRONTEND") or "WebGpu"
config.webgpu_power_preference = env("WZT_GPU_POWER_PREF") or "HighPerformance"

-- -- Cursor settings

config.animation_fps = EnvToInt("WZT_ANIM_FPS") or 144
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "EaseOut"
-- config.cursor_blink_rate = 1000
-- config.default_cursor_style = "BlinkingBlock"
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0

-- -- Appearance settings
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 1.0 --.95
config.window_padding = {
	left = 1,
	right = 0,
	top = 2,
	bottom = 0,
}

config.initial_cols = 150
config.initial_rows = 32

-- wezterm.on("gui-startup", function(cmd)
-- 	local x = 80
-- 	local y = 80
-- 	return window:set_position(x, y)
-- end)

config.enable_scroll_bar = true
config.window_decorations = "RESIZE"

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = true
config.switch_to_last_active_tab_when_closing_tab = false
config.text_background_opacity = 1.0 --0.6

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.Nop,
	},
}

config.scrollback_lines = 10000

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.85,
}

-- Keybindings

-- -- Leader key

-- config.leader = { key = "Space", mods = "CTRL" }
config.leader = { key = "a", mods = "CTRL" }

-- -- Tab switching

local my_keys = {}
for i = 1, 8 do
	-- ctrl + a -> number to activate that tab
	table.insert(my_keys, {
		key = tostring(i),
		mods = "CTRL",
		action = act({ ActivateTab = i - 1 }),
	})
end

---@class KeyOp
---@field key string
---@field mods string
---@field action Action

---@type KeyOp[]
local key_ops = {
	-- Tabs
	{ key = "n", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },

	-- { key = "Nmod.SUPER", mods = "", action = act.SpawnWindow },
	{ key = "F", mods = "LEADER", action = "ToggleFullScreen" },

	{ key = "\\", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },

	-- Panes
	{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },

	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },

	-- Pane resizing
	{ key = "LeftArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "DownArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "UpArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "RightArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 5 }) },

	-- Tabs
	-- Was either this or q and e, mapping w to close instead of q
	{ key = "h", mods = "LEADER|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "LEADER|CTRL", action = act.ActivateTabRelative(1) },

	-- These MOVE the current pane +1 / -1
	-- { key = "n", mods = "LEADER", action = act.MoveTabRelative(1) },
	-- { key = "p", mods = "LEADER", action = act.MoveTabRelative(-1) },

	-- Modes
	--TODO: This seems to think I'm still in 'copy mode' even though it's not actually in it
	{ key = "y", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "s", mods = "LEADER", action = act.QuickSelect },
	{ key = "f", mods = "LEADER", action = act.Search({ CaseSensitiveString = "" }) },

	{ key = "p", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },
	{ key = "P", mods = "LEADER", action = act.PaneSelect({ alphabet = "123456789", mode = "SwapWithActiveKeepFocus" }) },

	{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },

	{
		key = "u",
		mods = "LEADER",
		action = wezterm.action.QuickSelectArgs({
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
		}),
	},
}

config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

for _, key_op in ipairs(key_ops) do
	table.insert(my_keys, key_op)
end

config.keys = my_keys

config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = "\\b\\w+://\\S+[)/a-zA-Z0-9-]+",
		format = "$0",
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
}

-- config.ssh_domains = {}
-- config.ssh_backend =
-- config.default_gui_startup_args = {}

---@type Config
return config
