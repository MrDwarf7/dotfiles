-- stylua: ignore start
--- Window rules loader.
--- Loads rule generators from shared/rules/. Each generator reads
--- _registry.lua and returns a table of rule tables.

local setup = function()
  -- Global floating window rule
  hl.window_rule({
    name = "no-floating-border",
    match = { float = true },
    border_size = 0,
  })

  local modules = {
    "a_generic",
    "ag_float",
    "ag_tag",
    "ag_workspace",
    "ag_pip",
    "ag_popups",
    "code",
    "alecaframe",
    "steam",
    "vivaldi",
  }

  for _, mod in ipairs(modules) do
    local rules = require("shared.rules." .. mod)
    if type(rules) == "table" then
      for _, rule in ipairs(rules) do
        hl.window_rule(rule)
      end
    end
  end
end

return setup()
-- stylua: ignore end
