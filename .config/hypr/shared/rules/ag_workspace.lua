-- stylua: ignore start
--- Workspace rule generator.
--- Reads _registry.lua and produces workspace assignment rules.

local reg = require("shared.rules.registry")

local expand_attrs = function(attrs)
  if not attrs then return {} end
  local t = {}
  if attrs.no_initial_focus then t.no_initial_focus = true end
  if attrs.maximize then t.maximize = true end
  if attrs.float then t.float = true end
  if attrs.center then t.center = true end
  if attrs.opacity == true then t.opacity = "1.0 override 1.0 override"
  elseif type(attrs.opacity) == "string" then t.opacity = attrs.opacity end
  if attrs.persist then t.persistent_size = true end
  return t
end

local rules = {}

for _, entry in ipairs(reg.workspace) do
  local rule = expand_attrs(entry.attrs)
  rule.name = "workspace-" .. entry.class:gsub("[^%w]+", "-"):gsub("^-", ""):gsub("-$", "")
  rule.match = { class = "^(" .. entry.class .. ")$" }
  rule.workspace = entry.workspace
  if entry.size then rule.size = entry.size end
  rules[#rules + 1] = rule
end

return rules
-- stylua: ignore end
