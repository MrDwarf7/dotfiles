--- Popup and dialog float rules.
--- File dialogs, portal windows, polkit agents, and zenity all float.
--- Pinentry and polkit agents also get stay_focused to prevent focus stealing.

return {
  -- ════════════════════════════════════════════
  -- File dialogs (title-based, empty class)
  -- ════════════════════════════════════════════
  {
    name = "float-file-dialogs",
    match = { class = "^()$", title = "^(Save File|Open File)$" },
    float = true,
  },

  -- ════════════════════════════════════════════
  -- XDG desktop portals + polkit agents + zenity (piped)
  -- All get float=true.
  -- ════════════════════════════════════════════
  {
    name = "float-portals-polkit-zenity",
    match = {
      class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland|polkit-gnome-authentication-agent-1|hyprpolkitagent|org.org.kde.polkit-kde-authentication-agent-1|zenity)(.*)$",
    },
    float = true,
  },

  -- ════════════════════════════════════════════
  -- Pinentry + polkit: stay focused (prevent focus stealing)
  -- ════════════════════════════════════════════
  {
    name = "stayfocused-pinentry",
    match = { class = "^(pinentry-)(.*)$" },
    stay_focused = true,
  },
  {
    name = "stayfocused-polkit",
    match = { class = "^(hyprpolkit(agent)?)(.*)$" },
    stay_focused = true,
  },
}
