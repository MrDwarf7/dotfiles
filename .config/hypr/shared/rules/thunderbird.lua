--   {
--     name = "tag-thunderbird-write",
--     match = {
--       class = "^(org.mozilla.Thunderbird)$",
--       title = "^(Write:\\s.*)$",
--     },
--     -- match:initial_class = ^(STUFF)$
--     -- match:initial_title = ^(MORE_STUFF)$
--     tag = "+thunderbird-write",
--   },
--
--   -- Tagging - Client windows
--   {
--     name = "tag-workspace-thunderbird",
--     match = {
--       class = "^(org.mozilla.Thunderbird)$",
--       initial_title = "^(Mozilla\\sThunderbird)$",
--     },
--     -- match:initial_class = ^(STUFF)$
--     -- match:initial_title = ^(MORE_STUFF)$
--     tag = "+thunderbird-workspace",
--   },
--
--   -- Effects
--
--   --# Generic opacity for tagged things
--   {
--     name = "tagged-thunderbird-write",
--     match = {
--       tag = "thunderbird-write",
--     },
--     opacity = "1.0 override 1.0 override",
--     persistent_size = true,
--   },
--
--   {
--     name = "workspace-thunderbird",
--     match = {
--       tag = "thunderbird-workspace",
--     },
--     workspace = "3 silent",
--   },
--
--   --# Float things
--   {
--     name = "float-tagged-thunderbird-write",
--     match = {
--       tag = "thunderbird-write",
--     },
--     -- workspace = N silent
--     float = true,
--     center = true,
--     size = "1600 900",
--   },
-- }
--

-- TODO: [tags] : private_comms | email

-- TODO: [add] : set these + add to init

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
