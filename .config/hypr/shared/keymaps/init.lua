--- Keymaps sub-module — self-contained.
--- Loads mods internally, then requires all keymap files.
--- Each keymap file calls hl.bind() directly as a side effect.

-- Load mod definitions (required by all keymap files)
-- require("shared.keymaps.mods")

-- Load all keymap modules (side effects only — each calls hl.bind)
-- require("shared.keymaps.map_general")
-- require("shared.keymaps.map_misc")
-- require("shared.keymaps.map_programs")
-- require("shared.keymaps.map_windows_workspaces")

-- local root_shrd = require("utils.root_shared")
--
-- ---@class HyprConfig.Keymaps
-- local setup = function()
--   return root_shrd.load_modules("shared.keymaps.", {
--     "mods",
--
--     "map_general",
--     "map_misc",
--     "map_programs",
--     "map_windows_workspaces",
--   })
-- end
--
-- ---@return HyprConfig.Keymaps
-- return setup()

-- TODO: See: https://wiki.hypr.land/configuring/code-snippets/#vim-like-keymaps
-- For info on how to create keymaps as if they were vim-like/modal style!

---@class HyprConfig.Keymaps
---@return HyprConfig.Keymaps
return require("utils.root_shared").load_modules("shared.keymaps", {
  "mods",

  "map_general",
  "map_misc",
  "map_programs",
  "map_windows_workspaces",
})
