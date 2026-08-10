--- JetBrains IDE window rules (IntelliJ, PyCharm, WebStorm, GoLand, etc).
--- gui_editors bucket for the main window + workaround rules for child windows.

-- TODO: If I ever use jb stuff again - will have to double check these lol

local bkt = require("shared.rules.buckets")
local v = bkt:get("gui_editors")

bkt.assign_bucket({ class = "^(jetbrains-.+)$" }, v.bucket)

--- Workaround: toolbox menus are unclickable without this.
hl.window_rule({
  name = "jb-toolbox-menus-fix",
  match = { class = "^(.*jetbrains.*)$", title = "^(win.*)$" },
  no_focus = true,
  no_initial_focus = true,
})

--- Workaround: tab dragging loses focus.
hl.window_rule({
  name = "jb-tab-dragging-fix",
  match = { class = "^(.*jetbrains.*)$", title = "^s$" }, -- title = "^\\\\s$",
  no_focus = true,
  no_initial_focus = true,
})

--- Workaround: floating JetBrains dialogs need stay_focused.
hl.window_rule({
  name = "jb-floating-dialog-fix",
  match = { class = "^(jetbrains-.+)$", float = 1 },
  no_initial_focus = true,
  stay_focused = true,
})
