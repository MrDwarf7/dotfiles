--- Hyprland Lua configuration entry point.
---
--- Shell selection via HYPRLAND_SHELL env var:
---   HYPRLAND_SHELL=vanilla  (default) — standard hyprland + waybar
---   HYPRLAND_SHELL=dms                — DankLinux DMS desktop
---   HYPRLAND_SHELL=noctalia           — Noctalia (future)
---
--- The env var value maps directly to a folder name (vanilla/, dms/, noctalia/),
--- each containing an init.lua that returns a table with a :setup() method.
---@module 'types'
---@type HyprTypes
TYPES = require("types")

hl = TYPES.hl

local envs = require("shared.env") -- first: seed holes, keep the returned table alive

-- TODO: Needs to be setup properly AND decide where it gets loaded lol...
-- local machines = require("utils.machines")
-- machines.setup()

LOGGER_ENABLED = false

local logger = require("utils.logger").new({
  enabled = LOGGER_ENABLED,
})

logger:log("Hyprland configuration started")

local shell_bkend = require("utils.shell")

---@type HyprConfig.RootShared
---@diagnostic disable-next-line: unused-local
local root_shrd = require("utils.root_shared")

local shared = require("shared")
if type(shared) == "table" and type(shared.setup) == "function" then
  print("[hyprland] Running shared configuration")
  shared:setup()
elseif type(shared) == "table" then
  print("[hyprland] Assumed setup function called WITHIN 'shared.init' module!")
  logger:log("Assumed setup function called WITHIN 'shared.init' module!")
end

local shell_name = shell_bkend.get(envs.HYPRLAND_SHELL)
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
