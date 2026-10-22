-- Run from the Hyprland config directory: lua tests/env.lua
local function check(has_nvidia, inherited)
  local seeded = {}
  local chunk = assert(loadfile(
    "shared/env.lua",
    "t",
    setmetatable({
      hl = {
        env = function(key, value)
          seeded[key] = value
        end,
      },
      io = {
        open = function(path)
          assert(path == "/sys/module/nvidia_drm/initstate")
          return has_nvidia and { close = function() end } or nil
        end,
      },
      os = {
        getenv = function(key)
          return inherited[key]
        end,
      },
      _G = {},
    }, { __index = _G })
  ))
  local envs = chunk()
  assert(envs.HYPRLAND_SHELL == (inherited.HYPRLAND_SHELL or "dms"))
  if has_nvidia then
    assert(envs.GBM_BACKEND == (inherited.GBM_BACKEND or "nvidia-drm"))
    assert(envs.LIBVA_DRIVER_NAME == "nvidia")
  else
    assert(envs.GBM_BACKEND == inherited.GBM_BACKEND)
    assert(envs.LIBVA_DRIVER_NAME == nil)
    assert(envs.NVD_BACKEND == nil)
    assert(envs.WLR_RENDERER_ALLOW_SOFTWARE == nil)
  end
  for key in pairs(inherited) do
    assert(seeded[key] == nil)
  end
end
check(false, {})
check(true, {})
check(true, { GBM_BACKEND = "custom", HYPRLAND_SHELL = "vanilla" })
check(false, { GBM_BACKEND = "custom", HYPRLAND_SHELL = "vanilla" })
print("PASS: Intel/NVIDIA fallbacks and inherited environment precedence")
