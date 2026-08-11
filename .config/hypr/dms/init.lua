--- DMS (DankLinux Desktop) shell-specific configuration.
--- Loaded by hyprland.lua when HYPRLAND_SHELL=dms.
--- Handles DMS-specific setup: keymaps, layer rules, window rules, colors, etc.
--- DMS handles bar, wallpaper, and notifications internally via quickshell,
--- so no autostart execs are needed here (shared execs cover the common ones).

---@class HyprConfig.Dms
local dms = {}

--- The use of a class table and a setup function
--- may seem redunant/overhead here, and it _sort of_ is.
--- But we get to call it explicitly in the top-level config
--- and all Shell types (Dms/Vanialla/Noctalia) have the same interface,
--- so it’s worth it for consistency and clarity.
--- The only other option is simply returning `<shell>:setup()`
--- here, and the caller only needs `require(<shell>)`, but... eh

--- Returns a functon that represents a DMS command invocation.
---
---@param cmd string The DMS IPC command to invoke.
---@return HL.Dispatcher
dms.invoke = function(cmd)
  local full_cmd = string.format("dms %s", cmd)
  return hl.dsp.exec_cmd(full_cmd)
end

--- Returns a functon that represents a DMS IPC command invocation.
---
---@param cmd string The DMS IPC command to invoke.
---@return HL.Dispatcher
dms.invoke_ipc = function(cmd)
  return dms.invoke(string.format("ipc %s", cmd))
end

--- Returns a functon that represents a DMS IPC call command invocation.
---
---@param cmd any The DMS IPC call command to invoke.
---@param now? boolean If true, the command is executed immediately; otherwise, it returns a dispatcher for later execution.
---@return HL.Dispatcher|any
dms.invoke_ipc_call = function(cmd, now)
  if now and type(now) ~= nil then
    return dms.invoke(string.format("ipc call %s", cmd))()
  end
  return dms.invoke(string.format("ipc call %s", cmd))
end

--- Initializes DMS-specific configuration: keymaps, layer rules, window rules, colors, etc.
---
---@param self HyprConfig.Dms The DMS configuration table.
---@return HyprConfig.Dms
dms.setup = function(self)
  -- Load DMS-specific modules (each self-contained, calls hl.* directly)
  require("dms.colors")
  -- require("dms.cursor")
  require("dms.keymaps")
  require("dms.layerrules")
  -- require("dms.layout")
  require("dms.windowrules")

  local types = require("types")
  -- probs move this to a proper execs.lua in here

  -- This reloads the githubInbox plugin on Hyprland start
  -- Required because it doesn't auto-fetch the secrets key by default
  hl.on(types.HyprlandEvents.START, function()
    -- pcall(function()
    -- hl.exec_cmd('dms ipc call plugins reload "githubInbox" >/dev/null 2>&1')
    -- hl.exec_cmd(self.invoke_ipc_call('plugins reload "githubInbox" >/dev/null 2>&1', true))
    -- hl.dispatch(self.invoke_ipc_call('plugins reload "githubInbox" >/dev/null 2>&1', true))
    self.invoke_ipc_call('plugins reload "githubInbox" >/dev/null 2>&1')
    -- end)
  end)

  return self
end

---@return HyprConfig.Dms
return dms
