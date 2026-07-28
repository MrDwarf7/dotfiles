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

---@alias Associated AssociatedFunction|AssociatedMethod

---@class HyprConfig.Shared
---@field setup Associated|bool|nil Returns true if setup completed successfully, false or nil otherwise.
local Shared = {
  setup = function()
    require("shared.env")
    require("shared.monitor")
    require("shared.programs")

    require("shared.keymaps") -- .init

    require("shared.animation")
    require("shared.binds")
    require("shared.cursor")
    require("shared.debug")
    require("shared.ecosystem")
    require("shared.group")

    require("shared.gestures")

    require("shared.input")
    require("shared.layouts")
    require("shared.misc")
    require("shared.opengl")
    require("shared.quirks")
    require("shared.render")
    require("shared.visualfeel")
    require("shared.xwayland")

    require("shared.rules.init")

    require("shared.execs")
    return true
  end,
}

-- ---@class HyprConfig.Shared
-- ---@field setup? AssociatedMethod|AssociatedFunction
-- local Shared = {
--   setup = setup, -- we could define sep. ig?
-- }

--- Setting up a metatable so that both:
--- ```
--- local shared = require("shared")
--- shared.setup()
--- -- AND
--- shared:setup()
--- function identically.
--- ```
setmetatable(Shared, {
  __call = function(self, ...)
    -- This gross thing just avoids an elseif set of chains via `or`
    if
      self.setup
      or type(self) == "table" and self.setup
      or type(self) == "table" and type(self.setup) == "function"
    then
      return self.setup(...)
    else
      error("Shared.setup is not defined")
    end
  end,
})

---@return HyprConfig.Shared
return Shared
