--- Shared Hyprland configuration — shell-agnostic modules.
--- Loaded before shell-specific config.
---
--- Convention:
---   - Each module returns a table {section_key = { ... }} → merged into hl.config()
---   - Modules that are purely side effects (hl.bind, hl.layer_rule, hl.monitor, etc.)
---     return nothing (or {})
---   - Sub-directories (keymaps/, rules/) are self-contained: they pull in their
---     own dependencies internally.
---
--- Load order:
---   1. env (hl.env calls — must be first)
---
---

--- TODO: need to review/fix some stuff here
-- ---   2. programs (hl.env + table of program names)
-- ---   3. visualfeel (hl.animation/hl.curve + table)
-- ---   4. All table-returning config modules → merged into config table
-- ---   5. monitor setup (hl.monitor / hl.workspace_rule)
-- ---   6. execs (hl.on / hl.exec_cmd for autostart)
-- ---   7. window rules (self-contained in rules/)
-- ---   8. keymaps (self-contained in keymaps/)

-- ---@class HyprConfig.Shared
local Shared = {}

---@class HyprConfig.Shared
local setup = function()
  -----------------------------------------------------------
  -- 1. Environment variables (must be first)
  -----------------------------------------------------------
  require("shared.env")

  -----------------------------------------------------------
  -- 4. Monitor setup (hl.monitor / hl.workspace_rule)
  --    Side-effect only, self-contained
  -----------------------------------------------------------
  require("shared.monitor")

  -----------------------------------------------------------
  -- 2. Programs (hl.env + returns table for $var resolution)
  --    Self-contained: keymaps/ pulls this in when needed
  -----------------------------------------------------------
  require("shared.programs")

  -----------------------------------------------------------
  -- 7. Keymaps (self-contained: loads mods internally)
  -----------------------------------------------------------
  require("shared.keymaps.init")

  -----------------------------------------------------------
  -- 8. Standard hl.config sections — each returns a table
  -----------------------------------------------------------
  -- local config = {}

  require("shared.animation")
  require("shared.binds")
  require("shared.cursor")
  require("shared.debug")
  require("shared.ecosystem")
  require("shared.group")
  require("shared.input")
  require("shared.layouts")
  require("shared.misc")
  require("shared.opengl")
  require("shared.quirks")
  require("shared.render")
  require("shared.visualfeel")
  require("shared.xwayland")

  -- local modules = {
  --   "animation",
  --   "binds",
  --   "cursor",
  --   "debug",
  --   "ecosystem",
  --   "group",
  --   "input",
  --   "layouts",
  --   "misc",
  --   "opengl",
  --   "quirks",
  --   "render",
  --   "visualfeel",
  --   "xwayland",
  -- }
  -- for _, modpath in ipairs(modules) do
  --   require("shared." .. modpath)
  -- end

  -----------------------------------------------------------
  -- 6. Window rules (self-contained loader)
  -----------------------------------------------------------
  require("shared.rules.init")

  -----------------------------------------------------------
  -- Execs (hl.on / hl.exec_cmd for autostart)
  --    Side-effect only, self-contained
  -----------------------------------------------------------
  require("shared.execs")
end

Shared.setup = setup

---@return HyprConfig.Shared
return Shared
-- setup()
