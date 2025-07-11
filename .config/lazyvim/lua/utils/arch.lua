require("types")

---@class Arch
---@field get_os fun(): EOperatingSystemEnum
---@field get_os_lower fun(): EOperatingSystemEnumLower
local M = {}

--- Gets the current operating system as a type of OperatingSystemEnum
---@return EOperatingSystemEnum
M.get_os = function()
  ---@type EOperatingSystemEnum
  return assert(vim.loop.os_uname().sysname, "Operating system not found in list")
end

--- Returns the current operating system.
--- return value is always lowercased.
---@return EOperatingSystemEnumLower
M.get_os_lower = function()
  return assert(string.lower(vim.g.os or vim.loop.os_uname().sysname), "Operating system not found in list") --[[@as EOperatingSystemEnumLower]]
end

return M
