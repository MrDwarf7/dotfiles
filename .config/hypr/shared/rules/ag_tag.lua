-- stylua: ignore start
--- Tag rule generator.
--- Reads _registry.lua and produces tag assignment + effect rules.
--- All logic is contained in generate_rules(); no free-floating functions.

local reg = require("shared.rules.registry")

local generate_rules = function()
  local expand_attrs = function(attrs)
    if not attrs then return {} end
    local t = {}
    if attrs.opacity == true then t.opacity = "1.0 override 1.0 override"
    elseif type(attrs.opacity) == "string" then t.opacity = attrs.opacity end
    if attrs.persist then t.persistent_size = true end
    if attrs.no_float then t.float = false end
    if attrs.no_initial_focus then t.no_initial_focus = true end
    if attrs.border_n then t.border_size = attrs.border_n end
    if attrs.maximize then t.maximize = true end
    if attrs.fullscreen then t.fullscreen = true end
    if attrs.pin then t.pin = true end
    return t
  end

  local rules = {}

  for _, entry in ipairs(reg.tags) do
    -- 1. Tag assignment
    rules[#rules + 1] = {
      name = "tag-" .. entry.tag,
      match = { class = "^(" .. entry.class .. ")$" },
      tag = "+" .. entry.tag,
    }

    -- 2. Tag effect (attrs + workspace + size + center)
    local effect = expand_attrs(entry.attrs)
    if entry.workspace and entry.workspace ~= "nil" then effect.workspace = entry.workspace end
    if entry.size then effect.size = entry.size end
    if entry.center then effect.center = true end
    effect.name = "effect-" .. entry.tag
    effect.match = { tag = entry.tag }
    rules[#rules + 1] = effect

    -- 3. Sub-rules (title-based or conditional exceptions)
    if entry.subs then
      for _, sub in ipairs(entry.subs) do
        local sub_match = { class = "^(" .. entry.class .. ")$" }
        if sub.title then sub_match.title = "^(" .. sub.title .. ")" end
        if sub.float then sub_match.float = sub.float end

        rules[#rules + 1] = {
          name = "tag-" .. sub.tag,
          match = sub_match,
          tag = "+" .. sub.tag,
        }

        local sub_effect = expand_attrs(sub.attrs)
        if sub.workspace then sub_effect.workspace = sub.workspace end
        if sub.size then sub_effect.size = sub.size end
        sub_effect.name = "effect-" .. sub.tag
        sub_effect.match = { tag = sub.tag }
        rules[#rules + 1] = sub_effect
      end
    end
  end

  return rules
end

return generate_rules()
-- stylua: ignore end
