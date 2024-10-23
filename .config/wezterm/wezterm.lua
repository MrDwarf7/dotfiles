---@type Wezterm
local wezterm = require("wezterm")
---@type Action
local act = wezterm.action

local ENV = "";
-- local pwsh = "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe"

local pwsh = "";

-- If this doesn't exist we are at work
local child_res = wezterm.run_child_process("C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe", { "-NoLogo" });

if child_res[3] == false or 0 ~= child_res[1] then
	ENV = "work"
else
	ENV = "home"
end

if ENV == "work" then
	pwsh = "C:\\Applications\\PowerShell_start\\Powershell_linked\\pwsh.exe"
else
	pwsh = "C:\\Program Files\\PowerShell\\7\\pwsh.exe"
end

---@type Config
local config = {}
-- maybe works to fix win pathing?
-- config.__index = config
-- config.__path = config.__path or (...):match('(.*[\\/])')

config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false
config.enable_wayland = false
config.default_prog = { pwsh, "-NoLogo"}
config.window_close_confirmation = "NeverPrompt"

config.exit_behavior_messaging = 'Verbose'
config.status_update_interval = 1000


config.audible_bell = "Disabled"


-- Font settings

---@diagnostic disable-next-line: param-type-mismatch
config.font = wezterm.font("JetBrains Mono", { weight = "Medium", italic = false, stretch = "Normal" })

config.font_size = 10.0
config.harfbuzz_features = {"calt=0", "clig=0", "liga=0", "zero"}

-- Visual
-- -- Rendering settings

config.animation_fps = 60
config.max_fps = 230
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- -- Cursor settings


-- config.default_cursor_style = "SteadyBlock"
-- config.cursor_blink_rate = 0

config.animation_fps = 144
config.cursor_blink_ease_in = 'Linear'
config.cursor_blink_ease_out = 'EaseOut'
config.cursor_blink_rate = 1000
config.default_cursor_style = "BlinkingBlock"


-- -- Appearance settings
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.95
config.window_padding = {
	left = 1,
	right = 0,
	top = 2,
	bottom = 0
}


config.enable_scroll_bar = true
config.window_decorations = "RESIZE"

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = false
config.text_background_opacity = 0.6


config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left"}},
		mods = "NONE",
		action = wezterm.action.Nop,
	},
}

config.scrollback_lines = 10000

-- Keybindings

-- -- Leader key

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
	{ key = "t", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "f", mods = "LEADER", action = "ToggleFullScreen" },
	{ key = "n", mods = "LEADER", action = act.MoveTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.MoveTabRelative(-1) },
	{ key = "H", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "V", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

	-- Panes
	{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },

	-- Pane resizing
	{ key = "h", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "j", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "k", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "l", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 1 }) },

	-- Modes
	--TODO: This seems to think I'm still in 'copy mode' even though it's not actually in it
	{ key = "y", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "s", mods = "LEADER", action = act.QuickSelect },
	{ key = "f", mods = "LEADER", action = act.Search({ CaseSensitiveString = "" }) },

}

for _, key_op in ipairs(key_ops) do
	table.insert(my_keys, key_op)
end

config.keys = my_keys

config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = '\\((\\w+://\\S+)\\)',
		format = '$1',
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = '\\[(\\w+://\\S+)\\]',
		format = '$1',
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = '\\{(\\w+://\\S+)\\}',
		format = '$1',
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = '<(\\w+://\\S+)>',
		format = '$1',
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
		format = '$0',
	},
	-- implicit mailto link
	{
		regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
		format = 'mailto:$0',
	},
}


-- config.inactive_pane_hsb = {
--    saturation = 0.9,
--    brightness = 0.65,
-- }


---@type Config
return config
