---@class utils.Validation
---@field __name string
---@field logging_section string
---@field debugging boolean
---
---@field validate_fstat_type fun(full_path: PathBuf, expected_type: ExpectedFsStatType): uv.fs_stat.result?
---@field validate_env fun(env: PathBuf?): PathBuf?
---@field validate_rem_path fun(rem: PathBuf?): PathBuf?
---@field validate_fullpath fun(full_path: PathBuf): PathBuf?
---@field expand_create_file fun(primary_section?: string, env: string|nil, rem: string|nil): PathBuf?
---@field setup fun(logging_section?: string): utils.Validation
---@return utils.Validation

local Validation = {
  __name = "utils.Validation",
  __debugger = require("utils.output").d,
  logging_section = nil,
  debugging = false,
}

Validation.__name = "utils.Validation"

local __name = setmetatable({}, {
  __tostring = function()
    return Validation.__name or Validation.logging_section or "utils.Validation"
  end,
})
local n = string.format("%s", tostring(__name))
Validation.__name = n
Validation.logging_section = n

local vald = Validation.__metatable or {}
local d = vald.__debugger or function(...) end

---@param full_path PathBuf
---@param expected_type ExpectedFsStatType
---@return uv.fs_stat.result?
function Validation.validate_fstat_type(full_path, expected_type)
  local fp = vim.fs.abspath(full_path)
  d(n, "validate_fstat_type", "Validating abspath for fp: ", fp)

  local ok, stat = pcall(vim.uv.fs_stat, fp)
  if not ok then
    d(n, "validate_fstat_type", "fs_stat call failed for path", fp)
    return nil
  end

  if stat == nil then
    return nil
  end

  d(n, "validate_fstat_type", "fs_stat result", stat)

  if stat.type ~= expected_type then
    d(n, "validate_fstat_type", "Type mismatch", { expected = expected_type, actual = stat.type })
    return nil
  end

  d(n, "validate_fstat_type", "Type match", { expected = expected_type, actual = stat.type })
  return stat
end

---@param env PathBuf?
---@return PathBuf?
function Validation.validate_env(env)
  env = vim.env[env] or nil
  if type(env) == "nil" then
    return nil
  end

  if type(env) ~= "string" then
    return nil
  end

  local expanded = vim.fn.expand(env)
  if type(expanded) ~= "string" or expanded == "" then
    return nil
  end

  local t = Validation.validate_fstat_type(expanded, "directory")
  if not t then
    return nil
  end

  d(n, "validate_env", "Validated env path", expanded)

  return expanded
end

---@param rem PathBuf?
---@return PathBuf?
function Validation.validate_rem_path(rem)
  if type(rem) ~= "string" then
    return nil
  end

  if require("utils.arch").get_os_lower() == "windows_nt" then
    rem = require("utils.converter").windows_path(rem)
  end

  if string.sub(rem, 1, 1) ~= "/" then
    rem = "/" .. rem
  end

  return rem
end

---@param full_path PathBuf
---@return PathBuf?
function Validation.validate_fullpath(full_path)
  if type(full_path) ~= "string" or full_path == "" then
    return nil
  end

  d(n, "validate_fullpath", "Validating full path", full_path)

  return full_path
end

---@param primary_section? string
---@param env string|nil
---@param rem string|nil
---@return PathBuf?
function Validation.expand_create_file(primary_section, env, rem)
  -- print("validation module: " .. type(primary_section))
  primary_section = primary_section or nil

  local old_name = Validation.__name
  setmetatable(Validation, {
    __name = primary_section,
    logging_section = primary_section,
  })

  env = Validation.validate_env(env) or vim.env["XDG_CACHE_HOME"] or vim.env["HOME"] .. "/.cache"
  rem = Validation.validate_rem_path(rem) or "/venv-selector/venvs2.json"

  d(primary_section, "expand_create_file", "Using env path", env)

  local full_path
  full_path = env .. rem
  d(primary_section, "expand_create_file", "Constructed full path", full_path)

  -- create directory if it doesn't exist
  if vim.uv.fs_stat(vim.fn.fnamemodify(full_path, ":h")) == nil then
    ---@type err ErrorCode?
    local err = vim.fn.mkdir(vim.fn.fnamemodify(full_path, ":h"), "p")
    if err then
      require("utils.output").err("Failed to create directory for venv-selector cache: " .. err)
      return nil
    end
  end

  local ok, final_stat = pcall(vim.uv.fs_stat, full_path)
  if not ok or final_stat == nil then
    -- create file if it doesn't exist
    local file = io.open(full_path, "w")
    if file then
      file:write("{}")
      file:close()
    else
      require("utils.output").err("Failed to create venv-selector cache file.")
      return nil
    end
    full_path = Validation.validate_fullpath(full_path)
  end

  if not full_path then
    return nil
  end

  d(primary_section, "expand_create_file", "Final cache file path", full_path)

  setmetatable(Validation, {
    __name = old_name,
    logging_section = nil,
  })

  return full_path
end

---@param logging_section string?
---@return utils.Validation
function Validation.setup(logging_section)
  logging_section = logging_section or Validation.logging_section or "utils.Validation"

  -- _G.dump({
  -- 	validation = Validation,
  -- })

  return setmetatable(Validation, {
    __call = function(_)
      return Validation.setup()
    end,
    __tostring = function()
      return tostring(logging_section)
    end,
    __index = Validation,
    __name = n or "utils.Validation",
    __debugger = Validation.__debugger,
  })
end

-- return Template.setup()
return Validation.setup()
