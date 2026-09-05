---@type HL.LayerRuleSpec[]
local rules = {
  {
    name = "dms-no-anim",
    match = {
      namespace = "dms",
    },
    no_anim = true,
  },
  -- Left
  {
    name = "dms-app-launcher-animation",
    match = {
      namespace = "dms:(app-launcher)",
    },
    animation = "slide left",
  },

  {
    name = "dms-dash-animation",
    match = {
      namespace = "dms:dash",
    },
    animation = "slide left",
  },

  -- Center
  {
    name = "dms-workspace-overview-animation",
    match = {
      namespace = "dms:workspace-overview",
    },
    animation = "slide top",
  },

  {
    name = "dms-spotlight-animation",
    match = {
      namespace = "dms:(spotlight)",
    },
    animation = "slide bottom",
  },

  -- Right
  {
    name = "dms-process-list-animation",
    match = {
      namespace = "dms:(process-list-popout)",
    },
    animation = "slide top",
  },

  {
    name = "dms-control-center-animation",
    match = {
      namespace = "dms:control-center",
    },
    animation = "slide right",
  },

  {
    name = "dms-clipboard-popout-animation",
    match = {
      namespace = "dms:(clipboard-popout)",
    },
    animation = "slide right",
  },

  -- {
  --   name = "dms-notepad-popout-animation",
  --   match = {
  --     namespace = "dms:(slideout)",
  --   },
  --   -- animation = "slide right 1 0.2",
  --   animation = "snappy",
  -- },

  {
    name = "dms-power-menu-animation",
    match = {
      namespace = "dms:(power-menu)",
    },
    animation = "slide bottom",
  },

  -------------------------
  {
    name = "dms-blur-for-popouts-and-misc",
    match = {
      namespace = "dms:(bar|tooltip|toast|dock-context-menu|control-center|notification-center-popout|dash|dash:background|battery|popout|app-launcher|launcher-context-menu)",
    },
    blur = true,
    ignore_alpha = 0,
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

  -- {
  --   name = "dms-fix-blur-artifacts",
  --   match = {
  --     namespace = "dms:bar",
  --   },
  --   blur = false,
  --   ignore_alpha = 0,
  --   xray = true,
  -- },

  -- {
  --     name = "quickshell-bg"
  --     match:namespace = quickshell
  --     blur = on
  --     blur_popups = true
  --     ignore_alpha = 0
  -- },
  -- {
  --     name = "dms-all-blur-alpha-handling"
  --     blur = on
  --     ignore_alpha = 0
  --     blur_popups = true
  --     # ignore_alpha = 0.2
  --     # ignore_alpha = 0.275 ## <- threshold (rounds up to 2 dec. places from what I can tell)
  --     xray = true
  --     # match:namespace = dms:(bar|tooltip|toast|dock-context-menu|control-center|notification-center-popout|dash|battery|popout|app-launcher|polkit|notification-center-modal|notification-popup|color-picker|clipboard|clipboard-popout|spotlight|settings|tray-menu-window|slideout|system-update|system-update:background|filebrowser|osd|process-list-modal|process-list-popout)
  --     match:namespace = dms
  -- },
}

require("utils.lst").map(rules, hl.layer_rule)
