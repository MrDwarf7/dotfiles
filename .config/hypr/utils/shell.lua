-- HYPRLAND_SHELL catalog. Key == env string == folder under ~/.config/hypr/.

--- Nominal string: a known HYPRLAND_SHELL value / folder name.
---@class HyprConfig.ShellKey : string

--- Known shells. Index with the env string (`catalog.dms`, `catalog["vanilla"]`).
---@class HyprConfig.ShellCatalog : table<HyprConfig.ShellKey, HyprConfig.ShellKey>
--- Default / fallback: waybar, swww/awww, swaync.
---@field vanilla HyprConfig.ShellKey
--- DankMaterialShell (quickshell). Current daily driver.
---@field dms HyprConfig.ShellKey
--- Noctalia. Folder stub / future.
---@field noctalia HyprConfig.ShellKey
local catalog = {
  vanilla = "vanilla",
  dms = "dms",
  noctalia = "noctalia",
}

--- Resolve the shell name.
--- `override` if a non-empty string, else `envs.HYPRLAND_SHELL`, else `vanilla`.
--- Input is lowercased so "DMS" still hits catalog.dms; keys stay lowercase.
---@param override? EnvVarValue|HyprConfig.ShellKey
---@return HyprConfig.ShellKey
local get = function(override)
  local v = override
  if type(v) ~= "string" or v == "" then
    v = require("shared.env").HYPRLAND_SHELL
  end
  local hit = type(v) == "string" and v ~= "" and catalog[v:lower()]
  if hit then
    ---@cast hit HyprConfig.ShellKey
    return hit
  end
  return catalog.vanilla
end

--- Catalog plus `get()`. Dot-index for names (`shell.dms`);
--- call `get()` (or the table) to resolve override / env / vanilla.
---@class HyprConfig.Shell : HyprConfig.ShellCatalog
--- Resolve the active shell name.
---@field get fun(override?: EnvVarValue|HyprConfig.ShellKey): HyprConfig.ShellKey
local shell = {
  get = get,
}

setmetatable(shell, {
  __index = catalog,
  __call = function(_, ...)
    return get(...)
  end,
})

---@type HyprConfig.Shell
---@return HyprConfig.Shell
return shell
