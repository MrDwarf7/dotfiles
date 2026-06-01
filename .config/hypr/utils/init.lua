---@class HyprConfig.Utils
local Utils = {}

--- Given a table (or module/class) - we build a T.__fields table onto it that contains its own fields for reflection purposes later.
--- We do NOT want to hold the table itself in the meta, to avoid circular references and potential memory leaks, so we use rawget to access the fields directly from the table.
---@param mut_tbl table The table to set up with reflection.
Utils.reflection = function(mut_tbl)
  --
  setmetatable(mut_tbl, {
    __fields = function()
      -- here we can either:
      -- A). remove the fields FUNCTION via setting to nil
      -- B). SET the __fields attr in the metatabel TO the fields itself ( ie: T.__fields = fields instead of T.__fields = funciton( .... ) ... end )
      -- C). leave it as is, and just call the function each time we want to access the fields - which is what we do for now, since it allows us to avoid potential issues with stale data if the table is modified after the initial reflection.
      -- Q: Do we ever encounter problems or potential collisions with reflection when doing this though?
      --
      -- Currently we assemble a sep. table...
      local fields = {}
      for k, v in pairs(mut_tbl) do
        fields[k] = v
      end
      return fields

      -- If we wanted to set the __fields attr to the fields itself, we could do something like this:
      -- This would, however, make call ordering important - since we'd go fun() -> table
      -- Which becomes messy af later to trace bugs and whatnot.
      -- (Though... The type tells us if it's been set up yet or not?)
      --
      -- tbl.__fields = {}
      -- for k, v in pairs(tbl) do
      --   tbl.__fields[k] = v
      -- end
      -- return tbl.__fields
    end,
  })
  return mut_tbl
end

--- Modifies the provided table (or module/class) by
--- setting up the .__fields attr/func and
--- then calling it for each field that has a .setup function
---@param mut_tbl table The table to set up with reflection and call setup on its fields.
Utils.reflection_setup = function(mut_tbl)
  -- Handle the case where there's no T.__fields attr - by calling the reflection function to build it.
  if getmetatable(mut_tbl) == nil or getmetatable(mut_tbl).__fields == nil then
    mut_tbl = Utils.reflection(mut_tbl)
  end

  local fields = getmetatable(mut_tbl).__fields()
  if not fields or type(fields) ~= "table" then
    print("Error: __fields is not a table for the given input.")
    return
  end

  for name, module in pairs(fields) do
    if type(module) == "table" and type(module.setup) == "function" then
      local ok, err = pcall(module.setup)
      if not ok then
        print("Error setting up module '" .. name .. "':", err)
      end
    end
  end
end

Utils.as_required = function(base, from, module)
  local pre = base .. "." .. from .. "." .. module
  local ok, res = pcall(require, pre)
  if not ok then
    print("Error loading module: " .. pre .. "\n" .. res)
  end
  return res
end

--- Launches a program via uwsm with optional service targeting.
---@param program string The program command to launch.
---@param as_service? boolean If true, wraps in `uwsm app -t service -- <program>`.
Utils.uwsm_launcher = function(program, as_service)
  -- TODO: We will; at some stage, need to gate this fn call behind a check for the
  -- cases where we decide to move away from `uwsm` as a tool.

  local base_cmd = "uwsm app"
  as_service = as_service or false
  if as_service then
    base_cmd = base_cmd .. " -t service"
  end
  base_cmd = base_cmd .. " -- " .. program
  hl.exec_cmd(base_cmd)
end

-- --- Removed / manually deleted and garbage collected tables
-- --- will still be present in the __fields table of the parent module/class,
-- --- which can lead to stale references and potential memory leaks if not handled properly.
-- ---@param ... table The tables to remove from the __fields of their parent modules/classes.
-- Utils.remove = function(...)
--   local tables_to_remove = { ... }
-- end

return Utils
