local wezterm = require("wezterm") ---@type Wezterm

---@alias PlatformType 'windows' | 'linux' | 'mac'

---@class mywez.Platform
---@field os PlatformType
---@field is_win boolean
---@field is_linux boolean
---@field is_mac boolean
---@field init fun(self: mywez.Platform): mywez.Platform
---@field is_found fun(str: string, pattern: string): boolean
local Platform = {}

---@private
Platform.__index = Platform

Platform.is_found = function(str, pattern)
	return string.find(str, pattern) ~= nil
end

function Platform:init()
	local is_win = self.is_found(wezterm.target_triple, "windows")
	local is_linux = self.is_found(wezterm.target_triple, "linux")
	local is_mac = self.is_found(wezterm.target_triple, "apple")
	local os

	if is_win then
		os = "windows"
	elseif is_linux then
		os = "linux"
	elseif is_mac then
		os = "mac"
	else
		error("Unknown platform")
	end

	self.os = os
	self.is_win = is_win
	self.is_linux = is_linux
	self.is_mac = is_mac

	setmetatable(self, {
		__index = Platform,
	})

	return self
end

---@return mywez.Platform
return Platform:init()
