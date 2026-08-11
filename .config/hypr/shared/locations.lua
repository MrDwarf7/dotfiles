local HOME = os.getenv("HOME") ---@cast HOME DirPathBuf
local hyprdir = HOME .. "/.config/hypr" ---@cast hyprdir DirPathBuf

---@type HyprConfig.Locations
local base_paths = {
  hyprdir = hyprdir,
  hypr_scripts = hyprdir .. "/scripts",
  rules_dir = hyprdir .. "/configs/rules",
  keymaps_dir = hyprdir .. "/configs/keymaps",
  programs = hyprdir .. "/configs/programs.conf",
}

---@generic D : DirPathBuf
---@generic L : LuaPathBuf
---@param paths HyprConfig.Locations<D>
---@return HyprConfig.Locations<L>
local paths_to_lua = function(paths)
  local lua_paths = {} ---@cast lua_paths HyprConfig.Locations<LuaPathBuf>

  paths = paths or {}
  if #paths == 0 then
    return lua_paths
  end

  for key, path in pairs(paths) do
    ---@cast key Index

    -- Convert to Lua require path format
    local lua_path = path:gsub("/", "."):gsub("%.conf", "") ---@cast lua_path LuaPathBuf

    lua_paths[key] = lua_path
  end
  return lua_paths
end

local lua_paths = paths_to_lua(base_paths)

---@diagnostic disable-next-line: undefined-doc-name
---@generic L : LuaPathBuf
---@return HyprConfig.Locations<L>
return {
  HOME = HOME,
  hyprdir = lua_paths.hyprdir or hyprdir or (HOME .. "/.config/hypr"),
  hypr_scripts = lua_paths.hypr_scripts or (hyprdir .. "/scripts"),
  rules_dir = lua_paths.rules_dir,
  keymaps_dir = lua_paths.keymaps_dir,
  -- hyprdir .. "/configs/keymaps",
  programs = lua_paths.programs,
}
