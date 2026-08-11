-- TODO: This file should probably become a module
-- honestly, and we return Machines from the init.lua in it...
-- ( also means we can move the types to eg: HyprConfig.Utils.Machines => HyprConfig.Machines.<stuff> )

---@class HyprConfig.Utils.Machines
local machines = {}

local root_shrd = require("utils.root_shared")

---@alias HostKeys string
---@alias HostNames string

-- TODO: Still not super happy with
-- how the types are working here tbh...

---@class HyprConfig.Utils.Machines.Known : table<HostKeys, HostNames[]>
local known = {
  fortress = {
    "Fortress",
    "fortress",
    "fortress.daggertooth.morray",
    "daggertooth.morray",
  },
  manbook = {
    "manbook",
    "manbook.daggertooth.morray",
    "daggertooth.morray",
  },
}
machines.known = known

-- Flat alias resolver
-- Canonical key (from `known`) → itself
-- Any alias (wrong case, alternate hostname) → canonical key
-- Built lazily via __index, cached on first access via rawset.

local canon = setmetatable({}, {
  __index = function(t, name)
    name = name:lower()
    for cname, aliases in pairs(known) do
      if cname:lower() == name then
        rawset(t, name, cname)
        return cname
      end
      for _, alias in ipairs(aliases) do
        if alias:lower() == name then
          rawset(t, name, cname)
          return cname
        end
      end
    end
    return nil
  end,
})

-- Config store + proxy
-- Canonical keys (from known) are stored via rawset.
-- Any other key (alias, wrong case, etc.) resolves through
-- __index → canon → rawget on the real canonical slot.
-- __newindex always routes through canon; unknown keys get
-- a direct rawset (graceful fallback, not an error).

local _config = setmetatable({}, {
  __index = function(t, k)
    local cname = canon[k]
    if cname then
      return rawget(t, cname)
    end
    return nil
  end,
  __newindex = function(t, k, v)
    local cname = canon[k] or k
    rawset(t, cname, v)
  end,
  __pairs = function(t)
    -- Only yield canonical (known) entries, not cached alias pointers
    local iter = function(tbl, k)
      local nk, nv = next(tbl, k)
      while nk and canon[nk] ~= nil and canon[nk] ~= nk do
        -- skip alias-only entries that leaked in? shouldn't happen but belt-and-suspenders
        nk, nv = next(tbl, nk)
      end
      return nk, nv
    end
    return iter, t, nil
  end,
})
machines.configs = _config

-- Populate from known
-- Machine strings appear ONLY in the comparison branches below.
-- No string literals used as keys — the loop variable `cname`
-- is the canonical name, sourced from the `known` table.

for cname in pairs(known) do
  _config[cname] = {
    ---@type HL.MonitorSpec[]
    monitors = {},
    ---@type HL.WorkspaceRuleSpec[]
    workspace_rules = {},
  }
end

-- Fill fortress config
do
  local c = _config["fortress"]
  ---@type HL.MonitorSpec[]
  c.monitors = {
    {
      output = "DP-1",
      mode = "5120x1440@239.74",
      position = "0x0",
      scale = "1.0",
      transform = false,
      vrr = 3,
      bitdepth = 10,
      cm = "hdredid",
      supports_wide_color = 1,
      sdrbrightness = 0.2895,
      sdrsaturation = 1.40,
      sdr_min_luminance = 0.005,
      sdr_max_luminance = 1000,
      min_luminance = 0.005,
      max_luminance = 1000,
      max_avg_luminance = 400,
      sdr_eotf = "gamma22force",
    },
    {
      output = "HDMI-A-2",
      disabled = false,
      mode = "1920x1080@74",
      position = "5120x300",
      scale = "1.0",
      transform = false,
      bitdepth = 8,
      vrr = 0,
    },
  }
  -- stylua: ignore start
  ---@type HL.WorkspaceRuleSpec[]
  c.workspace_rules = {
    { workspace = "1", monitor = "DP-1" },
    { workspace = "2", monitor = "DP-1" },
    { workspace = "3", monitor = "DP-1" },
    { workspace = "4", monitor = "DP-1" },
    { workspace = "5", monitor = "DP-1" },
    { workspace = "6", monitor = "DP-1" },
    { workspace = "7", monitor = "HDMI-A-2" },
    { workspace = "8", monitor = "HDMI-A-2" },
    { workspace = "9", monitor = "HDMI-A-2" },
  }
  -- stylua: ignore end
  c.layout = {
    single_window_aspect_ratio = { 21, 9 },
  }
end

-- Fill manbook config (currently empty — add specs from laptop)
do
  local c = _config["manbook"]
  ---@type HL.MonitorSpec[]
  c.monitors = {
    {
      output = "eDP-1",
      mode = "2560x1600",
      scale = "1.5",
      position = "0x0",
      transform = false,
      -- vrr = 3,
      -- bitdepth = 10,
      -- cm = "",
      -- supports_wide_color = 1,
    },
  }
  ---@type HL.WorkspaceRuleSpec[]
  c.workspace_rules = {
    { workspace = "1", monitor = "eDP-1" },
    { workspace = "2", monitor = "eDP-1" },
    { workspace = "3", monitor = "eDP-1" },
    { workspace = "4", monitor = "eDP-1" },
    { workspace = "5", monitor = "eDP-1" },
    { workspace = "6", monitor = "eDP-1" },
    { workspace = "7", monitor = "eDP-1" },
    { workspace = "8", monitor = "eDP-1" },
    { workspace = "9", monitor = "eDP-1" },
  }
  ---@type HL.ConfigOpt.Layout
  c.layout = {
    single_window_aspect_ratio = { 16, 10 },
  }
  ---@type HL.ConfigOpt.Scrolling
  c.scrolling = {
    fullscreen_on_one_column = true,
  }
end

-- Hostname detection

local detect_hostname = function()
  ---@alias TryForTable { envs: HostKeys[], locs: string[] }
  local try_for = {
    envs = {
      "HOSTNAME",
      "HOST",
      "COMPUTERNAME",
    },
    locs = {
      "/proc/sys/kernel/hostname",
      "/etc/hostname",
    },
  }

  ---@param local_h string|number|nil
  ---@return string|nil
  local h_type_handler = function(local_h)
    if type(local_h) == "nil" then
      local_h = ""
    elseif type(local_h) == "number" then
      local_h = string.format("%d", local_h)
      -- can handle other types here if need be
    end

    if local_h and local_h ~= "" then
      local_h = local_h:lower()
      return local_h
    end
    return nil
  end

  local h = nil
  local f = nil

  ---@param local_try_for TryForTable
  ---@return string|nil
  local envs_fn = function(local_try_for)
    for _, env in ipairs(local_try_for.envs) do
      h = os.getenv(env)
      h = h_type_handler(h)
      if h then
        return h:lower()
      end
    end
    return nil
  end

  ---@param local_try_for TryForTable
  ---@return string|nil
  local locs_fn = function(local_try_for)
    for _, loc in ipairs(local_try_for.locs) do
      f = io.open(loc, "r")
      if f then
        h = f:read("*l")
        f:close()
        h = h_type_handler(h)
        if h then
          return h:lower()
        end
      end
    end
    return nil
  end

  for _, fn in ipairs({ envs_fn, locs_fn }) do
    local result = fn(try_for)
    if result then
      return result
    end
  end
  -- handle the case where no hostname could be detected gracefully by returning an empty string
  return ""
end

---@param default_fallback string|nil A potential default to return if we cannot detect the hostname. If nil, we return nil instead of a default.
---@return string|nil The canonical machine name, or the default_fallback if hostname detection fails and a default is provided, or nil if detection fails and no default is provided.
local current_canon = function(default_fallback)
  local hostname = detect_hostname()
  if hostname == "" then
    if default_fallback and type(default_fallback) == "string" and default_fallback ~= "" then
      return default_fallback
    end
    return nil
  end
  return canon[hostname]
end

--- Internal lookup function that resolves any key (alias or canonical) to its config table,
--- without caching the current machine.
--- Used by public API functions to avoid redundant lookups.
---@param key any
---@return table
local lookup = function(key)
  if not key or type(key) ~= "string" then
    return {}
  end

  local cn = current_canon()
  if not cn then
    return {}
  end

  local cfg = _config[cn]
  machines.current = cn
  if type(cfg[key]) == "function" then
    return cfg[key]()
  end
  return cfg and cfg[key] or {}
end

-- Public API — no machine names leaked

--- Returns the monitor specs for the current machine
--- or for a specific output if provided.
---@param output_name? string If provided, only the spec for that output.
---@return HL.MonitorSpec[] | HL.MonitorSpec
function machines.monitors(output_name)
  -- -- i've no idea why... but urr, this 'nil's and the below code
  -- ( which is identical) doesn't....
  --
  -- local cfg = lookup("monitors")

  local cn = current_canon()
  if not cn then
    return {}
  end
  local cfg = _config[cn]
  if not cfg then
    return {}
  end
  machines.current = cn

  ---@type HL.MonitorSpec|nil
  local monitor
  if output_name then
    for _, m in ipairs(cfg.monitors) do
      if m.output == output_name then
        monitor = m
      end
    end
    if monitor then
      return monitor
    else
      print(
        "Warning: No monitor spec found for output '"
          .. tostring(output_name)
          .. "' on machine '"
          .. tostring(cn)
          .. "'. Returning empty table."
      )
      return {}
    end
  end

  return cfg.monitors
end

---@return HL.WorkspaceRuleSpec[]
function machines.workspace_rules()
  return lookup("workspace_rules")
  -- local cn = current_canon()
  -- if not cn then
  --   return {}
  -- end
  -- Machines.current = cn
  -- local cfg = _config[cn]
  -- return cfg and cfg.workspace_rules or {}
end

---@return HL.ConfigOpt.Layout
function machines.layout()
  return lookup("layout")
  -- local cn = current_canon()
  -- if not cn then
  --   return {}
  -- end
  -- Machines.current = cn
  -- local cfg = _config[cn]
  -- return cfg and cfg.layout or {}
end

function machines.scrolling()
  return lookup("scrolling")
end

--- Resolve any key (alias or canonical) to its config table.
---@param key string
---@return table|nil
function machines.get(key)
  return lookup(key)
  -- if not Machines.current then
  --   local cn = current_canon()
  --   if cn then
  --     Machines.current = cn
  --   end
  -- end
  -- return _config[key]
end

-- TODO: We will have to have a tag for these in the table itself, not manually checking against a str

function machines.is_laptop()
  local cn = current_canon("manbook")
  return cn == "manbook"
end

function machines.is_desktop()
  local cn = current_canon("fortress")
  return cn == "fortress"
end

-- Backward compat: Machines("fortress") returns config

setmetatable(machines, {
  __call = function(_, key)
    local cfg = _config[key]
    if cfg then
      machines.current = key
      root_shrd.machine = key
      return cfg
    end
    print("Warning: No configuration found for machine '" .. tostring(key) .. "'. Returning empty config.")
    return { monitors = {}, workspace_rules = {} }
  end,
})

return machines
