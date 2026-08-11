-- Optional field snapshot for a table. Not pulled in by utils/init.lua.
-- Usage: reflect.attach(t) then getmetatable(t).__fields()

---@class HyprConfig.Reflect
---@field fields fun(tbl: Indexable): Indexable
---@field attach fun(tbl: Indexable): Indexable
local reflect = {}

--- Shallow copy of `tbl`'s own keys (pairs). Does not follow __index.
---@param tbl Indexable
---@return Indexable
reflect.fields = function(tbl)
  -- TODO: [metatable] : Shouldn't we check/defer to see if the .__fields function exists on the metatable and call that instead
  -- of just copying the table?
  -- This would allow for more complex field introspection if needed.
  -- _Should_ then be able to just directly call eg: foo.fields() -> { field_one = "some data", field_two = "some other data" }
  -- instead of having to call getmetatable(foo).__fields() to get the same result?
  local out = {}
  for k, v in pairs(tbl) do
    out[k] = v
  end
  return out
end

--- Put `__fields` on `tbl`'s metatable without dropping an existing one.
---@param tbl Indexable
---@return Indexable
reflect.attach = function(tbl)
  local mt = getmetatable(tbl)
  if type(mt) ~= "table" then
    mt = {}
  end
  mt.__fields = function()
    return reflect.fields(tbl)
  end
  return setmetatable(tbl, mt)
end

setmetatable(reflect, {
  __call = function(_, tbl)
    return reflect.attach(tbl)
  end,
})

---@type HyprConfig.Reflect
---@return HyprConfig.Reflect
return reflect
