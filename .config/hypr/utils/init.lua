--- General utility functions for Hyprland config.
--- May also be called as a func to automatically route to the
--- 'uwsm_launcher' function.
---
---@class HyprConfig.Utils
---@field uwsm_launcher fun(program: str, as_service?: bool): HL.Dispatcher
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

setmetatable(utils, {
  __call = function(_, ...)
    return utils.uwsm_launcher(...)
  end,
})

---@type HyprConfig.Utils
---@return HyprConfig.Utils
return utils
