local M = {}

--- Gets the current operating system as a type of OperatingSystemEnum
-----@return OperatingSystemEnum
M.get_os = function()
  --	---@type OperatingSystemEnum
  local os_t = vim.loop.os_uname().sysname
  return assert(os_t, "Operating system not found in list")
end

return M
