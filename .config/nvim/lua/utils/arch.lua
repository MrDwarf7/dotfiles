--
---@class utils.Arch
local Arch = {}

Arch.__IS_WIN = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

--- Gets the current operating system as a type of OperatingSystemEnum
---@return EOperatingSystemEnum
function Arch.get_os()
  ---@type EOperatingSystemEnum
  return assert(vim.loop.os_uname().sysname, "Operating system not found in list")
end

--- Returns the current operating system.
--- return value is always lowercased.
---@return EOperatingSystemEnumLower
function Arch.get_os_lower()
  return assert(string.lower(vim.g.os or vim.loop.os_uname().sysname), "Operating system not found in list") --[[@as EOperatingSystemEnumLower]]
end

function Arch.setup()
  return Arch
end

---@return utils.Arch
return Arch
