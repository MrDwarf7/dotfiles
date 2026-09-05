--- Shared autostart execs.
--- These run for ALL shell variants (vanilla and DMS).
--- Shell-specific execs belong in vanilla/ or dms/.

local types = require("types")

--- A table of exec callbacks for the START and SHUTDOWN events.
--- Each field is a list of HL.Dispatcher instances that will be executed
--- when the corresponding event occurs.
---
---@generic D : HL.Dispatcher
---@class HyprConfig.ExecCallbacks
---@field on_start D[] To be paired with HyprConfig.Events<HL.EventName.START> for registration.
---@field on_shutdown D[] To be paired with HyprConfig.Events<HL.EventName.SHUTDOWN> for registration.
---@field __event_subscriptions HL.EventSubscription[] Internal use: stores the event subscription handles for cleanup if needed.
---@field push_event_subs fun(self: HyprConfig.ExecCallbacks, subs: HL.EventSubscription[]): Success Pushes a list of event subscriptions to the internal `__event_subscriptions` table for cleanup if needed.

---@type HyprConfig.ExecCallbacks
local all_callbacks = {
  on_start = {
    -- PulseAudio: unmute default sink on startup
    hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0"),

    -- OpenRGB: start minimized (case lights)
    hl.dsp.exec_cmd("openrgb --startminimized 2>&1 >/dev/null & disown"),

    -- USB auto-mounting via udiskie (as uwsm service)
    require("utils").uwsm_launcher("udiskie -n -t -m flat", true),

    -- Telegram on workspace 6 (silent = don't switch to it)
    hl.dsp.exec_cmd("Telegram"),

    -- Start Hermes gateway services (delayed to avoid blocking boot)
    hl.dsp.exec_cmd("sleep 3 && systemctl --user start hermes.target"),
  },

  -- Add any shutdown-related dispatchers here
  on_shutdown = {

    -- OpenRGB: start minimized (case lights)
    hl.dsp.exec_cmd("openrgb --autostart-enable '--startminimized' 2>&1 >/dev/null & disown"),
  },

  -- Add additional event types as HL adds them or they're needed; e.g., on_suspend, on_resume, etc.

  __event_subscriptions = {}, -- Internal use: stores the event subscription handles for cleanup if needed
}

-- stylua: ignore start
all_callbacks.push_event_subs = function(self, subs)
  if type(subs) ~= "table" then error("Event subscriptions must be provided as a table.") end
  if #subs == 0 then error("Event subscriptions table is empty.") end
  if not self.__event_subscriptions then
    self.__event_subscriptions = {}
  end
  table.insert(self.__event_subscriptions, subs)
  return true
end
-- stylua: ignore end

--- Registers the provided callbacks for keys -
--- Defined in `all_callbacks` - with the corresponding Hyprland events.
--- `on_<T>` where:
---   `T`: `HyprConfig.Events<HL.EventName>` | `HL.EventName`
---
---@param callbacks HyprConfig.ExecCallbacks
---@return Success Returns true if setup completed successfully, or an error message if not.
local setup = function(callbacks)
  if type(callbacks) ~= "table" then
    error("Callbacks must be provided as a table.")
  end
  local cbs = callbacks or {}

  if not cbs.on_start and not cbs.on_shutdown then
    error("No callbacks defined for execs setup.")
  end

  --- Registers a callback for a specific Hyprland event type.
  ---@param ev_type HyprConfig.Events<HL.EventName>
  ---@param cb CallbackFnPtr
  ---@return HL.EventSubscription?
  -- stylua: ignore start
  local on_event = function(ev_type, cb)
    return hl.on(ev_type, function() return hl.dispatch(cb) end)
  end
  -- stylua: ignore end

  --- Walks the provided `callbacks` table and registers each callback for the corresponding event type.
  ---@param cbs_list CallbackFnPtrList
  ---@param ev_type HyprConfig.Events<HL.EventName>
  ---@return HL.EventSubscription?[]
  ---@return Success
  -- stylua: ignore start
  local walk_cbs = function(cbs_list, ev_type)
    ---@type (HL.EventSubscription)?[]
    local subs = {}
    if #cbs_list ~= 0 then
      ---@param cb CallbackFnPtr
      table.insert(subs, require("utils.lst").map(cbs_list, function(cb) return on_event(ev_type, cb) end))
    end
    return subs, true
  end
  -- stylua: ignore end

  ---@diagnostic disable-next-line: unused-local
  local start_subs, start_ok = walk_cbs(cbs.on_start or {}, types.HyprlandEvents.START)
  ---@diagnostic disable-next-line: unused-local
  local shutdown_subs, shutdown_ok = walk_cbs(cbs.on_shutdown or {}, types.HyprlandEvents.SHUTDOWN)

  -- all_callbacks.push_event_subs(all_callbacks, { start = start_subs, shutdown = shutdown_subs })

  if not start_ok or not shutdown_ok then
    error("Failed to register one or more exec callbacks.")
  end
  return start_ok and shutdown_ok
end

---@return Success
return setup(all_callbacks)
