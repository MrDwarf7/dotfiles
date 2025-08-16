---@type mywez.Platform
local Platform = require("utils.platform")

---@type mywez.Utils
local Utils = require("utils.utils_init")

local function is_win()
	if Utils.env("SHELL") ~= nil then
		return Utils.env("SHELL")
	end
	if Utils.env("SHELL") == nil then
		return "pwsh"
	end
end

local function is_linux()
	if Utils.env("SHELL") ~= nil then
		return Utils.env("SHELL")
	else
		return { "fish" }
	end
end

local function shell()
	if Platform.is_win then
		return is_win()
		-- return utils.env("SHELL") or "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe"
	elseif Platform.is_linux or Platform.is_mac then
		return is_linux()
	end
end
-- default_prog = { shell(), "-NoLogo" }

local options = {
	default_prog = {},
	launch_menu = {},
}

-- Order matters, place more wanted at the top of the table.insert stack

-- Nushell is universal across both Windows & Linux
table.insert(options.launch_menu, { label = "Nushell", args = { "nu" } })

if Platform.is_win then
	options.default_prog = { shell(), "-NoLogo" }
	table.insert(options.launch_menu, { label = "Pwsh", args = { Utils.env("SHELL"), "-NoLogo" } })
	table.insert(options.launch_menu, { label = "Pwsh -NoProfile", args = { Utils.env("SHELL"), "-NoProfile" } })
	table.insert(options.launch_menu, { label = "cmd", args = { "cmd" } })
	-- table.insert(options.launch_menu, { label = "Git Bash", args = { } })
end

if Platform.is_linux then
	options.default_prog = { shell(), "-l" }
	table.insert(options.launch_menu, { label = "Fish", args = { "fish", "-l" } })
	table.insert(options.launch_menu, { label = "Zsh", args = { "zsh", "-l" } })
	table.insert(options.launch_menu, { label = "Bash", args = { "bash", "-l" } })
	-- table.insert(options.launch_menu, { label = "*** Elvish", args = { "elvish" } })
end

-- if platform.is_mac then
-- 	options.default_prog = { "/opt/homebrew/bin/fish", "-l" }
-- 	options.launch_menu = {
-- 		{ label = "Bash", args = { "bash", "-l" } },
-- 		{ label = "Fish", args = { "/opt/homebrew/bin/fish", "-l" } },
-- 		{ label = "Nushell", args = { "/opt/homebrew/bin/nu", "-l" } },
-- 		{ label = "Zsh", args = { "zsh", "-l" } },
-- 	}

return options
