---@alias DWBKey "SWWW" | "AWWW" | "WALLPAPERENGINE"
---@alias DWBName "swww" | "awww" | "wallpaperengine"

-- TODO: we can likely slim this down; pretty sure am doing a sort of 'double' lookup here we can fix

---@enum HyprConfig.WallpaperBackendE
local backends = {
  SWWW = "swww",
  AWWW = "awww",
  WALLPAPERENGINE = "wallpaperengine",
}

---@alias HyprConfig.WallpaperBackendT "swww" | "awww" | "wallpaperengine" | string

--- Mapping for HyprConfig.WallpaperBackendE -> hl.exec_cmd string
---@class HyprConfig.WallpaperBackendCmds
local backend_cmds = {
  [backends.SWWW:upper()] = "swww --no-daemon",
  [backends.AWWW:upper()] = "awww --no-daemon",
  [backends.WALLPAPERENGINE:upper()] = "wallpaperengine-gui -m",
}

-- TODO: Eventually we'd actually want to move these over to be
-- something like `WallpaperBackend.active` and we just do an initial lookup
-- _against_ the backends/cmds and set it.

---@class HyprConfig.WallpaperBackend
local WallpaperBackend = {
  SWWW = backends.SWWW,
  AWWW = backends.AWWW,
  WALLPAPERENGINE = backends.WALLPAPERENGINE,
}

---@class DetectedWallpaperBackend
---@field key DWBKey The corresponding key in HyprConfig.WallpaperBackendE (e.g. "SWWW", "AWWW", "WALLPAPERENGINE")
---@field name DWBName The detected wallpaper backend name (e.g. "swww", "awww", "wallpaperengine")

---@param override? string Optional override value (e.g. from env var or command line arg)
---@return DetectedWallpaperBackend|bool Mapping K: HyprConfig.WallpaperBackendE[K] :: V: HyprConfig.WallpaperBackendE[v]
WallpaperBackend.detect = function(override)
  local env_backend = os.getenv("WALLPAPER_BACKEND")
  if override and type(override) == "string" and override ~= "" then
    local detected = backends[override:upper()]
    if detected then
      return { key = override:upper(), name = detected }
    end
  end

  if env_backend and type(env_backend) == "string" and env_backend ~= "" then
    local detected = backends[env_backend:upper()]
    if detected then
      return { key = env_backend:upper(), name = detected }
    end
  end

  -- Fallback detection logic (e.g. check for running processes)
  local function is_process_running(name)
    local handle = io.popen("pgrep -x " .. name)
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
WallpaperBackend.launch_cmd = function(backend)
  return backend_cmds[backend:lower()] or backend_cmds[backends.SWWW:upper()]
end

---@return HyprConfig.WallpaperBackend
return WallpaperBackend
