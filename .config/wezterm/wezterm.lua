-- NOTE: To get this working on Windows, you will NEED to place it on the rtp.
--NOTE: easiest one is to::  ln ~\dotfiles\.config\wezterm ~\.wezterm

--
-- config ||| Top level
--
-- CORE ||| 'basic settings' if you will
-- { Generic(Shells/domains or Domains, Toolbar, Scheme etc etc.), Window, Font }
--
-- RENDER ||| Rendering settings & will require dep/util (Font, fnc for gpu thing etc.)
--
-- BINDS ||| Keybindings
--
-- KEY_TABLES ||| Keybinding extension tables
--
---@type Wezterm
local wezterm = require("wezterm")
---@type Action
local act = wezterm.action

---@diagnostic disable-next-line: unused-local
local mux = wezterm.mux

---@alias Error string

---@class Config
local Config = {}
Config.__index = Config

-- This WILL break the config
-- Config.__path = Config.__path or (...):match("(.*[\\/])")

Config = wezterm.config_builder()

-- Required AFTER the builder call lol
Config = require("config.core").setup()

-- Keybindings
-- -- Leader key

Config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.Nop,
	},
}

-- config.leader = { key = "Space", mods = "CTRL" }
Config.leader = { key = "a", mods = "CTRL" }

local my_keys = {}
for i = 1, 8 do
	-- ctrl + a -> number to activate that tab
	table.insert(my_keys, {
		key = tostring(i),
		mods = "CTRL",
		action = act({ ActivateTab = i - 1 }),
	})

	table.insert(my_keys, {
		key = tostring(i),
		mods = "LEADER",
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

	{ key = "d", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },

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

Config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},

	{
		event = { Drag = { streak = 1, button = "Left" } },
		mods = "CTRL|SHIFT",
		action = act.StartWindowDrag,
	},
}

for _, key_op in ipairs(key_ops) do
	table.insert(my_keys, key_op)
end

Config.keys = my_keys

Config.hyperlink_rules = {
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

Config.ssh_domains = {
	{
		name = "the_yeti",
		remote_address = "the_yeti",
		multiplexing = "WezTerm",
		default_prog = { "powershell.exe", "-NoLogo" },
		local_echo_threshold_ms = 10,
	},
}
-- config.ssh_backend =
-- config.default_gui_startup_args = {}

---@type Config
return Config
