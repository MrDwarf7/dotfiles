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

-- TODO:
-- PERF:
-- _MAYBE_ worth testing every module _just_ returning its table contents directly
-- then here we merge all child tables, and make a single external/outbound call to HL api?

---@class HyprConfig.Shared
---@return HyprConfig.Shared
return require("utils.root_shared").load_modules("shared", {
  "env",
  "monitor",
  "programs",
  "keymaps",
  "animation",
  "binds",
  "cursor",
  "debug",
  "ecosystem",
  "group",
  "gestures",
  "input",
  "layouts",
  "misc",
  "opengl",
  "quirks",
  "render",
  "visualfeel",
  "xwayland",
  "rules",
  "execs",
})

----------------------------
-- Old code - we orig. had indirection via a `setup()` function,
-- but now we just load the modules directly.
----------------------------

-- ---@alias Associated AssociatedFunction|AssociatedMethod

-- -- local root_shrd = require("utils.root_shared")
-- --
-- -- ---@class HyprConfig.Shared
-- -- ---@field setup fun():Associated|bool|nil Returns true if setup completed successfully, false or nil otherwise.
-- -- local shared = {
-- --   setup = function()
-- --     return root_shrd.load_modules("shared", {
-- --       "env",
-- --       "monitor",
-- --       "programs",
-- --       "keymaps",
-- --       "animation",
-- --       "binds",
-- --       "cursor",
-- --       "debug",
-- --       "ecosystem",
-- --       "group",
-- --       "gestures",
-- --       "input",
-- --       "layouts",
-- --       "misc",
-- --       "opengl",
-- --       "quirks",
-- --       "render",
-- --       "visualfeel",
-- --       "xwayland",
-- --       "rules",
-- --       "execs",
-- --     })
-- --   end,
-- -- }
-- --
-- -- --- Setting up a metatable so that both:
-- -- --- ```lua
-- -- --- local shared = require("shared")
-- -- --- shared.setup()
-- -- --- ```
-- -- --- -- AND
-- -- --- ```lua
-- -- --- shared:setup()
-- -- --- function identically.
-- -- --- ```
-- -- setmetatable(shared, {
-- --   __call = function(self, ...)
-- --     -- This gross thing just avoids an elseif set of chains via `or`
-- --     if
-- --       self.setup
-- --       or type(self) == "table" and self.setup
-- --       or type(self) == "table" and type(self.setup) == "function"
-- --     then
-- --       return self.setup(...)
-- --     else
-- --       error("Shared.setup is not defined")
-- --     end
-- --   end,
-- -- })
-- --
-- -- ---@type HyprConfig.Shared
-- -- ---@return HyprConfig.Shared
-- -- return shared

-- ---@type HyprConfig.Shared
