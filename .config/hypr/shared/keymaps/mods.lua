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

-- Exmaple: We have stuff  like this:
-- hl.bind(mods.main_mod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }), { repeating = true })
-- hl.bind(mods.mod_combos.main_mod_shift .. " + Tab", hl.dsp.focus({ workspace = "e-1" }), { repeating = true })

-- We want to be able to clean this up so it's easier to find bindings and such. Eg:
-- hl.bind(mods.with("super", "Tab"), ... rest of stuff here ),
-- or
-- hl.bind(mods.with(main_mod, "Tab"), , ... rest of stuff here )
-- or
-- hl.bind(mods.with(mods.main_mod, "Tab"), ... rest of stuff here )
-- or
-- the above's but via mods:with(........, .....) etc. so we use the attached combine fn
--
-- So maybe we just have a lookup table or something, and use teh underlying combine fn call

--- Combines multiple modifier keys and a key into a single string suitable for binding.
--- @param ... unknown
--- @return string
local with = function(...)
  -- gives an error via invalid value (table) at index 1 in table for concat
  return combine(table.unpack({ ... }))
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
    end
    if base[key] then
      return base[key]
    end
    if mod_combos[key] then
      return mod_combos[key]
    -- elseif combine(key) then
    --   return combine(key)
    else
      error("Key '" .. key .. "' not found in mods")
    end
  end,
})

ret.with = with

return ret
