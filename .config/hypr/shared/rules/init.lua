--- Window rules loader.
--- Each module calls hl.window_rule() directly at require time.
--- No registry, no generators, no DSL. Just Lua calling the API.
---@module 'types'

local root_shrd = require("utils.root_shared")

---@class HyprConfig.Shared.Rules
---@field setup fun():Associated|bool|nil Returns true if setup completed successfully, false or nil otherwise.
local setup = function()
  -- stylua: ignore start
  return root_shrd.load_modules("shared.rules", {
    "globals",
    "buckets",            -- bucket behavior stanzas + bucket() helper (load BEFORE members)
    "registry",           -- standalone apps: exact HL API, looped (no bucket)

    "affine",             -- tickets bucket
    "alecaframe",         -- standalone (overwolf child windows)
    "chromium",           -- browsers bucket + devtools
    "code",               -- gui_editors bucket
    "davinici",           -- DaVinci Resolve and child windows/popups
    "faugus",             -- gaming bucket
    "file_managers",      -- bucket member (file_managers)
    "float_indicators",   -- bucket member (float_indicators)
    "ghostty",            -- terminals bucket
    "heroic",             -- gaming bucket
    "jetbrains",          -- gui_editors bucket + workarounds
    "kitty",              -- terminals bucket
    "linear",             -- tickets bucket
    "lutris",             -- gaming bucket
    "obsidian",           -- notes bucket + mini window
    "openrgb",            -- standalone (RGB controller)
    "pip",                -- picture-in-picture floats
    "popups",             -- portal/polkit float + stay_focused
    "signal",             -- private_comms bucket
    "spotify",            -- music bucket
    "steam",              -- gaming bucket + child windows
    "telegram",           -- private_comms bucket
    "thunderbird",        -- email bucket + compose windows
    "title_dialogs",      -- loop+helper: file dialog float+center
    "todoist",            -- notes bucket (pending class confirm)
    "vivaldi",            -- browsers bucket + settings/webapp
    "wezterm",            -- terminals bucket
    "yt_music",           -- music bucket
    "zed",                -- gui_editors bucket + settings
    "zen",                -- browsers bucket
  -- stylua: ignore end
  })
end

return setup()
