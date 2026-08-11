-- Detected host proxy. `.monitors` / `.layout` / `.kind` are THIS machine.

local root_shrd = require("utils.root_shared")

root_shrd.load_modules("utils.machine", {
  "fortress",
  "manbook",
})
local loaded = root_shrd.get("utils.machine") or {}

--- Class of string aliases for a machine. Each alias is a lowercase string.
---@class HyprConfig.Machine.aliases : str[]

--- General alias for a physical machine type.
--- This is used for conditional logic in configs, e.g. "if laptop then ...".
--- It also acts as a 'strong' name for HyprConfig.Machine.kind's `Str<S: MachineKind>`
---@alias MachineKind "desktop" | "laptop"

--- One physical machine's config.
--- This is the machine's own spec and is the
--- underlying data for a MachineView.
---
---
--- @see HyprConfig.MachineView For how this is _treated_
---
---@generic S : MachineKind
---@class HyprConfig.Machine
---@field kind Str<S>
---@field aliases HyprConfig.Machine.aliases
---@field monitors HL.MonitorSpec[]
---@field workspace_rules HL.WorkspaceRuleSpec[]
---@field layout? HL.ConfigOpt.Layout
---@field scrolling? HL.ConfigOpt.Scrolling

---@type HyprConfig.Machine
local blank = {
  kind = "laptop",
  aliases = {},
  monitors = {},
  workspace_rules = {},
  layout = {},
  scrolling = {},
}

---@param s OfAnyOrNil
---@return str|nil
local function as_host_str(s)
  if type(s) == "string" and s ~= "" then
    return string.lower(s)
  end
  return nil
end

--- Tag Type.
--- Used for XOR operation via `HostSource`
---@class HostSourceEnv
---@field env? EnvVarKey

--- Tag Type.
--- Used for XOR operation via `HostSource`
---@class HostSourceFile
---@field file? Path

--- Tagged Union Type.
--- Either an env var or a file path.
---@alias HostSource HostSourceEnv|HostSourceFile?

---@return str|nil
local function detect_hostname()
  --- Note the intentional ordering: `env` vars first, then `file`'s.
  --- This means we first check env's before performing IO operations.
  ---@type HostSource[]
  local sources = {
    { env = "HOSTNAME" },
    { env = "HOST" },
    { env = "COMPUTERNAME" },
    { file = "/proc/sys/kernel/hostname" },
    { file = "/etc/hostname" },
  }

  for _, src in ipairs(sources) do
    local raw
    if src.env then
      raw = os.getenv(src.env)
    elseif src.file then
      local f = io.open(src.file, "r")
      if f then
        raw = f:read("*l")
        f:close()
      end
    end
    local hit = as_host_str(raw)
    if hit then
      return hit
    end
  end
  return nil
end

---@param want str
---@return str|nil, HyprConfig.Machine|nil
local function match_host(want)
  local direct = loaded[want]
  if type(direct) == "table" then
    return want, direct
  end

  ---@cast loaded table<str, HyprConfig.Machine>
  for name, mod in pairs(loaded) do
    if type(mod) == "table" then
      for _, alias in ipairs(mod.aliases or {}) do
        if as_host_str(alias) == want then
          return name, mod
        end
      end
    end
  end
  return nil, nil
end

local hostname = detect_hostname()
local key, host = nil, blank
if hostname then
  key, host = match_host(hostname)
  host = host or blank
end

-- Singular: this module IS the detected machine, plus a couple of helpers.
---@class HyprConfig.MachineView : HyprConfig.Machine
---@field current str|nil canonical host key
---@field get fun(name?: str): HyprConfig.Machine
---@field monitor fun(output: str): HL.MonitorSpec|nil
local machine = {
  current = key,
}

machine.get = function(name)
  local n = as_host_str(name)
  if not n then
    return host
  end
  local _, mod = match_host(n)
  return mod or blank
end

machine.monitor = function(output)
  for _, m in ipairs(host.monitors or {}) do
    if m.output == output then
      return m
    end
  end
  return nil
end

setmetatable(machine, {
  __index = host,
  __call = function(_, name)
    return machine.get(name)
  end,
})

---@type HyprConfig.MachineView
---@return HyprConfig.MachineView
return machine
