local HOME = os.getenv("HOME")
local hyprdir = HOME .. "/.config/hypr"

local base_paths = {
  hyprdir = hyprdir,
  hypr_scripts = hyprdir .. "/scripts",
  rules_dir = hyprdir .. "/configs/rules",
  keymaps_dir = hyprdir .. "/configs/keymaps",
  programs = hyprdir .. "/configs/programs.conf",
}

---@param paths table<string, string>
local paths_to_lua = function(paths)
  local lua_paths = {}
  paths = paths or {}
  if #paths == 0 then
    return lua_paths
  end

  for key, path in pairs(paths) do
    -- Convert to Lua require path format
    local lua_path = path:gsub("/", "."):gsub("%.conf", "")
    lua_paths[key] = lua_path
  end
  return lua_paths
end

local lua_paths = paths_to_lua(base_paths)

---@diagnostic disable-next-line: undefined-doc-name
---@return HyprConfig.Locations
return {
  HOME = HOME,
  hyprdir = lua_paths.hyprdir or hyprdir or (HOME .. "/.config/hypr"),
  hypr_scripts = lua_paths.hypr_scripts or (hyprdir .. "/scripts"),
  rules_dir = lua_paths.rules_dir,
  keymaps_dir = lua_paths.keymaps_dir,
  -- hyprdir .. "/configs/keymaps",
  programs = lua_paths.programs,
}
