--- Hyprland Lua configuration entry point.
---
--- Shell selection via HYPRLAND_SHELL env var:
---   HYPRLAND_SHELL=vanilla  (default) — standard hyprland + waybar
---   HYPRLAND_SHELL=dms                — DankLinux DMS desktop
---   HYPRLAND_SHELL=noctalia           — Noctalia (future)
---
--- The env var value maps directly to a folder name (vanilla/, dms/, noctalia/),
--- each containing an init.lua that returns a table with a :setup() method.

local logger = require("utils.logger")

---@enum ShellVariant
local ShellVariant = {
  VANILLA = "vanilla",
  DMS = "dms",
}

local os_env_hyprland_shell = os.getenv("HYPRLAND_SHELL") -- for debugging

-- hl.env("WALLPAPER_BACKEND", "swww")
-- hl.env("WALLPAPER_BACKEND", "awww")
hl.env("WALLPAPER_BACKEND", "wallpaperengine")
-- IGNORE: This is instead; exported by UWSM in ~/.config/uwsm/env
hl.env("HYPRLAND_SHELL", "dms")

---@param override ShellVariant Optional override for shell selection (for testing or dynamic switching)
---@return string
local function active_shell(override)
  if override then
    print("[hyprland] Overriding shell with: " .. override)
    return override
  end
  return os.getenv("HYPRLAND_SHELL") or ShellVariant.VANILLA
end

local shared = require("shared")

-- Load and run shared config (env, programs, all hl.config sections, rules, keymaps)
shared = shared:setup()

-- Apply shared config tables
-- hl.config(shared_config)

-- Load and run shell-specific module
-- require("vanilla") -> vanilla/init.lua -> Vanilla:setup()
-- require("dms")     -> dms/init.lua     -> Dms:setup()
-- local shell_name = active_shell()

local shell_name = active_shell(ShellVariant.DMS)
if os_env_hyprland_shell ~= shell_name then
  print(
    "[hyprland] WARNING: HYPRLAND_SHELL env var '"
      .. (os_env_hyprland_shell or "nil")
      .. "' does not match active shell '"
      .. shell_name
      .. "'. Using active shell."
  )
  logger:log(
    "[hyprland] WARNING: HYPRLAND_SHELL env var '"
      .. (os_env_hyprland_shell or "nil")
      .. "' does not match active shell '"
      .. shell_name
      .. "'. Using active shell."
  )
end

logger:log("[hyprland] Active shell: " .. shell_name)
logger:log("[hyprland] From OS env: " .. (os_env_hyprland_shell or "nil"))

local variant_values = {}
for _, v in pairs(ShellVariant) do
  table.insert(variant_values, v)
end

for _, valid in ipairs(variant_values) do
  if shell_name == valid then
    print("[hyprland] Selected shell: " .. shell_name)
    logger:log("[hyprland] Selected shell: " .. shell_name)
    break
  end
end

local shell = require(shell_name)

if type(shell) == "table" and type(shell.setup) == "function" then
  print("[hyprland] Configuring for " .. shell_name .. " shell")
  shell:setup()
else
  print("[hyprland] ERROR: shell module '" .. shell_name .. "' missing or has no :setup()")
  print("[hyprland] Falling back to vanilla")
  logger:log("[hyprland] ERROR: shell module '" .. shell_name .. "' missing or has no :setup()")
  require("vanilla"):setup(shell_name)
end

-- return shared_config
