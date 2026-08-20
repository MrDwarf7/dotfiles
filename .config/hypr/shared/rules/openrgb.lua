-- Window 55f1b55f96a0 -> OpenRGB:
-- 	class: org.openrgb.OpenRGB
-- 	title: OpenRGB
-- 	initialClass: org.openrgb.OpenRGB
-- 	initialTitle: OpenRGB

local rgx = "^(org.openrgb.*)$"

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  {
    name = "tag-openrgb",
    match = { class = rgx },
    -- title = "^(OpenRGB)$",
    tag = "+openrgb",
  },
  {
    name = "effect-openrgb",
    match = { tag = "openrgb" },
    float = true,
    no_blur = true,
    persistent_size = true,
  },
}

require("utils.lst").map(rules, hl.window_rule)
