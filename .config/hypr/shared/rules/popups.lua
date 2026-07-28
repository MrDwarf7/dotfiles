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

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
