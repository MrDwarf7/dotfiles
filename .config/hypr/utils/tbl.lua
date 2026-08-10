local Tbl = {}

--- Returns a list of all keys in the provided table.
---
---@generic T
---@param tbl table<T, any> (table) Table
---@return T[] : List of keys
Tbl.keys = function(tbl)
  local keys = {}
  for k in pairs(tbl) do
    table.insert(keys, k)
  end
  return keys
end

--- Returns a list of all keys in the provided table.
---
---@generic T
---@param tbl table<any, T> (table) Table
---@return T[] : List of keys
Tbl.values = function(tbl)
  local keys = {}
  for k in pairs(tbl) do
    table.insert(keys, k)
  end
  return keys
end

--- Applies a transformation function to each value in the provided table
--- and returns a new table with the transformed values.
--- No garuntee is made about the order of the returned table due to how `pairs()` works.
---
---@generic T
---@param fn fun(value: T): any Function
---@param tbl table<any, T> Table
---@return table : Table of transformed values
Tbl.map = function(fn, tbl)
  local ret = {} ---@type table<any, any>
  for k, v in pairs(tbl) do
    ret[k] = fn(v)
  end
  return ret
end

---@generic T
---@param fn fun(value: T): boolean (function) Function
---@param tbl table<any, T> (table) Table
---@return T[] : Table of filtered values
Tbl.filter = function(fn, tbl)
  local ret = {} ---@type table<any, any>
  for _, entry in pairs(tbl) do
    if fn(entry) then
      ret[#ret + 1] = entry
    end
  end
  return ret
end

--- Checks if a table contains a specific value.
---@param tbl table The table to search in.
---@param value any The value to search for.
---@param opts? { predicate: function } Optional settings for the search (e.g., case sensitivity, deep search).
---@return boolean Returns true if the value is found, false otherwise.
Tbl.contains = function(tbl, value, opts)
  local pred --- @type fun(v: any): boolean?
  if opts and opts.predicate and type(opts.predicate) == "function" then
    pred = value
  else
    pred = function(v)
      return v == value
    end
  end
  for _, v in pairs(tbl) do
    if pred(v) then
      return true
    end
  end
  return false
end

--- Checks if a table is empty (has no key-value pairs).
---@param tbl table The table to check.
---@return boolean Returns true if the table is empty, false otherwise.
Tbl.is_empty = function(tbl)
  return next(tbl) == nil
end

Tbl.concat = function(a, b)
  local ret = {}
  for k, v in pairs(a) do
    ret[k] = v
  end
  for k, v in pairs(b) do
    ret[k] = v
  end
  return ret
end

setmetatable(Tbl, {
  __concat = function(a, b)
    return Tbl.concat(a, b)
  end,
})

return Tbl
