local List = {}

--- Checks if a list (array-like table) contains a specific value.
---@param tbl table The list to search in.
---@param value any The value to search for.
List.list_contains = function(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

--- @generic T
--- @param tbl T[]
--- @param key? string|fun(x: T): any Optional field name or hash function to determine uniqueness of values
--- @return T[] : The deduplicated list
List.list_unique = function(tbl, key)
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
List.bisect = function(tbl, val, opts)
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

return List
