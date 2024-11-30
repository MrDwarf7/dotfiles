local wezterm = require("wezterm")
local act = wezterm.action
-- local platform = require("utils.platform")

local keys = {}

-- if platform is x then
-- 	keys.leader = thing
-- 	-- -- then change mods = "LEADER" to mods = keys.leader
-- end
local leader = { key = "a", mods = "CTRL" }

local launcher_flags = { flags = "FUZZY|TABS|DOMAINS|LAUNCH_MENU_ITEMS" }
local launch_menu = { flags = "LAUNCH_MENU_ITEMS" }

local tab_keys = {}
for i = 1, 8 do
	-- ctrl + a -> number to activate that tab
	table.insert(tab_keys, {
		key = tostring(i),
		mods = "CTRL",
		action = act({ ActivateTab = i - 1 }),
	})

	table.insert(tab_keys, {
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
local key_opts = {
	-- Tabs
	{ key = "c", mods = "LEADER", action = act.SpawnTab("DefaultDomain") },
	{ key = "C", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "m", mods = "LEADER", action = act.SpawnTab({ DomainName = "WSL:Arch" }) },
	-- act({ SpawnTab = "CurrentPaneDomain" }) },

	-- { key = "Nmod.SUPER", mods = "", action = act.SpawnWindow },
	{ key = "F", mods = "LEADER", action = "ToggleFullScreen" },

	{ key = "\\", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },

	-- Panes

	{ key = "d", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },

	-- Pane resizing
	{ key = "LeftArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "DownArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "UpArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "RightArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 5 }) },

	-- Panes still
	{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },

	-- Literally just redeundancy binds from habit
	{ key = "h", mods = "LEADER|CTRL", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER|CTRL", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER|CTRL", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER|CTRL", action = act({ ActivatePaneDirection = "Right" }) },

	-- Tabs
	-- Was either this or q and e, mapping w to close instead of q
	--
	--
	-- Could potentially just remove this honestly - use CTRL + [1-9] or use the switcher via leader + ctrl P
	{ key = "H", mods = "LEADER|SHIFT", action = act.ActivateTabRelative(-1) }, -- Moving
	{ key = "L", mods = "LEADER|SHIFT", action = act.ActivateTabRelative(1) }, -- Moving

	{ key = ".", mods = "LEADER", action = act.MoveTabRelative(1) },
	{ key = ",", mods = "LEADER", action = act.MoveTabRelative(-1) },

	-- { key = "r", mods = "LEADER", action = act.EmitEvent("tabs.manual-update-tab-title") },

	-- { key = ">", mods = "LEADER", action = wezterm.action.EmitEvent("less-opaque") },
	-- { key = "<", mods = "LEADER", action = wezterm.action.EmitEvent("more-opaque") },

	-- These MOVE the current pane +1 / -1
	-- { key = "n", mods = "LEADER", action = act.MoveTabRelative(1) },
	-- { key = "p", mods = "LEADER", action = act.MoveTabRelative(-1) },

	-- Modes
	{ key = "y", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "g", mods = "LEADER", action = act.QuickSelect }, -- 'Grab'
	{ key = "f", mods = "LEADER", action = act.Search({ CaseSensitiveString = "" }) },
	-- TODO: Bindings for opacity

	{ key = "p", mods = "LEADER|CTRL", action = act.ShowLauncherArgs(launcher_flags) },
	{ key = "p", mods = "LEADER", action = act.ShowLauncherArgs(launcher_flags) },

	{ key = "b", mods = "LEADER", action = act.ShowLauncherArgs(launch_menu) },

	{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },

	{
		key = "w",
		mods = "LEADER",
		action = act.PaneSelect({ alphabet = "123456789", mode = "SwapWithActiveKeepFocus" }),
	},

	{ key = "Y", mods = "LEADER", action = act.ShowTabNavigator },

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

	table.unpack(tab_keys),
}

for _, key_op in ipairs(key_opts) do
	table.insert(keys, key_op)
end

local key_tables = {}

local mouse_bindings = {
	{
		-- Ctrl-click will open the link under the mouse cursor
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

return {
	leader = leader,
	keys = keys,
	key_tables = key_tables,
	mouse_bindings = mouse_bindings,
}
