-- TODO: @types
-- require("types")
local arch = require("utils.arch")

---@class utils.Converter
local Converter = {
  debugging = false,
}

--- Convert filepath

---@generic T: table<any, any>
---@generic F: fun(t: any): any
---@param t T
---@param f F
---@return table<T, F>
local function fold(t, f)
  local res = {}
  for k, v in pairs(t) do
    res[k] = f(v)
  end
  return res
end

-- string.format("%s/%s", directory_path, filename)

---@generic I: number
---@param mapping_pair table<I, [PathBuf, FileName]>
---@return FullPathMap
local function fmt_fullpath(mapping_pair)
  ---@type table<_, [PathBuf]>
  local folded = fold(mapping_pair, function(pair)
    local directory_path = pair[1] -- PathBuf
    local filename = pair[2]     -- FileName

    if string.sub(directory_path, -1) == "/" then
      directory_path = string.sub(directory_path, 1, -2) -- remove trailing `/`
    end

    if string.sub(filename, 1, 1) == "/" then
      filename = string.sub(filename, 2) -- remove leading `/`
    end

    vim.print(directory_path)
    vim.print(filename)

    return string.format("%s/%s", directory_path, filename)
  end)

  ---@return FullPathMap

  local full_path_map = {}
  for _, v in pairs(folded) do
    table.insert(full_path_map, v)
  end

  return full_path_map
end

function Converter.strip(filepath)
  return string.gsub(filepath or vim.fn.expand("%:p") or "", "oil://", "")[1]
end

--- eg's:
---
--- Linux ---
--- From inside normal buffer:
--- %:p == "/home/dwarf/dotfiles/.config/lazyvim/lua/plugins/oil.lua"
--- `<cfile>` = "desc" (whatever the cursor is over to the end of W )
---
--- From inside oil buffer:
--- %:p = "oil:///home/dwarf/dotfiles/.config/lazyvim/lua/plugins/"
--- <cfile> = "oil.lua"
---

---@generic W: WindowsPathBuf
---@param d W
function Converter.windows_path(d)
  return string
      .sub(d, 2)      -- removes the first `/` char
      .gsub(d, "/", "\\") -- converts all `/` to `\`
      .sub(d, 1, 1) .. ":" .. string
      .sub(d, 2)      -- Adds the `:` after the initial drive letter
      .sub(d, 1, -2)  -- removes the last `\\` char(s)            (Later, we make the `-2` a parameter)
end

---@generic P: PathBuf
---@return P
---@deprecated Use `utils.Converter.fullpath()` or `utils.Converter.relative()` instead.
function Converter._filepath()
  ---@type PathBuf
  local directory_path = Converter.strip(vim.fn.expand("%:p")) -- strip the oil:// prefix

  if arch.get_os_lower() == "windows_nt" then
    -- Windows isn't posix compliant, Oil uses a posix path
    ---@return WindowsPathBuf
    directory_path = Converter.windows_path(directory_path)
  end

  -- Need to now do checks to see if we're hovering a file
  local filename = vim.fn.expand("<cfile>")           -- Get fullname (inc. extension) of the file under the cursor
  local extension = string.match(filename, "%.[^.]+$") -- Get the file extension (if any)

  -- if empty, it's an empty slot in oil (TODO: We could look for cloest?)
  if string.len(filename) == 0 then
    return directory_path
  end

  -- create a pairings structure of table<PathBuf, [FileName]>
  -- and store directory_path as the key,
  -- and the list of filenames as the value

  -- if it ends with a `/`, it's a directory
  if string.sub(filename, -1) == "/" then
    -- table.insert(mapping_pair, { directory_path, filename })
    -- return string.format("%s/%s", directory_path, filename)
    return fmt_fullpath({ _ = { directory_path, filename } })
  end

  -- remove the trailing `/` if it exists
  filename = string.gsub(filename, "/$", "") -- remove trailing `/` if it exists

  -- if it has a file extension, it's a file
  if extension then
    -- if it has an extension, it's a file
    return fmt_fullpath({ _ = { directory_path, filename } })
    -- return string.format("%s/%s", directory_path, filename)
  end

  return fmt_fullpath({ _ = { directory_path, filename } })
  -- string.format("%s/%s", directory_path, filename) -- safe to re-add the `/` here
end

function Converter.fullpath(opts)
  opts = opts or {}
  local path = ""

  local oil_available = function()
    if package.loaded["oil"] then
      return true
    end

    local ok, _ = pcall(require, "oil")
    if not ok then
      return false
    end
  end

  -- no oil.nvim available
  if not oil_available() then
    return Converter._filepath() ---@diagnostic disable-line: invisible
  end

  -- using oil.nvim

  local oil = require("oil")

  if opts.filepath then
    path = opts.filepath
  else
    local cur_buf = vim.api.nvim_get_current_buf()

    ---@alias Row number
    ---@alias Col number

    ---@class CursorPos
    ---@field row Row
    ---@field col Col

    ---@type CursorPos
    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    local entry = oil.get_entry_on_line(cur_buf, cursor_pos[1])
    local dir = oil.get_current_dir(cur_buf)
    if not dir then
      return Converter._filepath() ---@diagnostic disable-line: invisible
    end

    dir = string.gsub(dir, "oil://", "")
    if string.sub(dir, -1) == "/" then
      dir = string.sub(dir, 1, -2) -- remove trailing `/`
    end

    if not entry or entry.type == "parent" then
      path = dir
      return path
    end
    local parsed_name = entry.parsed_name or entry.name or ""
    if string.sub(parsed_name, 1, 1) == "/" then
      parsed_name = string.sub(parsed_name, 2) -- remove leading `/`
    end

    if entry == nil then
      path = dir
    else
      path = string.format("%s/%s", dir, parsed_name)
    end
  end

  if not path or #path == 0 then
    path = Converter._filepath() ---@diagnostic disable-line: invisible
  end

  local cleaned_path = ""
  if arch.get_os_lower() == "windows_nt" then
    -- Windows isn't posix compliant, Oil uses a posix path
    ---@return WindowsPathBuf
    cleaned_path = Converter.windows_path(path)
  else
    cleaned_path = path
  end

  if not cleaned_path or #cleaned_path == 0 then
    cleaned_path = Converter._filepath() ---@diagnostic disable-line: invisible
  end

  return cleaned_path
end

function Converter.relative(opts)
  opts = opts or {}
  opts.filepath = opts.filepath or nil
  local path = Converter.fullpath(opts)
  local cwd = require("oil").get_current_dir() or vim.uv.cwd()

  if not cwd or #cwd == 0 then
    return path
  end

  local stripped = ""

  -- strip the trailing `/` from cwd if it exists
  if string.sub(cwd, -1) == "/" then
    cwd = string.sub(cwd, 1, -2)
  end

  stripped = string.gsub(path, "^" .. cwd .. "/", "")

  return stripped
end

function Converter.setup()
  return setmetatable(Converter, {
    __index = Converter,
    __tostring = function()
      return string.format("filepath_converter")
    end,
    __call = function(opts)
      return Converter.fullpath(opts)
    end,
    __metatable = "filepath_converter",
  })
  -- return Converter
end

---@return utils.Converter
return Converter
