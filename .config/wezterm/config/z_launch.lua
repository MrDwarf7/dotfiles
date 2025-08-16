---@class LauncherItems
---@field label string
---@field args string[]

---@class mywez.Launch
---@field default_prog string[]
---@field launch_menu LauncherItems[]
---@field current_os PlatformType
local Launch = {}
Launch.Utils = nil
Launch.Platform = nil

---@private
Launch.__index = Launch

-- Launch.Utils = Utils
-- Launch.Platform = Platform

---@private
function Launch:is_win()
	if self.Utils.env("SHELL") ~= nil then
		-- if not self.current_os then
		-- 	self.current_os = self.Platform.os
		-- end
		return self.Utils.env("SHELL")
	end
	return "pwsh"
end

---@private
function Launch:is_linux()
	if self.Utils.env("SHELL") ~= nil then
		-- if not self.current_os then
		-- 	self.current_os = self.Platform.os
		-- end
		return self.Utils.env("SHELL")
	end
	return { "fish" }
end

function Launch:shell()
	-- Prefer locally cached version over jumping via self.platform
	if type(self.current_os) ~= "nil" then
		if self.current_os == "windows" then
			return self:is_win()
		elseif self.current_os == "linux" or self.current_os == "mac" then
			return self:is_linux()
		end
	end

	if self.Platform.is_win then
		return self:is_win()
	elseif self.Platform.is_linux or self.Platform.is_mac then
		return self:is_linux()
	end
end

function Launch:setup_windows()
	self.default_prog = { self:shell(), "-NoLogo" }
	---@type LauncherItems[]
	local launch_menu_opts = {
		{ label = "Pwsh", args = { self:shell(), "-NoLogo" } },
		{ label = "Pwsh -NoProfile", args = { self:shell(), "-NoProfile" } },
		{ label = "cmd", args = { "cmd" } },
	}

	for _, item in ipairs(launch_menu_opts) do
		table.insert(self.launch_menu, item)
	end
end

function Launch:setup_unix()
	self.default_prog = { self:shell(), "-l" }
	---@type LauncherItems[]
	local launch_menu_opts = {
		{ label = "Fish", args = { "fish", "-l" } },
		{ label = "Zsh", args = { "zsh", "-l" } },
		{ label = "Bash", args = { "bash", "-l" } },
	}

	for _, item in ipairs(launch_menu_opts) do
		table.insert(self.launch_menu, item)
	end
end

function Launch:init()
	-- local initial = {
	-- 	default_prog = {},
	-- 	launch_menu = {},
	-- 	current_os = "",
	-- }

	local platform = require("utils.platform")
	local utils = require("utils.utils_init")

	self.Utils = utils
	self.Platform = platform

	if type(self.current_os) == "nil" then
		self.current_os = self.Platform.os
	end

	table.insert(self.launch_menu({ label = "Nushell", args = { "nu" } }))

	if self.current_os == "windows" then
		self:setup_windows()
	end

	if self.current_os == "linux" or self.current_os == "mac" then
		self:setup_unix()
	end

	return setmetatable(self, self)
end

-- return Launch:init()
