--- Vivaldi browser window rules.
--- Main window -> browsers bucket (WS1 + opacity + persistent size).
--- Settings + webapp sub-windows kept as child rules.

-- local bucket = require("shared.rules.buckets")

local bkt = require("shared.rules.buckets")
local v = bkt:get("browsers")

--- Main window via initial class/title (class changes after launch).
bkt.assign_bucket({ initial_class = "^([vV]ivaldi)(-+)(stable?)$" }, v.bucket)
bkt.assign_bucket({ initial_title = "^([vV]ivaldi(\\s+)(-)(\\s+)[vV]ivaldi)$" }, v.bucket)

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  --- Settings window.
  {
    name = "tag-vivaldi-settings",
    match = { title = "^([vV]ivaldi)(\\s)(Settings\\:)(.*)(-\\s)?([vV]ivaldi)?$" },
    tag = "+vSettingsInitTitle",
  },
  {
    name = "effect-vivaldi-settings-opacity",
    match = { tag = "vSettingsInitTitle" },
    opacity = "1.0 override 1.0 override",
    opaque = true,
  },
  {
    name = "effect-vivaldi-settings-float",
    match = { tag = "vSettingsInitTitle" },
    center = true,
    float = true,
    persistent_size = true,
    size = "1200 1100",
  },

  --- Webapp windows (default profile).
  {
    name = "tag-vivaldi-webapp",
    match = { class = "^([vV]ivaldi)(-?)+(.*)(-?)+([dD]efault)$" },
    tag = "+vwebapp-general",
  },
  {
    name = "effect-vivaldi-webapp-float",
    match = { tag = "vwebapp-general" },
    float = true,
    opaque = true,
    persistent_size = true,
  },
}

require("utils.lst").map(rules, hl.window_rule)
