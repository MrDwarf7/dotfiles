local base = {
  main_mod = "SUPER",
  shift = "SHIFT",
  ctrl = "CTRL",
  alt = "ALT",
  tab = "Tab",
}

local combine = function(...)
  return table.concat({ ... }, " + ")
end

local mod_combos = {
  main_mod_shift = combine(base.main_mod, base.shift),
  main_mod_ctrl = combine(base.main_mod, base.ctrl),
  main_mod_alt = combine(base.main_mod, base.alt),
  main_mod_shift_ctrl = combine(base.main_mod, base.shift, base.ctrl),
  alt_tab = combine(base.alt, base.tab),
}

local ret = {
  base = base,
  -- main_mod = base.main_mod,
  combine = combine,
  mod_combos = mod_combos,
}

setmetatable(ret, {
  ---@diagnostic disable-next-line: unused-local
  __index = function(table, key)
    if key == "main_mod" then -- handling the explicit case because, well... It's most of them lol
      return base.main_mod
    elseif base[key] then
      return base[key]
    elseif mod_combos[key] then
      return mod_combos[key]
    -- elseif combine(key) then
    --   return combine(key)
    else
      error("Key '" .. key .. "' not found in mods")
    end
  end,
})

return ret

-- return {
--   base = base,
--   main_mod = base.main_mod,
--   combine = combine,
--   mod_combos = mod_combos,
-- }
