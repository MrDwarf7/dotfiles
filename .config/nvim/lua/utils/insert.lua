---@class utils.Insert
---
--- Sets up the insert mappings for various transformations.
--- returns true if the setup was successful, or an error message if it failed.
---@field setup fun(keymaps: config.Keymaps): boolean|void|Error
local Insert = {}

local output = require("utils.output")

--- Handles Lua's behaviour of 0+1 indexing, and makes it [Z]ero [B]ased [I]ndexing
---@param num integer|nil
---@return integer?
local zbi = function(num)
  if not num then
    return num
  end
  if num == 0 then
    return num
  end
  return num - 1
end

---@class InsertContent
---@field register string The register to use for insertion (e.g., "_")
---@field silent boolean Whether to perform the insertion silently (default: true)
---@field content any Additional content or parameters needed for insertion (e.g., custom text to insert)

---@private
---@param insertable InsertContent
---@return nil|Error
function Insert:insert_item(insertable)
  if not insertable then
    return output.error("insert_item: insertable is required")
  end
  if not insertable.register then
    insertable.register = "_"
  end
  if not insertable.silent then
    insertable.silent = true
  end
  insertable = insertable or {
    register = "_",
    silent = true,
    content = nil,
  }

  if not insertable.content then
    return output.error("insert_item: content is required")
  end

  local mode = vim.api.nvim_get_mode().mode
  local content = insertable.content

  if type(content) ~= "string" then
    -- if content is not a string, attempt to convert it to a string for insertion
    if type(content) == "table" then
      content = vim.inspect(content)
    else
      content = tostring(content)
    end
  end

  if not insertable.silent then
    output.info("Inserting content: " .. content)
  end

  vim.fn.setreg(insertable.register, content)
  if mode == "v" or mode == "V" then
    vim.api.nvim_feedkeys("c" .. content, "n", false) -- literally just paste it over the selection
  elseif mode == "n" then
    vim.api.nvim_put({ content }, "c", true, false)
  else
    output.info("Unsupported mode for insert date: " .. mode)
    return
  end

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false) -- escape insert mode as we exit the fn
end

---@class insert.Transform.Inner
---@field lhs string The left-hand side of the mapping (the key combination to trigger the insertion)
---@field rhs string The right-hand side of the mapping (the content to be inserted)

---@generic K
--- Where K : insert.Transform.Inner { K = K, V = insert.Transform.Inner }
---@class insert.Transform<K, insert.Transform.Inner>

---@generic K:string|integer
---@param transform insert.Transform<K, insert.Transform.Inner>
---@param keymaps config.Keymaps
local load_mapping = function(transform, keymaps)
  --
  -- local km = require("config.keymaps")
  local km = keymaps or require("config.keymaps") or output.error("load_mapping: keymaps is required")
  local silent_opts = km.mod()

  --- Converts any underscores to spaces and wraps the first letter
  --- of the section name in square brackets.
  ---@param section_name string
  ---@param first_letter_fn function|nil
  ---@return string
  ---@return integer
  local fmt_section_name = function(section_name, first_letter_fn)
    return string.gsub(section_name, "_", " "):gsub("^%l", first_letter_fn or string.lower):gsub("^(%a)", "[%1]")
  end

  --- Applies a formatted error message for missing sides or what parameters.
  ---@param side string|nil
  ---@param what string|nil
  ---@return string
  local base_err_msg = function(side, what)
    return string.format("load_mapping: %s is required for section '%s'", what, side or "unknown")
  end

  --- Checks if the provided sides and what tables have the same length and raises an error if they don't.
  --- It also checks if each side is not nil and raises an error with a formatted message if it is.
  ---@param sides table<string|function>
  ---@param what table<string>|string[]
  ---@return boolean|void|Error
  local check = function(sides, what)
    if #sides ~= #what then
      return error("check: sides and what must have the same length")
    end

    for i, side in ipairs(sides) do
      if not side then
        output.error(base_err_msg(side, what[i]))
      end
    end
    return true
  end

  ---@param section_name string
  ---@param v insert.Transform.Inner
  for section_name, v in pairs(transform) do
    local disp_name, _ = fmt_section_name(section_name)
    ---@param lhs string
    ---@param rhs string|function
    for lhs, rhs in pairs(v) do
      local ok = check({ lhs, rhs }, { "lhs", "rhs" })
      if not ok then
        return false
      end

      km.map({ "n", "v" }, lhs, function()
        Insert:insert_item({ register = "_", content = rhs })
      end, silent_opts("[i]nsert " .. disp_name))
    end
  end

  return true
end

-- TODO: [opts] : Could move it to be an opts table + configurable
-- behavior for the calls inside of load_mapping.
-- eg:
-- first_letter_fn,
-- modes for km.map({ ... }, ... )
-- and silent_opts stuff

function Insert.setup(keymaps)

  -- stylua: ignore start
  local strpln = function(fp) return fp:gsub(":%d+$", "") end -- strip line number at the end of path if one exists. Byproduct of plugins/init:vim-fetch
  local fp = strpln(vim.fn.expand("%:p"))
  local fn = strpln(vim.fn.expand("%:t"))
  -- stylua: ignore end

  ---@type insert.Transform<insert.Transform.Inner>
  local transform = {
    date = { ["<Leader>id"] = vim.fn.strftime("%Y_%m_%d") },
    line_sep = { ["<Leader>i-"] = tostring(string.rep("-", 50)) },
    fullpath = { ["<Leader>if"] = tostring(fp) },
    filename = { ["<Leader>in"] = tostring(fn) },
  }
  setmetatable(transform, {
    __index = function(_, key)
      return error(string.format("Insert.setup: transform[%s] is not defined", key))
    end,
  })

  local ok = load_mapping(transform, keymaps)
  if not ok then
    return output.error("Insert.setup: failed to load mappings")
  end

  return true
end

---@return utils.Insert
return Insert
