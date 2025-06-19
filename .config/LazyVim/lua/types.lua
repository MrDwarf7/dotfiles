
--- A generic type for a table that can be used directly, or called to produce a new table.
--- `any` here is the stand-in for T: table (Thank-you LuaLS)
---@generic T: table
---@class PartiallyApplied<T> : any
---@field __call fun(self: any, desc: string|nil): any

--- Used for the 'mod' function call
--- that creates a partially applied fun()
--- allowing for
--- -@field noremap = true
--- -@field silent = true
--- -@field desc = ?
---
--- With a metatable that can be treated as a table, or a functio
--- to apply the missing desc at a later stage.
---
---@class SilentOpts.Table
---@field noremap boolean
---@field silent boolean
---@field desc? string

---@class SilentOpts
---@field silent_opts SilentOpts.Table
