---@enum HyprConfig.ShellBackendE
local shells = {
  VANILLA = "vanilla",
  DMS = "dms",
  NOCTALIA = "noctalia",
}

---@alias HyprConfig.ShellBackendT "vanilla" | "dms" | "noctalia" | string

-- TODO: Eventually we'd actually want to move these over to be
-- something like `ShellBackend.active` and we just do an initial lookup
-- _against_ the backends/cmds and set it.

---@class HyprConfig.Utils.ShellBackend
local ShellBackend = {
  VANILLA = shells.VANILLA,
  DMS = shells.DMS,
  NOCTALIA = shells.NOCTALIA,
}

--- Set the metatable so if we attempt to index ShellBackend with a key that doesn't exist,
--- it falls back to shells.
---
setmetatable(ShellBackend, {
  __index = shells,
  __call = function(_, ...)
    return ShellBackend.get(...)
  end,
})

--- Best effort shell detection based on HYPRLAND_SHELL env var.
---
---@param override? string Optional override value (e.g. from env var or command line arg)
---@return HyprConfig.ShellBackendT Detected shell backend (e.g. "vanilla", "dms", "noctalia")
ShellBackend.detect = function(override)
  local shell_env = os.getenv("HYPRLAND_SHELL")
  if override and type(override) == "string" and override ~= "" then
    local detected = shells[override:upper()] or override
    print("[hyprland] Detected shell from override: " .. detected)
    return detected
  end

  if shell_env and type(shell_env) == "string" and shell_env ~= "" then
    local detected = shells[shell_env:upper()] or shell_env
    print("[hyprland] Detected shell from HYPRLAND_SHELL env: " .. detected)
    return detected
  end
  print("[hyprland] No HYPRLAND_SHELL env var set, defaulting to vanilla")
  return shells.VANILLA
end

--- Get the shell backend to use, optionally with an override value (e.g. from env var or command line arg).
---@param override? string Optional override value (e.g. from env var or command line arg)
---@return HyprConfig.ShellBackendT Detected shell backend (e.g. "vanilla", "dms", "noctalia")
ShellBackend.get = function(override)
  local v = ShellBackend.detect(override)
  if type(v) == "string" and v ~= "" then
    return v
  elseif type(v) == "table" and (v.name or v.key) then -- should basically never happen
    return v.name
  else
    print("[hyprland] Warning: ShellBackend.detect() returned invalid value, defaulting to vanilla")
    return shells.VANILLA
  end
end

---@return HyprConfig.Utils.ShellBackend
return ShellBackend
