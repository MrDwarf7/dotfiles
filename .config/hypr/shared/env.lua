-- shared/env.lua
-- Always-safe to require, UWSM or not.
-- Never clobbers a var that is already in the process environ.
-- Fills holes: if a fallback key is missing from the environ, seed it via hl.env.
-- Returns the resolved table so a caller (hyprland.lua) can keep it alive.

---@class EnvVarKey : string
---@class EnvVarValue : string|number|integer|boolean

---@class EnvVarFallbacks : table<EnvVarKey, EnvVarValue>
local fallbacks = {
  -- Toolkit
  GDK_BACKEND = "wayland,x11",
  QT_QPA_PLATFORM = "wayland",
  SDL_VIDEODRIVER = "wayland",
  CLUTTER_BACKEND = "wayland",

  -- XDG
  XDG_CURRENT_DESKTOP = "Hyprland",
  XDG_SESSION_TYPE = "wayland",
  XDG_SESSION_DESKTOP = "Hyprland",

  -- Qt
  QT_AUTO_SCREEN_SCALE_FACTOR = 1,
  QT_WAYLAND_DISABLE_WINDOWDECORATION = 1,
  QT_QPA_PLATFORMTHEME = "hyprqt6engine,qt6ct",

  -- NVIDIA
  GBM_BACKEND = "nvidia-drm",
  __GLX_VENDOR_LIBRARY_NAME = "nvidia",
  LIBVA_DRIVER_NAME = "nvidia",
  __GL_GSYNC_ALLOWED = 1,
  __GL_VRR_ALLOWED = 0,

  -- Theme
  GTK_THEME = "Tokyonight-Dark-B",
  HYPRCURSOR_THEME = "Hyprcursor-Bibata-Modern-Classic",
  HYPRCURSOR_SIZE = 24,
  XCURSOR_THEME = "Bibata-Modern-Classic",
  XCURSOR_SIZE = 24,

  -- Other
  WLR_RENDERER_ALLOW_SOFTWARE = 1,
  WLR_NO_HARDWARE_CURSORS = 1,
  NVD_BACKEND = "direct",
  ELECTRON_OZONE_PLATFORM_HINT = "wayland",
  WEBKIT_DISABLE_DMABUF_RENDERER = 1,
  MOZ_ENABLE_WAYLAND = 1,

  -- Session selectors
  -- HYPRLAND_SHELL: folder name under ~/.config/hypr/ (vanilla/ dms/ noctalia/)
  -- WALLPAPER_BACKEND: daemon to start, or "native" = do not start a hypr-side daemon.
  HYPRLAND_SHELL = "dms",
  WALLPAPER_BACKEND = "wallpaperengine",
}

---@class EnvVarTable : EnvVarFallbacks
local envs = {}

-- lookup: cache -> os.getenv (already seeded, no hl.env) -> fallback + hl.env -> nil
-- Called from the load loop and from `envs[k]` via __index.
---@param t table<EnvVarKey, EnvVarValue>
---@param key EnvVarKey
---@return EnvVarValue?
local function lookup(t, key)
  local cached = rawget(t, key)
  if cached ~= nil then
    return cached
  end

  local existing = os.getenv(key)
  if existing ~= nil then
    rawset(t, key, existing)
    return existing
  end

  local fb = fallbacks[key]
  if fb == nil then
    return nil
  end

  rawset(t, key, fb)
  hl.env(key, fb)
  ---@cast fb EnvVarValue
  return fb
end

---@param t table<EnvVarKey, EnvVarValue>
---@param key EnvVarKey
---@param value EnvVarValue
local function assign(t, key, value)
  rawset(t, key, value)
  hl.env(key, value)
end

setmetatable(envs, {
  __index = lookup,
  __newindex = assign,
})

for k in pairs(fallbacks) do
  lookup(envs, k)
end

if not _G.envs then
  _G.envs = envs
end

---@type EnvVarTable
---@return EnvVarTable
return envs
