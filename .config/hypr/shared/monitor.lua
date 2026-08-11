-- See https://wiki.hyprland.org/Configuring/Monitors/
-- monitor = desc:Samsung Electric Company LS49AG95 HNTTB00033 (DP-1), 5120x1440@239.76, 0x0, 1,bitdepth,10,cm,hdr,sdrbrightness,1.45,sdrsaturation,0.98,

local machine = require("utils.machine")
local lst = require("utils.lst")

lst.map(machine.monitors, hl.monitor)
lst.map(machine.workspace_rules, hl.workspace_rule)
