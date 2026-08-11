--########################

local mods = require("shared.keymaps.mods")
local progs = require("shared.programs")
local machine = require("utils.machine")
local dms = require("dms")
local spec = machine.kind == "desktop" and machine.monitor("DP-1")
  or machine.kind == "laptop" and machine.monitor("eDP-1")
  or machine.monitor("HDMI-A-1")
local mon = spec and spec.output

-- === Application Launchers ===
-- Tofi is sooooo much faster
hl.bind(mods.with(mods.main_mod, "r"), hl.dsp.exec_cmd(progs.menu))

-- hl.bind(mods.with(mods.main_mod_ctrl, "r"), hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind(mods.with(mods.main_mod_ctrl, "r"), dms.invoke_ipc_call("spotlight toggle"))

hl.bind(mods.with(mods.main_mod_ctrl, "v"), dms.invoke_ipc_call("clipboard toggle"))
hl.bind(mods.with(mods.main_mod_ctrl, "m"), dms.invoke_ipc_call("settings focusOrToggle"))
hl.bind(mods.with(mods.main_mod_ctrl, "a"), dms.invoke_ipc_call("notifications toggle"))

hl.bind(mods.with(mods.main_mod_alt, "w"), dms.invoke_ipc_call("hypr toggleOverview"))
hl.bind(mods.with(mods.main_mod_alt, "d"), dms.invoke_ipc_call("night toggle"))

hl.bind(mods.with(mods.main_mod, "y"), dms.invoke_ipc_call("dankdash wallpaper"))
hl.bind(mods.with(mods.main_mod_shift, "y"), dms.invoke_ipc("wallpaperCarousel toggle"))
-- FEAT: check which monitor is actually selected (ie: cursor is over) and use that, with fallback as monitor etc.
hl.bind(mods.with(mods.main_mod_shift, "w"), dms.invoke_ipc_call("wallpaper nextFor " .. mon))
hl.bind(mods.with(mods.main_mod_ctrl, "w"), dms.invoke_ipc_call("wallpaper prevFor " .. mon))

hl.bind(mods.with(mods.main_mod_shift, "z"), dms.invoke_ipc_call("usbManager toggle"))

hl.bind(mods.with(mods.main_mod, "m"), dms.invoke_ipc_call("powermenu toggle"))
hl.bind(mods.with(mods.main_mod_ctrl, "n"), dms.invoke_ipc_call("notepad toggle"))

hl.bind(mods.with(mods.main_mod, "z"), dms.invoke_ipc_call("dash toggle overview"))
hl.bind(mods.with(mods.main_mod, "x"), dms.invoke_ipc_call("control-center toggle"))

hl.bind(mods.with(mods.main_mod_ctrl, "p"), dms.invoke_ipc_call("processlist focusOrToggle"))

-- === Security ===
hl.bind(mods.with(mods.main_mod_ctrl, "u"), dms.invoke_ipc_call("lock lock"))

-- === Screenshots ===
hl.bind(mods.with(mods.main_mod_ctrl, "s"), dms.invoke("screenshot"))

-- === System Controls ===
--# Toggles the display, basically a 'sleep' for all screens.
-- bind = $mainModShift, p, dpms, toggle

-- === Audio Controls SYSTEM (wpctl etc.) ===
hl.bind("XF86AudioRaiseVolume", dms.invoke_ipc_call("audio increment 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", dms.invoke_ipc_call("audio decrement 5"), { locked = true, repeating = true })

-- stylua: ignore start
-- === Audio Controls MEDIA (mpris) ===
hl.bind( "CTRL + XF86AudioRaiseVolume", dms.invoke_ipc_call("mpris increment 5"), { locked = true, repeating = true })
hl.bind( "CTRL + XF86AudioLowerVolume", dms.invoke_ipc_call("mpris decrement 5"), { locked = true, repeating = true })

hl.bind("XF86AudioMute", dms.invoke_ipc_call("audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", dms.invoke_ipc_call("audio micmute"), { locked = true })

hl.bind( "XF86MonBrightnessUp", dms.invoke_ipc_call('brightness increment 5 ""'), { locked = true, repeating = true })
hl.bind( "XF86MonBrightnessDown", dms.invoke_ipc_call('brightness decrement 5 ""'), { locked = true, repeating = true })
-- stylua: ignore end

hl.bind("XF86AudioNext", dms.invoke_ipc_call("mpris next"), { locked = true })
hl.bind("XF86AudioPrev", dms.invoke_ipc_call("mpris previous"), { locked = true })

hl.bind("XF86AudioPause", dms.invoke_ipc_call("mpris playPause"), { locked = true })
hl.bind("XF86AudioPlay", dms.invoke_ipc_call("mpris playPause"), { locked = true })

require("utils.root_shared").load_modules("shared.keymaps", {
  "map_general",
  "map_programs",
  "map_windows_workspaces",
  "map_misc",
})
