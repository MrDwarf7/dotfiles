--###########
--## MISC ###
--###########

-- https://wiki.hyprland.org/Configuring/Variables/#misc

hl.config({
  ---@type HL.ConfigOpt.Misc
  misc = {
    -- If true disables the random hyprland logo / anime girl background. :(
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    col = {
      splash = "rgba(ffffffff)",
    },
    font_family = '"Sans"',
    splash_font_family = "",
    force_default_wallpaper = 1, -- Set to 0 or 1 to disable the anime mascot wallpapers
    -- vrr = 3                                                # 0 - off, 1 - on, 2 - fullscreen only, 3 - fullscreen with video or game content type [0/1/2/3]
    mouse_move_enables_dpms = true, -- wake on mouse move
    key_press_enables_dpms = false,
    always_follow_on_dnd = true,
    layers_hog_keyboard_focus = true,
    animate_manual_resizes = false,
    animate_mouse_windowdragging = false,
    disable_autoreload = false,
    enable_swallow = true,
    -- swallow_regex = ^(kitty|org.wezfurlong.wezterm|org.mitchellh.ghostty)$
    swallow_regex = "^(kitty)$",
    swallow_exception_regex = "",
    focus_on_activate = false,
    mouse_move_focuses_monitor = true,
    -- render_ahead_of_time = true                           #apparently quite buggy
    -- render_ahead_safezone = 1
    allow_session_lock_restore = true,
    session_lock_blur = false,
    session_lock_xray = false,
    background_color = "rgba(00000000)",
    close_special_on_empty = true,
    -- new_window_takes_over_fullscreen = 2                   # 0 - behind, 1 - takes over, 2 - unfullscreen/unmaxize [0/1/2]
    --## Misc: new_window_takes_over_fullscreen (int)
    -- if there is a fullscreen or maximized window,
    -- decide whether a new tiled window opened should replace it,
    -- stay behind or disable the fullscreen/maximized state.
    -- 0 - behind, 1 - takes over, 2 - unfullscreen/unmaxize [0/1/2] - Defaults to: 0
    -- new_window_takes_over_fs = 2
    exit_window_retains_fullscreen = false,
    initial_workspace_tracking = 1, -- 0 - disabled, 1 - single-shot, 2 - persistent (all children too)
    middle_click_paste = false,
    render_unfocused_fps = 60,
    disable_xdg_env_checks = false,
    -- disable_hyprland_qtutils_check = false ## deprecated
    lockdead_screen_delay = 1000,
    enable_anr_dialog = true,
    anr_missed_pings = 5,
    -- 0 - ignore focus request (keep focus on fullscreen window), 1 - takes over, 2 - unfullscreen/unmaximize [0/1/2]
    -- Default is 2
    on_focus_under_fullscreen = 1,
    disable_watchdog_warning = true,
  },
})
