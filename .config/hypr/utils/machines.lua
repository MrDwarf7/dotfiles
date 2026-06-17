-- TODO: This file should probably become a module
-- honestly, and we return Machines from the init.lua in it...
-- ( also means we can move the types to eg: HyprConfig.Utils.Machines => HyprConfig.Machines.<stuff> )

---@class HyprConfig.Utils.Machines
local Machines = {}

---@alias HostKeys string
---@alias HostNames string

-- TODO: Still not super happy with
-- how the types are working here tbh...

---@class HyprConfig.Utils.Machines.Known : table<HostKeys, HostNames[]>
local known = {
  fortress = {
    "fortress",
    "daggertooth.morray",
  },
  manbook = {
    "manbook",
  },
}
Machines.known = known

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
    local function iter(tbl, k)
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
Machines.configs = _config

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
    hl.workspace_rule({ workspace = "1", monitor = "DP-1" }),
    hl.workspace_rule({ workspace = "2", monitor = "DP-1" }),
    hl.workspace_rule({ workspace = "3", monitor = "DP-1" }),
    hl.workspace_rule({ workspace = "4", monitor = "DP-1" }),
    hl.workspace_rule({ workspace = "5", monitor = "DP-1" }),
    hl.workspace_rule({ workspace = "6", monitor = "DP-1" }),
    hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-2" }),
    hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-2" }),
    hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-2" }),
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
    hl.workspace_rule({ workspace = "1", monitor = "eDP-1" }),
    hl.workspace_rule({ workspace = "2", monitor = "eDP-1" }),
    hl.workspace_rule({ workspace = "3", monitor = "eDP-1" }),
    hl.workspace_rule({ workspace = "4", monitor = "eDP-1" }),
    hl.workspace_rule({ workspace = "5", monitor = "eDP-1" }),
    hl.workspace_rule({ workspace = "6", monitor = "eDP-1" }),
    hl.workspace_rule({ workspace = "7", monitor = "eDP-1" }),
    hl.workspace_rule({ workspace = "8", monitor = "eDP-1" }),
    hl.workspace_rule({ workspace = "9", monitor = "eDP-1" }),
  }
  c.layout = {
    single_window_aspect_ratio = { 16, 10 },
  }
  c.scrolling = {
    fullscreen_on_one_column = true,
  }
end

-- Hostname detection

local function detect_hostname()
  local h = os.getenv("HOSTNAME")
  if h and h ~= "" then
    return h:lower()
  end
  local hostname_file = "/proc/sys/kernel/hostname"
  local f = io.open(hostname_file, "r")

  if not f then
    hostname_file = "/etc/hostname"
    f = io.open(hostname_file, "r")
  end

  if f then
    h = f:read("*l")
    f:close()
  end
  return h and h:lower() or ""
end

local function current_canon()
  local hostname = detect_hostname()
  if hostname == "" then
    return nil
  end
  return canon[hostname]
end

-- Public API — no machine names leaked

---@param output_name? string If provided, only the spec for that output.
---@return HL.MonitorSpec[]
function Machines.monitors(output_name)
  local cn = current_canon()
  if not cn then
    return {}
  end
  local cfg = _config[cn]
  if not cfg then
    return {}
  end
  if output_name then
    for _, m in ipairs(cfg.monitors) do
      if m.output == output_name then
        return { m }
      end
    end
    return {}
  end
  return cfg.monitors
end

---@return HL.WorkspaceRuleSpec[]
function Machines.workspace_rules()
  local cn = current_canon()
  if not cn then
    return {}
  end
  Machines.current = cn
  local cfg = _config[cn]
  return cfg and cfg.workspace_rules or {}
end

---@return HL.ConfigOpt.Layout
function Machines.layout()
  local cn = current_canon()
  if not cn then
    return {}
  end
  Machines.current = cn
  local cfg = _config[cn]
  return cfg and cfg.layout or {}
end

function Machines.scrolling()
  local cn = current_canon()
  if not cn then
    return {}
  end
  Machines.current = cn
  local cfg = _config[cn]
  return cfg and cfg.scrolling or {}
end

--- Resolve any key (alias or canonical) to its config table.
---@param key string
---@return table|nil
function Machines.get(key)
  if not Machines.current then
    local cn = current_canon()
    if cn then
      Machines.current = cn
    end
  end
  return _config[key]
end

-- Backward compat: Machines("fortress") returns config

setmetatable(Machines, {
  __call = function(_, key)
    local cfg = _config[key]
    if cfg then
      Machines.current = key
      RootShared.machine = key
      return cfg
    end
    print("Warning: No configuration found for machine '" .. tostring(key) .. "'. Returning empty config.")
    return { monitors = {}, workspace_rules = {} }
  end,
})

return Machines
