--- Picture-in-Picture rules.
--- These have NEVER worked in the old system due to broken syntax.
--- Fixed version from a_yoinked.lua.

---@type HyprConfig.HL.WindowMatch
local pip_match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  {
    name = "float-pip",
    match = pip_match,
    float = true,
  },

  {
    name = "pip-aspect-ratio",
    match = pip_match,
    keep_aspect_ratio = true,
  },

  {
    name = "pip-position",
    match = pip_match,
    move = { "(monitor_w*0.73)", "(monitor_h*0.72)" },
  },

  {
    name = "pip-size",
    match = pip_match,
    size = { "(monitor_w*0.25)", "(monitor_h*0.25)" },
  },

  {
    name = "pip-pin",
    match = pip_match,
    pin = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
