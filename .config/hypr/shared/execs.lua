--- Shared autostart execs.
--- These run for ALL shell variants (vanilla and DMS).
--- Shell-specific execs belong in vanilla/ or dms/.

---@alias CallbackFnPtr function(...): nil

---@generic F : CallbackFnPtr
---@alias CallbackList table<number, F>

---@alias cbs_fn_t table[function(...): nil]

local types = require("types")

local utils = require("utils")
local lst = require("utils.lst")
-- local programs = require("shared.programs")

--- Directly modify the provided cbs_tbl by pushing any valid functions from extra_cbs, then return the modified cbs_tbl.
---@param cbs_tbl CallbackList Mutable - will be updated
---@param extra_cbs cbs_fn_t? Optional additional callbacks to merge with the defaults (e.g. from shell-specific modules)
---@return CallbackList Returns the modified cbs_tbl for convenience (same table that was passed in, but with extra_cbs merged in if provided)
local push_cb = function(cbs_tbl, extra_cbs)
  if extra_cbs and type(extra_cbs) == "table" then
    lst.map(
      lst.filter(extra_cbs, function(cb)
        return type(cb) == "function"
      end),
      function(cb)
        cbs_tbl[#cbs_tbl + 1] = cb
      end
    )
  end
  return cbs_tbl
end

-- Not registered. WE-via-Hyprland is still buggy; call from hyprland.start if wanted.
local start_wallpaperengine = function()
  local wall_be = require("utils.wall_be")
  hl.exec_cmd(wall_be.cmd() or "")
end

--- Default callbacks for the START event, with optional merging of extra callbacks provided by shell-specific modules.
---@param extra_cbs cbs_fn_t? Optional additional callbacks to merge with the defaults (e.g. from shell-specific modules)
---@return CallbackList Returns a list of callback functions to be registered for the START event, optionally merged with any extra callbacks provided.
local start_cbs = function(extra_cbs)
  ---@type CallbackList
  local ret = {
    [1] = function()
      -- PulseAudio: unmute default sink on startup
      hl.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0")

      hl.exec_cmd("/usr/bin/openrgb --startminimized", { workspace = "6 silent" })

      -- USB auto-mounting via udiskie (as uwsm service)
      utils.uwsm_launcher("udiskie -n -t -m flat", true)

      -- Telegram on workspace 6 (silent = don't switch to it)
      hl.exec_cmd("Telegram", { workspace = "6 silent" })

      -- Start Hermes gateway services (delayed to avoid blocking boot)
      hl.exec_cmd("sleep 3 && systemctl --user start hermes.target")
    end,
  }

  -- start_wallpaperengine()

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
  -- TODO: We can _dramatically_ simplify this
  -- file now that Hyprland has proper lua runtime lodgement for tasks
  -- via `hl.dispatch()` as the consumer.
  -- We just needed to be _able_ to generate `HL.Dispatcher` types.
  --
  -- (hl.dsp.exec_cmd() | hl.dsp.global()) :: HL.Dispatcher -> map/accumulate -> hl.dispatch(T: HL.Dispatcher) -> { lodged }
  -- We only really need to have a list of calls that we _need to eventually_ make to generate dispatchers,
  -- then just run-through and lodge them.
  -- See: `https://wiki.hypr.land/configuring/core/dispatchers` for further info
  --
  -- hl.dsp.exec_cmd()
  -- hl.dsp.global()
  -- hl.dispatch()

  lst.map(start_cbs(), function(cb)
    return hl.on(types.HyprlandEvents.START, cb)
  end)

  -- for _, cb in ipairs(shutdown_cbs()) do
  --   hl.on(types.HyprlandEvents.SHUTDOWN, cb)
  -- end
end

---@return nil
return setup()
