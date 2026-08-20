--- Zed editor window rules. gui_editors bucket + settings sub-window.

local bkt = require("shared.rules.buckets")
local v = bkt:get("gui_editors")

local rgx = "dev.[zZ]ed.?[zZ]ed"

bkt.assign_bucket({ class = rgx }, v.bucket)

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  --- Main window size (not covered by bucket).
  {
    name = "size-zed-main",
    match = { class = rgx },
    size = "2950 1350",
  },

  --- Settings sub-window.
  {
    name = "tag-zed-settings",
    match = { class = rgx, title = "Zed.*Settings" },
    tag = "+zedEditorSettings",
  },
  {
    name = "effect-zed-settings",
    match = { tag = "zedEditorSettings" },
    float = true,
    opacity = "1.00 override 1.00 override",
    persistent_size = true,
    size = "1050 1050",
  },
}

require("utils.lst").map(rules, hl.window_rule)
