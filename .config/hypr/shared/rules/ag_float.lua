-- stylua: ignore start
--- Float rule generator.
--- Reads _registry.lua and produces float + center rules.
--- All logic is contained in generate_rules(); no free-floating functions.

local reg = require("shared.rules._registry")

local generate_rules = function()
  local float_center_classes = {}
  local size_groups = {}
  local sub_rules = {}
  local float_center_tags = {}

  for _, app in ipairs(reg.float_center) do
    float_center_classes[#float_center_classes + 1] = app.class

    if app.size then
      size_groups[app.size] = size_groups[app.size] or {}
      size_groups[app.size][#size_groups[app.size] + 1] = app.class
    end

    if app.tag then
      float_center_tags[#float_center_tags + 1] = {
        class = app.class,
        tag = app.tag,
        attrs = app.attrs,
      }
    end

    if app.subs then
      for _, sub in ipairs(app.subs) do
        sub_rules[#sub_rules + 1] = {
          name = "sub-" .. app.class .. "-" .. sub.title,
          match = { class = "^(" .. app.class .. ")$", title = "^(" .. sub.title .. ")$" },
          size = sub.size,
        }
      end
    end
  end

  local rules = {}

  -- 1. Float+Center tag assignment (big pipe)
  rules[#rules + 1] = {
    name = "float-center-tag",
    match = { class = "^(" .. table.concat(float_center_classes, "|") .. ")$" },
    tag = "+floatCenter",
  }

  -- 2. Float+Center effect
  rules[#rules + 1] = {
    name = "float-center-effect",
    match = { tag = "floatCenter" },
    float = true,
    center = true,
  }

  -- 3. Additional tag assignments for float_center apps
  for _, entry in ipairs(float_center_tags) do
    local tag_rule = {
      name = "tag-" .. entry.tag,
      match = { class = "^(" .. entry.class .. ")$" },
      tag = "+" .. entry.tag,
    }
    -- If the app has attrs like opacity, apply them as a tag effect
    if entry.attrs then
      local effect = {}
      if entry.attrs.opacity == true then effect.opacity = "1.0 override 1.0 override" end
      if entry.attrs.persist then effect.persistent_size = true end
      rules[#rules + 1] = tag_rule
      effect.name = "effect-" .. entry.tag
      effect.match = { tag = entry.tag }
      rules[#rules + 1] = effect
    else
      rules[#rules + 1] = tag_rule
    end
  end

  -- 4. Size override groups
  for size, classes in pairs(size_groups) do
    rules[#rules + 1] = {
      name = "size-" .. size,
      match = { class = "^(" .. table.concat(classes, "|") .. ")$" },
      size = size,
    }
  end

  -- 5. Sub-rules
  for _, rule in ipairs(sub_rules) do
    rules[#rules + 1] = rule
  end

  -- 6. Special float rules (passthrough)
  for _, rule in ipairs(reg.special_float) do
    rules[#rules + 1] = rule
  end

  return rules
end

return generate_rules()
-- stylua: ignore end
