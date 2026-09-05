--- Portal, polkit, and dialog utility rules.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  --- Float all portal/dialog windows.
  {
    name = "float-portals",
    match = {
      class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland|zenity)$",
    },
    float = true,
  },

  --- xdph's Qt share picker. Vesktop is maximize on ws9; without this the
  --- picker tiles behind it and later clicks queue until a screenshot restacks.
  {
    name = "float-share-picker",
    match = { class = "^(hyprland-share-picker)$" },
    float = true,
    center = true,
    pin = true,
    stay_focused = true,
    focus_on_activate = true,
  },

  --- Float polkit agents.
  {
    name = "float-polkit",
    match = {
      class = "^(polkit-gnome-authentication-agent-1|hyprpolkitagent|org.org.kde.polkit-kde-authentication-agent-1)$",
    },
    float = true,
  },

  --- Stay focused for pinentry (password prompts).
  {
    name = "stayfocused-pinentry",
    match = { class = "^(pinentry-)(.*)$" },
    stay_focused = true,
  },

  --- Stay focused for polkit (prevents focus loss during auth).
  {
    name = "stayfocused-polkit",
    match = { class = "^(hyprpolkit(agent)?)(.*)$" },
    stay_focused = true,
  },
}

require("utils.lst").map(rules, hl.window_rule)
