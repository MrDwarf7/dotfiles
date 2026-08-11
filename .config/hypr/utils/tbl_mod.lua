local tbl_mod = {}

--- Returns a list of all keys in the provided table.
---
---@generic T
---@param tbl table<T, any> (table) Table
---@return T[] : List of keys
tbl_mod.keys = function(tbl)
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
tbl_mod.values = function(tbl)
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
---@param tbl table<any, T> Table
---@param fn fun(value: T): any Function
---@return table : Table of transformed values
tbl_mod.map = function(tbl, fn)
  local ret = {} ---@type table<any, any>
  for k, v in pairs(tbl) do
    ret[k] = fn(v)
  end
  return ret
end

---@generic T
---@param tbl table<any, T> (table) Table
---@param fn fun(value: T): boolean (function) Function
---@return T[] : Table of filtered values
tbl_mod.filter = function(tbl, fn)
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
tbl_mod.contains = function(tbl, value, opts)
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
tbl_mod.is_empty = function(tbl)
  return next(tbl) == nil
end

tbl_mod.concat = function(a, b)
  local ret = {}
  for k, v in pairs(a) do
    ret[k] = v
  end
  for k, v in pairs(b) do
    ret[k] = v
  end
  return ret
end

--- Nested table -> Lua-ish string. Recursive.
---@param tbl Indexable
---@param indent? int
---@return str
tbl_mod.to_string = function(tbl, indent)
  indent = indent or 0
  local result = "{\n"
  local indent_str = string.rep("  ", indent + 1)
  for k, v in pairs(tbl) do
    local key_str = type(k) == "string" and string.format("%q", k) or tostring(k)
    if type(v) == "table" then
      result = result .. string.format("%s[%s] = %s,\n", indent_str, key_str, tbl_mod.to_string(v, indent + 1))
    else
      local value_str = type(v) == "string" and string.format("%q", v) or tostring(v)
      result = result .. string.format("%s[%s] = %s,\n", indent_str, key_str, value_str)
    end
  end
  result = result .. string.rep("  ", indent) .. "}"
  return result
end

setmetatable(tbl_mod, {
  __concat = function(a, b)
    return tbl_mod.concat(a, b)
  end,
  __call = function(_, tbl, indent)
    return tbl_mod.to_string(tbl, indent)
  end,
  __tostring = function(tbl)
    return tbl_mod.to_string(tbl)
  end,
})

return tbl_mod
