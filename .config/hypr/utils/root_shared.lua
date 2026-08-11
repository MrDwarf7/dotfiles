-- Batch-require helper for a directory of child modules
-- (shared/, shared.keymaps/, shared.rules/, ...).
-- `seen[prefix][name]` is the module return (or `true` if the module returned nil).
-- `_G.root_shrd` is set for early load; consumers may also require this file.

--- Prefix -> (module name -> require() result). `true` means loaded, returned nil.
--- Keys are always dotted (`"shared."`). Callers never write these; use get / get_or_insert.
---@class HyprConfig.RootShared.Seen : table<str, table<str, OfAny|true>>

--- Shared child-module loader. Also a small bag for extra keys
--- (e.g. machine.lua writes `.machine`).
---@class HyprConfig.RootShared
---@field seen HyprConfig.RootShared.Seen
---@field get fun(here: str|LuaPath): table<str, OfAny|true>|nil
---@field get_or_insert fun(here: str|LuaPath): table<str, OfAny|true>|nil
---@field load_modules fun(here: str, modules_tbl: str[]): bool
---@field machine? str
local root_shrd = {
  seen = {},
}

--- Trailing-dot prefix. `"shared"` and `"shared."` are the same key.
---@param here str|LuaPath|OfAnyOrNil
---@return str|nil
local function prefix(here)
  if type(here) ~= "string" or here == "" then
    return nil
  end
  if here:sub(-1) ~= "." then
    here = string.format("%s.", here)
  end
  return here
end

--- Existing bucket, or nil. Does not create.
---@param here str|LuaPath
---@return table<str, OfAny|true>|nil
local function get(here)
  local p = prefix(here)
  if not p then
    return nil
  end
  return root_shrd.seen[p]
end

--- Existing bucket, or a new empty one. HashMap entry().or_insert({}).
---@param here str|LuaPath
---@return table<str, OfAny|true>|nil
local function get_or_insert(here)
  local p = prefix(here)
  if not p then
    return nil
  end
  local bucket = root_shrd.seen[p]
  if not bucket then
    bucket = {}
    root_shrd.seen[p] = bucket
  end
  return bucket
end

--- Require every name in `modules_tbl` under `here`.
--- `here` may omit the trailing dot. Already-seen names are skipped.
--- Missing modules still error (no pcall).
--- Signature stays `(here, names) -> bool` so shared/init.lua keep working.
--- The bucket is `get(here)` / `get_or_insert(here)` after this returns.
---@param here str|LuaPath require-prefix
---@param modules_tbl LuaPath[] module names under that prefix
---@return bool
local function load_modules(here, modules_tbl)
  if type(here) ~= "string" or type(modules_tbl) ~= "table" then
    return false
  end

  local bucket = get_or_insert(here)
  local p = prefix(here)
  if not bucket or not p then
    return false
  end

  for _, mod in ipairs(modules_tbl) do
    if bucket[mod] == nil then
      local fullpath = string.format("%s%s", p, mod)
      local loaded = require(fullpath)
      -- nil-returning (side-effect) modules must not look unloaded on the next call
      bucket[mod] = loaded == nil and true or loaded
    end
  end
  return true
end

root_shrd.get = get
root_shrd.get_or_insert = get_or_insert
root_shrd.load_modules = load_modules

setmetatable(root_shrd, {
  __index = function(self, key)
    return get(key) or rawget(self, key) or nil
  end,
  __call = function(self, here, modules_tbl)
    return self.load_modules(here, modules_tbl)
  end,
})

if not _G.root_shrd then
  _G.root_shrd = root_shrd
end

---@type HyprConfig.RootShared
---@return HyprConfig.RootShared
return root_shrd
