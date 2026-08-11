-- WALLPAPER_BACKEND cmd catalog. Key == env string. Empty cmd = native (no daemon).

--- Nominal string: a known WALLPAPER_BACKEND name.
---@class HyprConfig.WallBeKey : string

--- Cmd catalog. `native` is "" so the key exists and `pairs` sees it.
---@class HyprConfig.WallBeCmds : table<HyprConfig.WallBeKey, string>
--- No hypr-side daemon. DMS / hyprpaper / wallpaper off.
---@field native string
--- swww daemon.
---@field swww string
--- awww daemon (swww fork).
---@field awww string
--- linux-wallpaperengine (community Wayland port, not the Windows app).
---@field wallpaperengine string
local cmds = {
  native = "",
  swww = "swww-daemon",
  awww = "awww-daemon",
  wallpaperengine = "wallpaperengine-gui",
}

--- Resolve the backend name.
--- `override` if a non-empty string, else `envs.WALLPAPER_BACKEND`, else `native`.
--- Input is lowercased so "AWWW" still hits cmds.awww; keys stay lowercase.
--- `hit` is the cmd string (may be ""); we return the key, not the cmd.
---@param override? EnvVarValue|HyprConfig.WallBeKey
---@return HyprConfig.WallBeKey
local get = function(override)
  local v = override
  if type(v) ~= "string" or v == "" then
    v = require("shared.env").WALLPAPER_BACKEND
  end
  local key = type(v) == "string" and v ~= "" and v:lower()
  local hit = key and cmds[key]
  if hit ~= nil then
    ---@cast key HyprConfig.WallBeKey
    return key
  end
  return "native"
end

--- Cmd for the selected backend, or nil if native / empty.
---@param override? EnvVarValue|HyprConfig.WallBeKey
---@return string?
local function cmd(override)
  local c = cmds[get(override)]
  if c == nil or c == "" then
    return nil
  end
  return c
end

--- START-time helper. Do not call at require / config-parse time.
--- native -> no-op. Hands the cmd to uwsm_launcher; does not fix WE-via-Hyprland.
---@param override? EnvVarValue|HyprConfig.WallBeKey
---@return nil
local function launch(override)
  local c = cmd(override)
  if not c then
    return
  end
  require("utils").uwsm_launcher(c, true)
end

--- Cmd catalog plus get/cmd/launch. Dot-index for cmds (`wall_be.swww`).
---@class HyprConfig.WallBe : HyprConfig.WallBeCmds
--- Resolve the active backend name.
---@field get fun(override?: EnvVarValue|HyprConfig.WallBeKey): HyprConfig.WallBeKey
--- Selected cmd string, or nil if native.
---@field cmd fun(override?: EnvVarValue|HyprConfig.WallBeKey): string?
--- START-time uwsm_launcher wrapper. No-op on native.
---@field launch fun(override?: EnvVarValue|HyprConfig.WallBeKey): nil
local wall_be = {
  get = get,
  cmd = cmd,
  launch = launch,
}

setmetatable(wall_be, {
  __index = cmds,
  __call = function(_, ...)
    return get(...)
  end,
})

---@type HyprConfig.WallBe
---@return HyprConfig.WallBe
return wall_be
