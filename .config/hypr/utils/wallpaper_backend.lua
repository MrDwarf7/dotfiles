---@alias DWBKey "NATIVE" | "SWWW" | "AWWW" | "WALLPAPERENGINE"
---@alias DWBName "native" | "swww" | "awww" | "wallpaperengine"

-- TODO: we can likely slim this down; pretty sure am doing a sort of 'double' lookup here we can fix

-- TODO: Need to implement handling for the new 'NATIVE' set of types here
-- also the shared.execs needs to handle it as well (we should treat nil returns from something like .get as native I think?
-- we can still fetch the backend_cmd for it - which itself is empty anyway
-- (or we can return nil and have the caller say 'if it's nil, do nothing')

---@enum HyprConfig.WallpaperBackendE
local backends = {
  NATIVE = "native",
  SWWW = "swww",
  AWWW = "awww",
  WALLPAPERENGINE = "wallpaperengine",
}

---@alias HyprConfig.WallpaperBackendT "swww" | "awww" | "wallpaperengine" | string

--- Mapping for HyprConfig.WallpaperBackendE -> hl.exec_cmd string
---@class HyprConfig.WallpaperBackendCmds
local backend_cmds = {
  [backends.NATIVE:upper()] = "", -- No command needed for native wallpaper management
  [backends.SWWW:upper()] = "swww --no-daemon",
  [backends.AWWW:upper()] = "awww --no-daemon",
  [backends.WALLPAPERENGINE:upper()] = "wallpaperengine-gui",
}

--- Get the command to launch the specified wallpaper backend
--- Defaults to AWWW if the key is not found or invalid
---@param backend_key DWBKey The key of the wallpaper backend (e.g. "SWWW", "AWWW", "WALLPAPERENGINE")
function backend_cmds.get(backend_key)
  return backend_cmds[backend_key:upper()] or backend_cmds[backends.AWWW:upper()]
end

-- TODO: Eventually we'd actually want to move these over to be
-- something like `WallpaperBackend.active` and we just do an initial lookup
-- _against_ the backends/cmds and set it.

---@class HyprConfig.WallpaperBackend
local WallpaperBackend = {
  NATIVE = backends.NATIVE,
  SWWW = backends.SWWW,
  AWWW = backends.AWWW,
  WALLPAPERENGINE = backends.WALLPAPERENGINE,
}

--- Checks `str` for:
--- - `true` & `type(_) == "string" & `str` != ""
--- returns `str` if valid, otherwise nil.
---
---@param str any Any input to be checked.
---@return string? Returns `str` if it's a non-empty string, otherwise nil.
local ftc_string = function(str)
  if str and type(str) == "string" and str ~= "" then
    return str
  else
    return nil
  end
end

---@class DetectedWallpaperBackend
---@field key DWBKey The corresponding key in HyprConfig.WallpaperBackendE (e.g. "SWWW", "AWWW", "WALLPAPERENGINE")
---@field name DWBName The detected wallpaper backend name (e.g. "swww", "awww", "wallpaperengine")

--- Best effort attempt to detect a configured wallpaper backend, with the following precedence:
--- 1. Optional override value (e.g. from env var or command line arg)
--- 2. `WALLPAPER_BACKEND` via `shared.env` (UWSM / hole-fill)
--- 3. Fallback detection logic (e.g. check for running processes)
--- 4. Default fallback (e.g. "swww")
---
---@param override? string Optional override value (e.g. from env var or command line arg)
---@return DetectedWallpaperBackend|bool Mapping K: HyprConfig.WallpaperBackendE[K] :: V: HyprConfig.WallpaperBackendE[v]
WallpaperBackend.detect = function(override)
  local env_backend = require("shared.env").WALLPAPER_BACKEND
  local override_str = ftc_string(override)
  if override_str then
    local detected = backends[override_str:upper()]
    if detected then
      return { key = override_str:upper(), name = detected }
    end
  end

  local env_str = ftc_string(env_backend)
  -- if env_backend and type(env_backend) == "string" and env_backend ~= "" then
  if env_str then
    local detected = backends[env_str:upper()]
    if detected then
      return { key = env_str:upper(), name = detected }
    end
  end

  -- Fallback detection logic (e.g. check for running processes)
  local function is_process_running(name)
    local handle, err = io.popen("pgrep -x " .. name, "r")
    if err then
      print("[hyprland] Error checking for process '" .. name .. "': " .. tostring(err))
      return false
    end
    if not handle then
      return false
    end
    local result = handle:read("*a")
    handle:close()
    return result ~= ""
  end

  if is_process_running("swww") then
    return { key = "SWWW", name = backends.SWWW }
  elseif is_process_running("awww") then
    return { key = "AWWW", name = backends.AWWW }
  elseif is_process_running("wallpaperengine") then
    return { key = "WALLPAPERENGINE", name = backends.WALLPAPERENGINE }
  end

  -- Default fallback
  return { key = "SWWW", name = backends.SWWW }
end

---@param backend DWBKey The key of the detected wallpaper backend (e.g. "SWWW", "AWWW", "WALLPAPERENGINE")
---@return string? The command to launch the specified wallpaper backend, or nil if an error occurs
WallpaperBackend.launch_cmd = function(backend)
  if not backend or type(backend) ~= "string" then
    print("[hyprland] Invalid wallpaper backend key: " .. tostring(backend))
    -- we would handle default ret. type here, but is okay because `.get` handles it
  end
  local cmd = backend_cmds.get(backend)
  local handle, err = io.popen(cmd, "r")
  if err then
    print("[hyprland] Error launching wallpaper backend '" .. backend .. "': " .. tostring(err))
    return nil
  end
  if not handle then
    print("[hyprland] Failed to launch wallpaper backend '" .. backend .. "': no handle returned")
    return nil
  end
  local result = handle:read("*a")
  WallpaperBackend.last_launch_output = result
  handle:close()
  return cmd
end

---@return HyprConfig.WallpaperBackend
return WallpaperBackend
