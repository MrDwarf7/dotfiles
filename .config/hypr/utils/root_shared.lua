-- Batch-require helper for a directory of child modules
-- (shared/, shared.keymaps/, shared.rules/, ...).
-- `seen` is what *this* loader started; package.loaded still makes require a no-op.
-- `_G.root_shrd` is set for early load; consumers may also require this file.

--- Prefix -> (module name -> full require path) for modules this loader has started.
---@generic P : table<string, PathLike>
---@class HyprConfig.RootShared.Seen<P> : table<string, PathLike>

--- Shared child-module loader. Also a small bag for extra keys
--- (e.g. machines.lua writes `.machine`).
---@generic R : table<table<string, PathLike>>
---@generic P : table<string, PathLike>
---@class HyprConfig.RootShared
---@field seen HyprConfig.RootShared.Seen<P|R>
---@field load_modules fun(here: string, modules_tbl: string[]): boolean
---@field machine? string last machine key written by utils.machines
local root_shrd = {
  seen = {},
}

--- Require every name in `modules_tbl` under `here`.
--- `here` may omit the trailing dot (`"shared"` == `"shared."`).
--- Already-seen names are skipped. A missing module still errors (no pcall).
---@param here string require-prefix
---@param modules_tbl string[] module names under that prefix
---@return boolean
local function load_modules(here, modules_tbl)
  if type(here) ~= "string" or type(modules_tbl) ~= "table" then
    return false
  end

  if here:sub(-1) ~= "." then
    here = string.format("%s.", here) ---@cast here LuaPath
  end

  local bucket = root_shrd.seen[here]
  if not bucket then
    bucket = {}
    root_shrd.seen[here] = bucket
  end

  for _, mod in ipairs(modules_tbl) do
    if not bucket[mod] then
      local fullpath = string.format("%s%s", here, mod)
      bucket[mod] = fullpath
      require(fullpath)
    end
  end
  return true
end

root_shrd.load_modules = load_modules

setmetatable(root_shrd, {
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
