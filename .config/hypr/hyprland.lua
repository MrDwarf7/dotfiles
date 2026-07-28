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

-- TODO: Needs to be setup properly AND decide where it gets loaded lol...
-- local machines = require("utils.machines")
-- machines.setup()

LOGGER_ENABLED = false

local logger = require("utils.logger").new({
  enabled = LOGGER_ENABLED,
})

logger:log("Hyprland configuration started")

local WallpaperBackend = require("utils.wallpaper_backend")
local ShellBackend = require("utils.hyprland_shell")

hl.env("WALLPAPER_BACKEND", WallpaperBackend.detect().name)
-- IGNORE: This is instead; exported by UWSM in ~/.config/uwsm/env
hl.env("HYPRLAND_SHELL", ShellBackend.detect())

-- ---@deprecated Not really used, kinda just here for lolz rn?
---@class HyprConfig.RootShared
RootShared = {
  envs = {
    wallpaper_backend = WallpaperBackend.detect().name,
    hyprland_shell = ShellBackend.detect(),
  },

  --- Loads child modules from a given base path and a list of module names.
  ---@param here string The base path to the modules (e.g., "shared.keymaps.")
  ---@param modules_tbl table<string> A table of module names (e.g., {"mods", "map_general"})
  ---@return boolean
  load_modules = function(here, modules_tbl)
    if not here or not modules_tbl then
      logger:log("ERROR: load_modules called with nil here or modules_tbl")
      return false
    end

    if type(here) ~= "string" then
      logger:log("ERROR: load_modules called with non-string here: " .. tostring(here))
      return false
    end

    if type(modules_tbl) ~= "table" then
      logger:log("ERROR: load_modules called with non-table modules_tbl: " .. tostring(modules_tbl))
      return false
    end

    -- if there's no trailing dot, add one
    if here:sub(-1) ~= "." then
      here = here .. "."
    end

    for _, mod in ipairs(modules_tbl) do
      require(here .. mod)
    end
    return true
  end,
}

local shared = require("shared")
if type(shared) == "table" and type(shared.setup) == "function" then
  print("[hyprland] Running shared configuration")
  shared:setup()
elseif type(shared) == "table" then
  print("[hyprland] Assumed setup function called WITHIN 'shared.init' module!")
  logger:log("Assumed setup function called WITHIN 'shared.init' module!")
end

local shell_name = ShellBackend.get()
local ok, shell = pcall(require, shell_name)
if not ok then
  print("[hyprland] ERROR: Failed to load shell module '" .. shell_name .. "': " .. tostring(shell))
  print("[hyprland] Falling back to vanilla")
  logger:log("ERROR: Failed to load shell module '" .. shell_name .. "': " .. tostring(shell))
  require("vanilla"):setup()
  return
end

if type(shell) == "table" and type(shell.setup) == "function" then
  print("[hyprland] Configuring for " .. shell_name .. " shell")
  shell:setup()
  return
else
  print("[hyprland] ERROR: shell module '" .. shell_name .. "' missing or has no :setup()")
  print("[hyprland] Falling back to vanilla")
  logger:log("ERROR: shell module '" .. shell_name .. "' missing or has no :setup()")
  require("vanilla"):setup()
  return
end
