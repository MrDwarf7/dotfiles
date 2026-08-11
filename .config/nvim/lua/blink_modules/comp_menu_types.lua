require("plugins.colorful-menu")

---@private
---@return blink.cmp.Draw
local function minimal()
  return {
    gap = 1,
    padding = { 0, 1 },
    columns = {
      { "kind_icon", gap = 1 },
      { "label", "label_description", gap = 1 },
    },
  }
end

---@private
---@return blink.cmp.Draw
local function basic()
  return {
    gap = 1,
    padding = { 0, 1 },
    columns = {
      { "kind_icon", gap = 1 },
      { "label", "label_description", gap = 1 },
      { "kind" },
      { "source_name", gap = 1 },
    },
  }
end

---@private
---@return blink.cmp.Draw
local function clean()
  return {
    gap = 1,
    padding = { 0, 1 },
    columns = {
      { "kind_icon", gap = 1 },
      { "label", "label_description", gap = 1 },
      { "kind" },
    },
  }
end

---@private
---@return blink.cmp.Draw
local function colorful()
  return {
    -- We don't need label_description now because label and label_description are already
    -- combined together in label by colorful-menu.nvim.
    columns = {
      { "kind_icon" },
      { "label", "source_name", gap = 1 },
    },
    components = {
      label = {
        text = function(ctx)
          return require("colorful-menu").blink_components_text(ctx)
        end,
        highlight = function(ctx)
          return require("colorful-menu").blink_components_highlight(ctx)
        end,
      },
    },
  }
end

---@alias MenuTypesE "minimal" | "basic" | "clean" | "colorful"

-- ---@generic FTable:MenuTypes
---@type table<MenuTypes|MenuTypesE, fun(): blink.cmp.Draw>
---@enum MenuTypes
local fn_names = {
  ---@type fun(): blink.cmp.Draw
  basic = basic,
  ---@type fun(): blink.cmp.Draw
  clean = clean,
  ---@type fun(): blink.cmp.Draw
  colorful = colorful,
  ---@type fun(): blink.cmp.Draw
  minimal = minimal,
}
setmetatable(fn_names, {
  __tostring = function()
    return "MenuTypes: " .. table.concat(vim.tbl_keys(fn_names), ", ")
  end,
  __iter = function(t)
    local keys = vim.tbl_keys(t)
    local i = 0
    return function()
      i = i + 1
      if i > #keys then
        return nil
      end
      return keys[i], t[keys[i]]
    end
  end,
})

-- --- Returns from the 'draw' table and deeper
-- ---@param fn_name MenuTypes|string
-- local function get_menu(fn_name)
--   if not fn_name then
--     fn_name = tostring(fn_names) -- This will call the __tostring metamethod, which returns a string of the format "MenuTypes: minimal, basic, clean, colorful"
--     -- fn_name = fn_names.basic or "basic"
--     -- fn_name = "basic" or fn_names.basic
--   end
--   return fn_names[fn_name]()
-- end

--- Allows calling either
--- <module>("<mod_type">)
--- or:
--- <module>[<mod_type>]
--- or:
--- require("<module>").<mod_type>
---@return table<string, fun(): blink.cmp.Draw> | fun(fn_name: MenuTypes): blink.cmp.Draw
return setmetatable(fn_names, {
  __index = function(_, key)
    if fn_names[key] then
      -- return get_menu(key)
      fn_names[key]()
    else
      error("Invalid menu type: " .. tostring(key))
    end
  end,
  -- __newindex = function(table, key, value)
  -- end,
  __call = function(_, key)
    if fn_names[key] then
      return fn_names[key]()
    else
      return rawget(fn_names, key)()
    end
    -- return get_menu(fn_name)
  end,
})
