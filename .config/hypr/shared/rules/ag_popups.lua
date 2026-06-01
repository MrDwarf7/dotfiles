-- stylua: ignore start
--- Popup and dialog float rules.
--- Reads _registry.lua popups section and generates float + stay_focused rules.

local reg = require("shared.rules._registry")

local rules = {}

for i, entry in ipairs(reg.popups.float) do
  rules[#rules + 1] = {
    name = "float-popup-" .. i,
    match = entry,
    float = true,
  }
end

for i, entry in ipairs(reg.popups.stay_focused) do
  rules[#rules + 1] = {
    name = "stayfocused-popup-" .. i,
    match = entry,
    stay_focused = true,
  }
end

return rules
-- stylua: ignore end
