require("types")
local arch = require("utils.arch")

---@generic P: PathBuf
---@class FilePathConverter
---@field __tostring fun(): string
---@field __call fun(filepath: PathBuf): PathBuf
---@field file_path fun(): nil
---@field directory_path fun(): nil
---@field handle_filepath fun(): PathBuf
local M = {}

--- Convert filepath
setmetatable(M, {
  __index = M,
  __tostring = function()
    return string.format("filepath_converter")
  end,
  __call = function()
    return M.handle_filepath()
  end,
  __metatable = "filepath_converter",
})

---@generic T: table<any, any>
---@generic F: fun(t: any): any
---@param t T
---@param f F
---@return table<T, F>
local fold = function(t, f)
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
local fmt_fullpath = function(mapping_pair)
  ---@type table<_, [PathBuf]>
  local folded = fold(mapping_pair, function(pair)
    local directory_path = pair[1] -- PathBuf
    local filename = pair[2] -- FileName

    if string.sub(directory_path, -1) == "/" then
      directory_path = string.sub(directory_path, 1, -2) -- remove trailing `/`
    end

    if string.sub(filename, 1, 1) == "/" then
      filename = string.sub(filename, 2) -- remove leading `/`
    end

    return string.format("%s/%s", directory_path, filename)
  end)

  ---@return FullPathMap

  local full_path_map = {}
  for _, v in pairs(folded) do
    table.insert(full_path_map, v)
  end

  return full_path_map
end

---@param filepath PathBuf
M.strip = function(filepath)
  filepath = filepath or ""
  -- strips off the `oil://` prefix
  return string.gsub(filepath, "oil://", "")
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

--- Transforms a *nix style path to a Windows style path.
--- Removes the leading `/` and replaces all `/` with `\`.
--- additionally adds the semicolon (`:`) required for Windows paths,
--- and removes the trailing `/` character.
---
--- Will take a string like:
--- `/C/Users/NAME/dotfiles/.config/nvim/`
--- and transform it to:
--- `C:\Users\NAME\dotfiles\.config\nvim`
---
---@generic W: WindowsPathBuf
---@param d W
M.windows_path = function(d)
  return string
    .sub(d, 2) -- removes the first `/` char
    .gsub(d, "/", "\\") -- converts all `/` to `\`
    .sub(d, 1, 1) .. ":" .. string
    .sub(d, 2) -- Adds the `:` after the initial drive letter
    .sub(d, 1, -2) -- removes the last `\\` char(s)            (Later, we make the `-2` a parameter)
end

---@generic P: PathBuf
---@return P
M.handle_filepath = function()
  ---@type PathBuf
  local directory_path = M.strip(vim.fn.expand("%:p")) -- strip the oil:// prefix

  if arch.get_os_lower() == "windows_nt" then
    -- Windows isn't posix compliant, Oil uses a posix path
    ---@return WindowsPathBuf
    directory_path = M.windows_path(directory_path)
  end

  -- Need to now do checks to see if we're hovering a file
  local filename = vim.fn.expand("<cfile>") -- Get fullname (inc. extension) of the file under the cursor
  local extension = string.match(filename, "%.[^.]+$") -- Get the file extension (if any)
  -- dd(extension)
  -- dd(filename)

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

return M
