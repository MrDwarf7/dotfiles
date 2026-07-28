--- Zed editor window rules.
--- Tag + subs pattern for settings.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  -- TODO: [tags] : gui_editors

  {
    name = "tag-zed-editor",
    match = { class = "dev\\\\.[zZ]ed\\\\.?[zZ]ed" },
    tag = "+zedEditor",
  },

  {
    name = "effect-zed-editor",
    match = { tag = "zedEditor" },
    workspace = "3 silent",
    size = "2950 1350",
    persistent_size = true,
    opacity = "1.00 override 0.85 override",
    no_initial_focus = true,
  },

  --- Settings sub-window.
  {
    name = "tag-zed-editor-settings",
    match = {
      class = "dev\\\\.[zZ]ed\\\\.?[zZ]ed",
      title = "Zed.*Settings",
    },
    tag = "+zedEditorSettings",
  },

  {
    name = "effect-zed-editor-settings",
    match = { tag = "zedEditorSettings" },
    persistent_size = true,
    float = true,
    opacity = "1.00 override 1.00 override",
    size = " 1050 1050",
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
