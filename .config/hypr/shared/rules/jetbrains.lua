--- JetBrains IDE window rules (IntelliJ, PyCharm, WebStorm, GoLand, etc).
--- Includes workaround rules for toolbox menus and tab dragging.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  -- TODO: [tags] : gui_editors

  --- Tag all JetBrains windows.
  {
    name = "tag-jb",
    match = { class = "^(jetbrains-.+)$" },
    tag = "+jb",
  },

  --- Workspace for tagged windows.
  {
    name = "effect-jb-workspace",
    match = { tag = "jb" },
    workspace = "3 silent",
  },

  --- Workaround: toolbox menus are unclickable without this.
  --- Matches windows with class containing "jetbrains" and title starting with "win".
  {
    name = "jb-toolbox-menus-fix",
    match = {
      class = "^(.*jetbrains.*)$",
      title = "^(win.*)$",
    },
    no_initial_focus = true,
    no_focus = true,
  },

  --- Workaround: tab dragging loses focus.
  --- Tab drag windows have a single space character as their title.
  {
    name = "jb-tab-dragging-fix",
    match = {
      class = "^(.*jetbrains.*)$",
      title = "^\\\\s$",
    },
    no_initial_focus = true,
    no_focus = true,
  },

  --- Workaround: floating JetBrains dialogs need stay_focused.
  {
    name = "jb-tab-dragging-fix-2",
    match = {
      class = "^(jetbrains-.+)$",
      tag = "jb",
      float = 1,
    },
    stay_focused = true,
    no_initial_focus = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
