--- Vivaldi browser window rules.
--- Tag chain: initial class/title -> workspace + opacity -> settings float -> webapp float.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  -- TODO: [tags] : browsers

  --- Tag by initial class.
  {
    name = "tag-vivaldi-init-class",
    match = { initial_class = "^([vV]ivaldi)(-+)(stable?)$" },
    tag = "+vbrowserInitClass",
  },

  --- Tag by initial title.
  {
    name = "tag-vivaldi-init-title",
    match = { initial_title = "^([vV]ivaldi(\\\\s+)(-)(\\\\s+)[vV]ivaldi)$" },
    tag = "+vbrowserInitTitle",
  },

  --- Workspace for both tags.
  {
    name = "effect-vivaldi-init-title",
    match = { tag = "vbrowserInitTitle" },
    workspace = "1 silent",
  },

  {
    name = "effect-vivaldi-init-class",
    match = { tag = "vbrowserInitClass" },
    workspace = "1 silent",
  },

  --- Opacity for both tags.
  {
    name = "effect-vivaldi-init-class-opacity",
    match = { tag = "vbrowserInitClass" },
    opacity = "1.0 override 1.0 override",
    opaque = true,
  },

  {
    name = "effect-vivaldi-init-title-opacity",
    match = { tag = "vbrowserInitTitle" },
    opacity = "1.0 override 1.0 override",
    opaque = true,
  },

  --- Settings window.
  {
    name = "tag-vivaldi-settings",
    match = { title = "^([vV]ivaldi)(\\\\s)(Settings\\\\:)(.*)(-\\\\s)?([vV]ivaldi)?$" },
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
    float = true,
    center = true,
    size = "1200 1100",
    persistent_size = true,
  },

  --- Webapp windows (default profile).
  {
    name = "tag-vivaldi-webapp",
    match = {
      class = "^([vV]ivaldi)(-?)+(.*)(-?)+([dD]efault)$",
      tag = "vbrowserInitTitle",
    },
    tag = "+vwebapp-general",
  },

  {
    name = "effect-vivaldi-webapp-float",
    match = { tag = "vwebapp-general" },
    float = true,
    persistent_size = true,
    opaque = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
