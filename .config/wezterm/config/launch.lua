local platform = require("utils.platform")
local utils = require("utils.utils_init")

-- working commit
-- 6a8ac7f5
local function shell()
	if platform.is_win then
		return utils.env("SHELL") or "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe"
	elseif platform.is_linux or platform.is_mac then
		return utils.env("SHELL") or "/bin/bash"
	end
end
-- default_prog = { shell(), "-NoLogo" }

local options = {
	default_prog = {},
	launch_menu = {},
}

-- Order matters, place more wanted at the top of the table.insert stack

table.insert(options.launch_menu, { label = "Nushell", args = { "nu" } })

if platform.is_win then
	options.default_prog = { shell(), "-NoLogo" }
	table.insert(options.launch_menu, { label = "Pwsh", args = { "pwsh", "-NoLogo" } })
	table.insert(options.launch_menu, { label = "Pwsh -NoProfile", args = { "pwsh", "-NoProfile" } })
	table.insert(options.launch_menu, { label = "cmd", args = { "cmd" } })
	-- options.launch_menu = {
	-- { label = "1PowerShell", shell() },
	-- { label = "PowerShell Desktop", args = { "powershell" } },
	-- { label = "Command Prompt", args = { "cmd" } },
	-- { label = "Nushell", args = { "nu" } },
	-- {
	-- 	label = "Git Bash",
	-- 	args = { }
	-- },
	-- }

	-- elseif platform.is_mac then
	-- 	options.default_prog = { "/opt/homebrew/bin/fish", "-l" }
	-- 	options.launch_menu = {
	-- 		{ label = "Bash", args = { "bash", "-l" } },
	-- 		{ label = "Fish", args = { "/opt/homebrew/bin/fish", "-l" } },
	-- 		{ label = "Nushell", args = { "/opt/homebrew/bin/nu", "-l" } },
	-- 		{ label = "Zsh", args = { "zsh", "-l" } },
	-- 	}
	-- elseif platform.is_linux then
	-- 	options.default_prog = { shell(), "-l" }
	-- 	options.launch_menu = {
	-- 		{ label = "Bash", args = { "bash", "-l" } },
	-- 		{ label = "Fish", args = { "fish", "-l" } },
	-- 		{ label = "Zsh", args = { "zsh", "-l" } },
	-- 	}
end

if platform.is_linux then
	options.default_prog = { shell(), "-l" }
	table.insert(options.launch_menu, { label = "Fish", args = { "fish", "-l" } })
	table.insert(options.launch_menu, { label = "Zsh", args = { "zsh", "-l" } })
	table.insert(options.launch_menu, { label = "Bash", args = { "bash", "-l" } })
	table.insert(options.launch_menu, { label = "*** Elvish", args = { "elvish" } })
end

-- options.launch_menu = {
-- 	{ label = "NuShell", args = { "nu" } },
-- }

return options
