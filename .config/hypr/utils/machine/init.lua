-- Detected host proxy. `.monitors` / `.layout` / `.kind` are THIS machine.

local root_shrd = require("utils.root_shared")
local lst = require("utils.lst")

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

  -- find_map, not map: map always walks the whole list and later nils would
  -- overwrite an earlier hit. return from find_map is the function-level exit.
  return lst.find_map(sources, function(src)
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
    return as_host_str(raw)
  end)
end

---@param want str
---@return str|nil, HyprConfig.Machine|nil
local match_host = function(want)
  local direct = loaded[want]
  if type(direct) == "table" then
    return want, direct
  end

  -- We _intentionally_ capture r and return r here
  -- despite not _actually_ needing to because LuaLS has a fit otherwise.

  ---@cast loaded table<str, HyprConfig.Machine|true>
  local r = require("utils.tbl").find(loaded, function(_, mod)
    if type(mod) ~= "table" then
      return false
    end
    return lst.find(mod.aliases or {}, function(alias)
      return as_host_str(alias) == want
    end) ~= nil
  end)
  return r
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
---@field monitor_main fun(): string|integer|nil
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
  return lst.find(host.monitors or {}, function(m)
    return m.output == output
  end)
end

machine.monitor_main = function()
  local mons = host.monitors or {}
  if #mons == 0 then
    return nil
  end
  return mons[1].output
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
