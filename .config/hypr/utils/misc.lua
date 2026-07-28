local Misc = {}

---@generic T
---@param key? string|fun(val: T): any
---@return fun(v: T): any
Misc.make_key_fn = function(key)
  if not key then
    return function(v)
      return v
    end
  end

  if type(key) == "string" then
    local field = key
    ---@param v any
    key = function(v)
      return v and v[field]
    end
  end

  return key
end

--- Dynamic binary search functions for sorted arrays.
--- These functions allow you to find the lower and upper bounds of a value in a sorted array,
--- using a custom key function to extract the comparison value from each element.
---
---@generic T
---@param t T[]
---@param val T
---@param lo integer
---@param hi integer
---@param key_fn fun(val: any): any
---@return integer i in range such that `t[j]` < {val} for all j < i,
---                and `t[j]` >= {val} for all j >= i,
---                or return {hi} if no such index is found.
Misc.lower_bound = function(t, val, lo, hi, key_fn)
  local bit = require("bit") -- Load bitop on demand
  local val_key = key_fn(val)
  while lo < hi do
    local mid = bit.rshift(lo + hi, 1) -- Equivalent to floor((lo + hi) / 2)
    if key_fn(t[mid]) < val_key then
      lo = mid + 1
    else
      hi = mid
    end
  end
  return lo
end

--- Dynamic binary search functions for sorted arrays.
---
---@generic T
---@param t T[]
---@param val T
---@param lo integer
---@param hi integer
---@param key_fn fun(val: any): any
---@return integer i in range such that `t[j]` <= {val} for all j < i,
---                and `t[j]` > {val} for all j >= i,
---                or return {hi} if no such index is found.
Misc.upper_bound = function(t, val, lo, hi, key_fn)
  local bit = require("bit") -- Load bitop on demand
  local val_key = key_fn(val)
  while lo < hi do
    local mid = bit.rshift(lo + hi, 1) -- Equivalent to floor((lo + hi) / 2)
    if val_key < key_fn(t[mid]) then
      hi = mid
    else
      lo = mid + 1
    end
  end
  return lo
end

return Misc
