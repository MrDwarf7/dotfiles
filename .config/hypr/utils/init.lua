--- General utility functions for Hyprland config.
--- May also be called as a func to automatically route to the
--- 'uwsm_launcher' function.
---
---@class HyprConfig.Utils
---@field uwsm_launcher fun(program: str, as_service?: bool): HL.Dispatcher
---@field validate_type fun(value: any, ty?: type): void
local utils = {}

--- Launch a program via uwsm. `as_service` adds `-t service`.
---@param program str
---@param as_service? bool
-- stylua: ignore start
utils.uwsm_launcher = function(program, as_service)
  local base_cmd = "uwsm app"
  if as_service then base_cmd = base_cmd .. " -t service" end
  base_cmd = string.format("%s -- %q", base_cmd, program)
  return hl.dsp.exec_cmd(base_cmd)
end
-- stylua: ignore end

--- Validates that a value is of the expected type.
--- If not, raises an error with a descriptive message.
---@generic A : any
---@generic T : type
---@param value A Any value to validate.
---@param ty T A type to validate against (default: type of value).
utils.validate_type = function(value, ty)
  ty = ty or string.format("%s", type(value)) or error("validate: type is required and must be a string")
  if not value or type(value) ~= ty then
    error("assign_bucket: " .. ty .. " is required and must be a " .. ty)
  end
end

setmetatable(utils, {
  __call = function(_, ...)
    return utils.uwsm_launcher(...)
  end,
})

---@type HyprConfig.Utils
---@return HyprConfig.Utils
return utils
