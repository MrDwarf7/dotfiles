--- Chromium browser window rules.
--- Tag + subs pattern for devtools.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  -- TODO: [tags] : browsers

  {
    name = "tag-chromium",
    match = { class = "[cC]hromium" },
    tag = "+chromium",
  },

  {
    name = "effect-chromium",
    match = { tag = "chromium" },
    workspace = "1 silent",
    size = "2660 1300",
    persistent_size = true,
  },

  --- Devtools sub-window.
  {
    name = "tag-chromium-devtools",
    match = {
      class = "[cC]hromium",
      title = "Devtools",
    },
    tag = "+chromiumDevtools",
  },

  {
    name = "effect-chromium-devtools",
    match = { tag = "chromiumDevtools" },
    persistent_size = true,
    float = true,
    center = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
