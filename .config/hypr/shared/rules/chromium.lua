--- Chromium browser window rules. browsers bucket + devtools sub-window.

local bkt = require("shared.rules.buckets")
local v = bkt:get("browsers")

local rgx = "[cC]hromium"

bkt.assign_bucket({ class = rgx }, v.bucket)

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {

  --- Main window size (not covered by bucket).
  { name = "size-chromium-main", match = { class = rgx }, size = "2660 1300" },

  --- Devtools sub-window.
  {
    name = "tag-chromium-devtools",
    match = { class = rgx, title = "Devtools" },
    tag = "+chromiumDevtools",
  },
  {
    name = "effect-chromium-devtools",
    match = { tag = "chromiumDevtools" },
    center = true,
    float = true,
    persistent_size = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
