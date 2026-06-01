--- Shared autostart execs.
--- These run for ALL shell variants (vanilla and DMS).
--- Shell-specific execs belong in vanilla/ or dms/.

---@alias CallbackFnPtr function(...): nil
---@alias CallbackList table[CallbackFnPtr]

---@alias cbs_fn_t table[function(...): nil]

---@class HyprConfig.Events
local HyprlandEvents = {
  START = "hyprland.start",
  SHUTDOWN = "hyprland.shutdown",
}

local utils = require("utils")
-- local programs = require("shared.programs")

--- Directly modify the provided cbs_tbl by pushing any valid functions from extra_cbs, then return the modified cbs_tbl.
---@param cbs_tbl CallbackList Mutable - will be updated
---@param extra_cbs cbs_fn_t? Optional additional callbacks to merge with the defaults (e.g. from shell-specific modules)
---@return CallbackList Returns the modified cbs_tbl for convenience (same table that was passed in, but with extra_cbs merged in if provided)
local push_cb = function(cbs_tbl, extra_cbs)
  if extra_cbs and type(extra_cbs) == "table" then
    for _, cb in ipairs(extra_cbs) do
      if type(cb) == "function" then
        table.insert(cbs_tbl, cb)
      end
    end
  end
  return cbs_tbl
end

local start_wallpaperengine = function()
  -- utils.uwsm_launcher("wallpaperengine-gui -m", true)
  -- hl.exec_cmd("wallpaperengine-gui -m")

  -- Propagate Wayland/XDG vars to dbus
  -- NOTE: Commented out — redundant with dbus-broker + uwsm.
  -- dbus-broker reuses systemd's activation environment directly,
  -- so there's nothing to sync. The --all flag was also copying
  -- every env var on every boot for zero benefit.
  -- hl.exec_cmd("dbus-update-activation-environment --systemd --all")

  -- FIX: [the_fk] : start
  local l = require("utils.logger").new({
    enabled = false,
  })
  local inspect = require("libs.inspect")

  local wallpaper_backend = require("utils.wallpaper_backend")
  local detected_backend = wallpaper_backend.detect()
  local cmd = detected_backend.key or wallpaper_backend[detected_backend.name]

  l:log("Detected wallpaper backend: " .. inspect(detected_backend) .. " | Launching with command: " .. cmd)
  l:log("Full backend command: " .. wallpaper_backend.launch_cmd(cmd))
  l:log("Environment variables: " .. inspect(os.getenv))

  local cmd_output = wallpaper_backend.launch_cmd(cmd)
  hl.exec_cmd(cmd_output or "")
  -- FIX: [the_fk] : end
end

--- Default callbacks for the START event, with optional merging of extra callbacks provided by shell-specific modules.
---@param extra_cbs cbs_fn_t? Optional additional callbacks to merge with the defaults (e.g. from shell-specific modules)
---@return CallbackList Returns a list of callback functions to be registered for the START event, optionally merged with any extra callbacks provided.
local start_cbs = function(extra_cbs)
  ---@type CallbackList
  local ret = {
    function()
      -- PulseAudio: unmute default sink on startup
      hl.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0")

      -- USB auto-mounting via udiskie (as uwsm service)
      utils.uwsm_launcher("udiskie -n -t -m flat", true)

      -- Telegram on workspace 6 (silent = don't switch to it)
      hl.exec_cmd("Telegram", { workspace = "6 silent" })

      -- Start Hermes gateway services (delayed to avoid blocking boot)
      hl.exec_cmd("sleep 3 && systemctl --user start hermes.target")
    end,
    -- function()
    --   local wallpaper_backend = require("utils.wallpaper_backend")
    --   local detected_backend = wallpaper_backend.detect()
    --   local cmd = detected_backend.key or wallpaper_backend[detected_backend.name]
    --   hl.exec_cmd(wallpaper_backend.launch_cmd(cmd))
    -- end,
  }

  -- start_wallpaperengine() -- TODO:

  ret = push_cb(ret, extra_cbs)

  return ret
end

--- Default callbacks for the SHUTDOWN event, with optional merging of extra callbacks provided by shell-specific modules.
---@param extra_cbs cbs_fn_t? Optional additional callbacks to merge with the defaults (e.g. from shell-specific modules)
---@return CallbackList
local shutdown_cbs = function(extra_cbs)
  --
  local ret = {
    function()
      --
    end,
  }

  ret = push_cb(ret, extra_cbs)

  return ret
end

--- Registers the callbacks for the START and SHUTDOWN events. This should be called once during initialization to set up the shared execs for all shell variants.
---@return nil
local setup = function()
  for _, cb in ipairs(start_cbs()) do
    hl.on(HyprlandEvents.START, cb)
  end

  for _, cb in ipairs(shutdown_cbs()) do
    hl.on(HyprlandEvents.SHUTDOWN, cb)
  end
end

---@return nil
return setup()
