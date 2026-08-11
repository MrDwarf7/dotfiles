---@class VimExtLst
local lst = {}

--- Checks if a list (array-like table) contains a specific value.
---@param tbl table The list (array-like table) to search in.
---@param item any The value to search for.
lst.contains = function(tbl, item)
  return lst.find(tbl, function(v)
    return v == item
  end) ~= nil
end

--- Apply `fn` to each array element in order. Same shape as tbl_mod.map (tbl, fn)
--- but ipairs, not pairs. Return values of `fn` are collected; discard if unused.
---@generic T
---@generic R
---@param tbl T[]
---@param fn fun(value: T): R
---@return R[]
lst.map = function(tbl, fn)
  local ret = {}
  for i, v in ipairs(tbl) do
    ret[i] = fn(v)
  end
  return ret
end

-- --- Applies `list.map` and takes a variable amount of
-- list.map_mut = function(tbl, fn, sentinel)
--   -- local args = { ... }
-- end

--- Keep array elements for which `fn` is true. ipairs; does not mutate `tbl`.
---@generic T
---@param tbl T[]
---@param fn fun(value: T): boolean
---@return T[]
lst.filter = function(tbl, fn)
  local ret = {}
  for _, v in ipairs(tbl) do
    if fn(v) then
      ret[#ret + 1] = v
    end
  end
  return ret
end

--- First element for which `fn` is true, in ipairs order. Stops early.
---@generic T
---@param tbl T[]
---@param fn fun(value: T): boolean
---@return T|nil
lst.find = function(tbl, fn)
  for _, v in ipairs(tbl) do
    if fn(v) then
      return v
    end
  end
  return nil
end

--- First non-nil `fn(item)`, in ipairs order. Stops early.
---@generic T
---@generic R
---@param tbl T[]
---@param fn fun(value: T): R|nil
---@return R|nil
lst.find_map = function(tbl, fn)
  for _, v in ipairs(tbl) do
    local r = fn(v)
    if r ~= nil then
      return r
    end
  end
  return nil
end

--- @generic T
--- @param tbl T[]
--- @param key? string|fun(x: T): any Optional field name or hash function to determine uniqueness of values
--- @return T[] : The deduplicated list
lst.unique = function(tbl, key)
  --
  local misc = require("utils.misc")
  local key_fn = misc.make_key_fn(key)
  local seen = {} ---@type table<any, boolean>

  local finish = #tbl

  local j = 1
  for i = 1, finish do
    local v = tbl[i]
    local vh = key_fn(v)
    if not seen[vh] then
      tbl[j] = v
      if vh ~= nil then
        seen[vh] = true
      end
      j = j + 1
    end
  end

  for i = j, finish do
    tbl[i] = nil
  end
  return tbl
end

---@generic T
---@param tbl T[] A comparable list.
---@param val T The value to search.
---@param opts table? Optional settings for the search (e.g., case sensitivity, deep search).
---@return integer index serves as either the lower bound or the upper bound position.
lst.bisect = function(tbl, val, opts)
  opts = opts or {}
  local misc = require("utils.misc")

  local lo = opts.lo or 1
  local hi = opts.hi or (#tbl + 1)
  local key_fn = misc.make_key_fn(opts.key)

  local f = nil ---@type fun(tbl: table, val: any, lo: integer, hi: integer, key_fn: fun(val: any): any): integer

  if opts.bound == "upper" then
    f = misc.upper_bound
  else
    f = misc.lower_bound
  end
  return f(tbl, val, lo, hi, key_fn)
end

return lst
