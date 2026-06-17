-- See https://wiki.hyprland.org/Configuring/Monitors/
-- monitor = desc:Samsung Electric Company LS49AG95 HNTTB00033 (DP-1), 5120x1440@239.76, 0x0, 1,bitdepth,10,cm,hdr,sdrbrightness,1.45,sdrsaturation,0.98,

local machines = require("utils.machines")

for _, m in ipairs(machines.monitors()) do
  hl.monitor(m)
end
for _, r in ipairs(machines.workspace_rules()) do
  hl.workspace_rule(r)
end
