--- Hyprland Lua configuration entry point.
---
--- Shell selection via HYPRLAND_SHELL env var:
---   HYPRLAND_SHELL=vanilla  (default) — standard hyprland + waybar
---   HYPRLAND_SHELL=dms                — DankLinux DMS desktop
---   HYPRLAND_SHELL=noctalia           — Noctalia (future)
---
--- The env var value maps directly to a folder name (vanilla/, dms/, noctalia/),
--- each containing an init.lua that returns a table with a :setup() method.

require("shared.env") -- literally the first thing we do.

local logger = require("utils.logger"):new()

---@enum ShellVariant
local ShellVariant = {
  VANILLA = "vanilla",
  DMS = "dms",
}

-- hl.env("WALLPAPER_BACKEND", "swww")
-- hl.env("WALLPAPER_BACKEND", "awww")
hl.env("WALLPAPER_BACKEND", "wallpaperengine")
-- IGNORE: This is instead; exported by UWSM in ~/.config/uwsm/env
hl.env("HYPRLAND_SHELL", "dms")

---@param override? ShellVariant Optional override for shell selection (for testing or dynamic switching)
---@return string
local function active_shell(override)
  if override then
    print("[hyprland] Overriding shell with: " .. override)
    return override
  end
  return os.getenv("HYPRLAND_SHELL") or ShellVariant.VANILLA
end

local shared = require("shared")
if type(shared) == "table" and type(shared.setup) == "function" then
  print("[hyprland] Running shared configuration")
  shared:setup()
else
  print("[hyprland] ERROR: shared module missing or has no :setup()")
  logger:log("[hyprland] ERROR: shared module missing or has no :setup()")
end

local shell_name = active_shell()
local shell = require(shell_name)

if type(shell) == "table" and type(shell.setup) == "function" then
  print("[hyprland] Configuring for " .. shell_name .. " shell")
  shell:setup()
  return
else
  print("[hyprland] ERROR: shell module '" .. shell_name .. "' missing or has no :setup()")
  print("[hyprland] Falling back to vanilla")
  logger:log("[hyprland] ERROR: shell module '" .. shell_name .. "' missing or has no :setup()")
  require("vanilla"):setup(shell_name)
  return
end
