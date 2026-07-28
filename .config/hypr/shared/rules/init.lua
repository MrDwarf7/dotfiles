--- Window rules loader.
--- Each module calls hl.window_rule() directly at require time.
--- No registry, no generators, no DSL. Just Lua calling the API.

---@class HyprConfig.Shared.Rules
---@field setup fun():Associated|bool|nil Returns true if setup completed successfully, false or nil otherwise.
local setup = function()
  return RootShared.load_modules("shared.rules", {
    "globals",

    "float_center",
    "title_dialogs",
    "tag_effects",
    "popups",
    "pip",
    "misc_rules",
    "steam",
    "vivaldi",
    "jetbrains",
    "alecaframe",
    "chromium",
    "obsidian",
    "zed",
    "ghostty",
    "code",
  })
end

return setup()
