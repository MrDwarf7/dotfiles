
-- TODO: check syntax lol
--
-- layerrule = noanim ^(dms)$

-- ## Blur Tips
-- -- For whatever reason.... this is in the Useful Utilities :: Status Bars
-- part of the wiki.... God knows why
--
-- Use the blur and ignore_alpha layer rules.
-- The former enables blur, and the latter makes it ignore insufficiently opaque regions.
-- Ideally, the value used with ignore_alpha is higher than the shadow opacity and lower than the bar/menu content’s opacity.
-- Additionally, if it has transparent popups, you can use the blur_popups rule.

-- hl.layer_rule({
--   name = '"dms-no-anim"',
--   match = {
--     namespace = "dms",
--   },
--   no_anim = true,
-- })

-- Left

-- hl.layer_rule({
--   name = '"dms-app-launcher-animation"',
--   match = {
--     namespace = "dms:(app-launcher)",
--   },
--   animation = "slide left",
-- })

-- hl.layer_rule({
--   name = '"dms-dash-animation"',
--   match = {
--     namespace = "dms:dash",
--   },
--   animation = "slide left",
-- })

-- Center

-- hl.layer_rule({
--   name = '"dms-workspace-overview-animation"',
--   match = {
--     namespace = "dms:workspace-overview",
--   },
--   animation = "slide top",
-- })

-- hl.layer_rule({
--   name = '"dms-spotlight-animation"',
--   match = {
--     namespace = "dms:(spotlight)",
--   },
--   animation = "slide bottom",
-- })

-- Right

-- hl.layer_rule({
--   name = '"dms-process-list-animation"',
--   match = {
--     namespace = "dms:(process-list-popout)",
--   },
--   animation = "slide top",
-- })

-- hl.layer_rule({
--   name = '"dms-control-center-animation"',
--   match = {
--     namespace = "dms:control-center",
--   },
--   animation = "slide right",
-- })

-- hl.layer_rule({
--   name = '"dms-clipboard-popout-animation"',
--   match = {
--     namespace = "dms:(clipboard-popout)",
--   },
--   animation = "slide right",
-- })

-- hl.layer_rule({
--   name = '"dms-notepad-popout-animation"',
--   match = {
--     namespace = "dms:(slideout)",
--   },
--   animation = "slide right 1 0.2",
-- })

-- O => modal
-- m => misc
-- p => popout

-- ### Modals = o
-- Clipboard history           |     dms:clipboard
-- File browser                |     dms:file-browser
-- Settings                    |     dms:settings
-- Launcher                    |     dms:spotlight
-- Bluetooth pairing           |     dms:bluetooth-pairing
-- Color picker                |     dms:color-picker
-- Hyprkeybinds                |     dms:hyprkeybinds
-- Network info                |     dms:network-info
-- Network info (wired)        |     dms:network-info-wired
-- Notification                |     dms:notification-center-modal
-- Polkit                      |     dms:polkit
-- Power menu                  |     dms:power-menu
-- Process list                |     dms:process-list-modal
-- Wifi password               |     dms:wifi-password
-- Confirm modal               |     dms:confirm-modal
-- Fallback namespace          |     dms:modal

-- ### Popouts = p
-- App drawer                  |     dms:app-launcher
-- Control center              |     dms:control-center
-- Battery                     |     dms:battery
-- Vpn                         |     dms:vpn
-- DankDash                    |     dms:dash
-- Notification center         |     dms:notification-center-popout
-- Process list                |     dms:process-list-popout
-- Fallback namespace          |     dms:popout
-- Plugin                      |     dms:plugins:<namespace>
-- Fallback plugin namespace   |     dms:plugins:plugin

-- ### Misc components = m
-- DankBar                     |     dms:bar
-- Dock                        |     dms:dock
-- Workspace Overview          |     dms:workspace-overview
-- Notification Popup          |     dms:notification-popout
-- OSD                         |     dms:osd
-- Slideout                    |     dms:slideout
-- Tooltip                     |     dms:tooltip
-- Dock context menu           |     dock-context-menu # ####### NOTE!!!!!!!! Not a typo !!!!!!!!! not in the `dms:` namepsace!
-- Toast                       |     dms:toast
-- Tray menu window            |     dms:tray-menu-window

--Make transparent
-- hl.layer_rule({
--   name = '"dms-blur-for-popouts-and-misc"',
--   match = {
--     namespace = "dms:(bar|tooltip|toast|dock-context-menu|control-center|notification-center-popout|dash|battery|popout|app-launcher)",
--   },
--   blur = true,
--   -- TODO: manual review — disable "ignore_alpha" has no layer_rule directive analog
--   --                   #      m     m       m       m               p               p                        p     p        p        p
-- })

--Make solid -- "" blurred "" (not really), but let it be see-through
-- hl.layer_rule({
--   name = '"dms-blur-for-modals-and-misc"',
--   match = {
--     namespace = "dms:(polkit|notification-center-modal|notification-popup|color-picker|clipboard|clipboard-popout|spotlight|settings|tray-menu-window|slideout|system-update|system-update:background|filebrowser|osd)",
--   },
--   blur = true,
--   -- TODO: manual review — disable "ignore_alpha" has no layer_rule directive analog
--   --                   #        o       o                       ??                    o          o         o         o         m              m           ??             ??                   ??          m
-- })

-- hl.layer_rule({
--   name = '"dms-blur-for-process-list"',
--   match = {
--     namespace = "dms:(process-list-modal|process-list-popout)",
--   },
--   blur = true,
--   -- ignore_alpha = 0.275 ## <- threshold (rounds up to 2 dec. places from what I can tell)
--   -- TODO: manual review — disable "ignore_alpha" has no layer_rule directive analog
-- })
