local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils.utils_init")
-- local platform = require("utils.platform")

local keys = {}
local key_tables = {}

-- if platform is x then
-- 	keys.leader = thing
-- 	-- -- then change mods = "LEADER" to mods = keys.leader
-- end
local leader = { key = "a", mods = "CTRL" }

local launcher_flags = { flags = "FUZZY|DOMAINS|LAUNCH_MENU_ITEMS" }
local launch_menu = { flags = "LAUNCH_MENU_ITEMS" }

local tab_keys = {}
for i = 1, 8 do
	-- local t = utils.tbl_deep_extend("force", tab_keys, {
	-- 	{ key = tostring(i), mods = "CTRL", action = act({ ActivateTab = i - 1 }), },
	-- 	{ key = tostring(i), mods = "LEADER", action = act({ ActivateTab = i - 1 }), },
	-- })
	-- tab_keys = t

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

	-- { key = "Nmod.SUPER", mods = "", action = act.SpawnWindow },
	{ key = "F", mods = "LEADER", action = "ToggleFullScreen" },

	{ key = "\\", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },

	-- Panes

	{ key = "d", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },

	-- Pane resizing
	{ key = "LeftArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "DownArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 4 }) },
	{ key = "UpArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 4 }) },
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

	-- TODO: Perhaps we can use TAB // SHIFT+Tab for moving them?
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
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
	{ key = "v", mods = "LEADER", action = act.ActivateKeyTable({ name = "scrolling", one_shot = false }) },

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
		action = utils.url_matcher(),
	},

	table.unpack(tab_keys),
}

utils.merge_tables(keys, key_opts)

local key_table_opts = {
	copy_mode = {
		{ key = "H", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "L", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
		-- { key = "Q", mods = "CTRL", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "q", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

		{ key = "e", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.1 }) },
		{ key = "y", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.1 }) },
	},
	resize_pane = {
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
	},

	scrolling = {
		{ key = "Escape", action = "PopKeyTable" },

		{ key = "e", mods = "CTRL", action = act.ScrollByLine(1) },
		{ key = "y", mods = "CTRL", action = act.ScrollByLine(-1) },

		{ key = "j", mods = "NONE", action = act.ScrollByLine(2) },
		{ key = "k", mods = "NONE", action = act.ScrollByLine(-2) },

		{ key = "j", mods = "CTRL", action = act.ScrollByLine(2) },
		{ key = "k", mods = "CTRL", action = act.ScrollByLine(-2) },

		{ key = "d", mods = "CTRL", action = act.ScrollByPage(1) },
		{ key = "u", mods = "CTRL", action = act.ScrollByPage(-1) },
	},
}

--- Merge the default key tables with the custom ones we have
--- THis preserved the existing (default) binds
for k, v in pairs(wezterm.gui.default_key_tables()) do
	key_tables[k] = v
end

utils.merge_tables(key_tables, key_table_opts)

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

wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "T-MODE: " .. name .. " "
	end
	window:set_right_status(name or "")
end)

return {
	leader = leader,
	keys = keys,
	key_tables = key_tables,
	mouse_bindings = mouse_bindings,
}
