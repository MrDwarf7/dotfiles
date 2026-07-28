local arch = require("utils.arch")

---@class utils.Converter
---@field debugging boolean
local Converter = {
  debugging = false,
}

--- Strip the `oil://` prefix from a filepath.
---@param filepath PathBuf
---@return PathBuf
local function strip(filepath)
  return string.gsub(filepath or "", "oil://", "")[1]
end

--- Strategy: via_oil -- get path from oil.nvim API when in an oil buffer
---@return PathBuf|nil
---@private
local function via_oil()
  if not package.loaded["oil"] then
    return nil
  end

  local ok, oil = pcall(require, "oil")
  if not ok then
    return nil
  end

  local cur_buf = vim.api.nvim_get_current_buf()
  if vim.bo[cur_buf].filetype ~= "oil" then
    return nil
  end

  local dir = oil.get_current_dir(cur_buf)
  if not dir or dir == "" then
    return nil
  end

  -- oil.get_current_dir() already returns a proper OS path (no oil:// prefix)
  -- so we just need to strip any trailing slash and append the entry name
  if string.sub(dir, -1) == "/" then
    dir = string.sub(dir, 1, -2)
  end

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  ---@type oil.Entry|nil
  local entry = oil.get_entry_on_line(cur_buf, cursor_pos[1])

  if not entry or entry.type == "parent" then
    return dir
  end

  local name = entry.parsed_name or entry.name or ""
  if name == "" then
    return dir
  end

  -- Strip leading slash from name to avoid double-slash
  if string.sub(name, 1, 1) == "/" then
    name = string.sub(name, 2)
  end

  return string.format("%s/%s", dir, name)
end

--- Strategy: via_expand -- get path from vim.expand when in a normal buffer
---@return PathBuf|nil
---@private
local function via_expand()
  local directory_path = strip(vim.fn.expand("%:p"))

  if arch.get_os_lower() == "windows_nt" then
    directory_path = Converter.windows_path(directory_path)
  end

  -- Get the filename under the cursor
  local filename = vim.fn.expand("<cfile>")
  if string.len(filename) == 0 then
    -- Empty slot in oil or no file under cursor
    return directory_path
  end

  -- If it ends with /, it's a directory
  if string.sub(filename, -1) == "/" then
    return string.format("%s/%s", directory_path, filename)
  end

  -- Remove trailing slash if present
  filename = string.gsub(filename, "/$", "")

  return string.format("%s/%s", directory_path, filename)
end

--- Strategy: via_cwd -- get path from cwd + <cfile>
---@return PathBuf|nil
---@private
local function via_cwd()
  local filename = vim.fn.expand("<cfile>")
  if string.len(filename) == 0 then
    return nil
  end

  local cwd = vim.uv.cwd() or ""
  if string.sub(cwd, -1) == "/" then
    cwd = string.sub(cwd, 1, -2)
  end

  return string.format("%s/%s", cwd, filename)
end

--- Decide which strategy to use and call the appropriate one.
--- Priority: oil > expand > cwd
---@return PathBuf|nil
---@private
local function via_method()
  local path = via_oil()
  if path and path ~= "" then
    return path
  end

  path = via_expand()
  if path and path ~= "" then
    return path
  end

  return via_cwd()
end

function Converter.windows_path(d)
  return string
    .sub(d, 2) -- removes the first `/` char
    .gsub(d, "/", "\\") -- converts all `/` to `\\`
    .sub(d, 1, 1) .. ":" .. string
    .sub(d, 2) -- Adds the `:` after the initial drive letter
    -- removes the last `\\` char(s)
    .sub(d, 1, -2)
end

--- Get the full file path (directory + filename).
--- Works in both oil buffers and normal buffers.
---@param opts? utils.Converter.Opts
---@return PathBuf|nil
function Converter.fullpath(opts)
  opts = opts or {}

  local path
  if opts.filepath then
    path = opts.filepath
  else
    path = via_method()
  end

  if not path or path == "" then
    return nil
  end

  if arch.get_os_lower() == "windows_nt" then
    return Converter.windows_path(path)
  end
  return path
end

--- Get just the directory path (full path with filename removed).
---@param opts? utils.Converter.Opts
--- @return PathBuf|nil
function Converter.dirpath(opts)
  opts = opts or {}
  local path = Converter.fullpath(opts)

  if not path or path == "" then
    return nil
  end

  -- Strip trailing slash
  if string.sub(path, -1) == "/" then
    path = string.sub(path, 1, -2)
  end

  -- Extract directory portion
  local dirpath = string.match(path, "(.*/)")
  if not dirpath or dirpath == "" then
    return path
  end

  -- Strip trailing slash from dirpath
  if string.sub(dirpath, -1) == "/" then
    dirpath = string.sub(dirpath, 1, -2)
  end

  return dirpath
end

--- Get just the filename (no directory path).
---@param opts? utils.Converter.Opts
--- @return FileName|nil
function Converter.filename(opts)
  opts = opts or {}
  local path = Converter.fullpath(opts)

  if not path or path == "" then
    return nil
  end

  -- Handle directory paths: if it ends with / or has no filename component
  if string.sub(path, -1) == "/" then
    return nil
  end

  -- Extract the filename portion
  local filename = string.match(path, "([^/]+)$")
  opts.strip_extension = opts.strip_extension or false
  if opts.strip_extension and filename then
    filename = string.match(filename, "(.+)%..+$") or filename
  end

  return filename
end

--- Get just the directory name (last path component of the directory).
---@param opts? utils.Converter.Opts
--- @return string|nil
function Converter.dirname(opts)
  opts = opts or {}
  local dirpath = Converter.dirpath(opts)

  if not dirpath or dirpath == "" then
    return nil
  end

  -- Get the last component of the directory path
  local dirname = string.match(dirpath, "([^/]+)$")

  if opts.trailing_slash and dirname then
    dirname = dirname .. "/"
  end

  return dirname
end

function Converter.relative(opts)
  opts = opts or {}
  local path = Converter.fullpath(opts)

  if not path or path == "" then
    return nil
  end

  local cwd = vim.uv.cwd() or ""
  -- Strip trailing slash from cwd
  if string.sub(cwd, -1) == "/" then
    cwd = string.sub(cwd, 1, -2)
  end

  local prefix = cwd .. "/"
  if string.sub(path, 1, #prefix) == prefix then
    return string.sub(path, #prefix + 1)
  end

  return path
end

function Converter.filepath_relative(opts)
  return Converter.relative(opts)
end

function Converter.setup()
  return setmetatable(Converter, {
    __index = Converter,
    __tostring = function()
      return "filepath_converter"
    end,
    __call = function(opts)
      return Converter.fullpath(opts)
    end,
  })
end

---@return utils.Converter
return Converter.setup()
