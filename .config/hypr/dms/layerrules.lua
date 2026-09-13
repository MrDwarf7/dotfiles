---@type HL.LayerRuleSpec[]
local rules = {
  {
    name = "dms-no-anim",
    match = {
      namespace = "dms",
    },
    no_anim = true,
    above_lock = false,
  },
  -- Left

  -------------------------
  {
    name = "dms-blur-for-popouts-and-misc",
    match = {
      namespace = "dms:(bar|tooltip|toast|dock-context-menu|control-center|notification-center-popout|dash|dash:background|battery|popout|app-launcher|launcher-context-menu)",
    },
    blur = true,
    ignore_alpha = 0.0,
    xray = true,
  },

  {
    name = "dms-blur-for-modals-and-misc",
    match = {
      namespace = "dms:(polkit|notification-center-modal|notification-popup|color-picker|clipboard|clipboard-popout|spotlight|settings|tray-menu-window|tray-overflow-menu|slideout|system-update|system-update:background|filebrowser|osd)",
    },
    blur = true,
    ignore_alpha = 0,
  },

  {
    name = "dms-blur-for-process-list",
    match = {
      namespace = "dms:(process-list-modal|process-list-popout)",
    },
    blur = true,
    ignore_alpha = 0,
  },

  {
    name = "dms-no-blur",
    match = {
      namespace = "dms:(frame-exclusion|frame|dankisland)",
      -- namespace = "dms:(frame-exclusion|frame|power-menu)",
      -- namespace = "dms:(frame.*)",
    },
    blur = false,
    ignore_alpha = 0,
  },

  ---------------------------------
  {
    name = "dms-blur-test",
    match = {
      namespace = "dms:settings",
    },
    -- ignore_alpha = 0,
  },
  ---------------------------------

  -- default generated opts
  -- { -- Compositor -> Layout -> Xray Blur toggle
  --   match = { namespace = "^dms:.*$" },
  --   xray = true,
  -- },
  -- { -- Compositor -> Layout -> Bar Xray Blur toggle
  --   match = { namespace = "^dms:bar$" },
  --   xray = true,
  -- },
}

require("utils.lst").map(rules, hl.layer_rule)
