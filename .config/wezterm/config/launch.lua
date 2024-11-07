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

if platform.is_win then
	options.default_prog = { shell(), "-NoLogo" }
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

return options
