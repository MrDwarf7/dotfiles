local list = {}

--- Checks if a list (array-like table) contains a specific value.
---@param needle any The value to search for.
---@param haystack table The list (array-like table) to search in.
list.contains = function(needle, haystack)
  for i, v in ipairs(haystack) do
    if type(v) == "nil" then
      goto continue
    end
    if v == needle then
      return true
    end
    ::continue::
    local next = i + 1
    if next > #haystack then
      break
    end
  end
  return false
end

--- @generic T
--- @param tbl T[]
--- @param key? string|fun(x: T): any Optional field name or hash function to determine uniqueness of values
--- @return T[] : The deduplicated list
list.unique = function(tbl, key)
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
list.bisect = function(tbl, val, opts)
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

return list
