--- Zed editor window rules. gui_editors bucket + settings sub-window.

local bkt = require("shared.rules.buckets")
local v = bkt:get("gui_editors")

local rgx = "dev.[zZ]ed.?[zZ]ed"

bkt.assign_bucket({ class = rgx }, v.bucket)

--- Main window size (not covered by bucket).
hl.window_rule({
  name = "size-zed-main",
  match = { class = rgx },
  size = "2950 1350",
})

--- Settings sub-window.
hl.window_rule({
  name = "tag-zed-settings",
  match = { class = rgx, title = "Zed.*Settings" },
  tag = "+zedEditorSettings",
})
hl.window_rule({
  name = "effect-zed-settings",
  match = { tag = "zedEditorSettings" },
  float = true,
  opacity = "1.00 override 1.00 override",
  persistent_size = true,
  size = "1050 1050",
})
