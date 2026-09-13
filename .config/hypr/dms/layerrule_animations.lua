---@type HL.LayerRuleSpec[]
local rules = {
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
}

require("utils.lst").map(rules, hl.layer_rule)
