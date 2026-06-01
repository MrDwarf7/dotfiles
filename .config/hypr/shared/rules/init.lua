--- Window rules loader — self-contained.
--- Loads all rule files from shared/rules/.
--- Each rule file returns a table of rule tables.

--- Some notes on the window_rule.move and window_rule.size params:
---
--- monitor_w and monitor_h for monitor size
--- window_x and window_y for window position
--- window_w and window_h for window size
--- cursor_x and cursor_y for cursor position

---@class HyprConfig.Rules
local setup = function()
  -- Global floating window rule
  hl.window_rule({
    name = "no-floating-border",
    match = {
      float = true,
    },
    border_size = 0,
  })

  -- Rule modules to load, grouped by concern:
  --   ag_float       — float + size/pin rules (no tags, no workspace)
  --   ag_tag         — tag assignments + tag effects (incl. tag-based workspaces)
  --   ag_workspace   — direct workspace assignments (no tags)
  --   a_generic      — global rules (suppress_event, etc.)
  --   ag_pip         — Picture-in-Picture
  --   ag_popups      — file dialogs, portals, polkit/pinentry focus
  --   code           — VS Code opacity
  --   alecaframe     — Overwolf/Aleaframe (multi-tag)
  --   steam          — Steam multi-window (complex)
  --   vivaldi        — Vivaldi browser (complex)
  --
  -- Not loaded (prepped, pending review):
  --   ag_yoinked_prep — generic floats, PiP, screen share, tearing, launchers

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

---@return HyprConfig.Rules
return setup()
