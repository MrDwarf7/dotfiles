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

---@class HyprConfig.Keymaps
local setup = function()
  local modules = {
    "mods",

    "map_general",
    "map_misc",
    "map_programs",
    "map_windows_workspaces",
  }

  for _, mod in ipairs(modules) do
    require("shared.keymaps." .. mod)
  end
end

---@return HyprConfig.Keymaps
return setup()
