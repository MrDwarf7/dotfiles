-- ## Known mappings of generic name to actual hex codes
-- error      = "#DC2626"
-- warning    = "#FBBF24"
-- info       = "#2563EB"
-- hint       = "#10B981"
-- default    = "#7C3AED"
-- test       = "#FF00FF"
--
-- feat       = "#BEE1D4" -- "#a4f7bb"
-- refactor   = "#ffd86a"

--- Custom Colors Lookup (ccl) table for todo-comments.nvim plugin.
---@class CustomColorsLookup : table
local ccl = {
  ["FEAT"] = "#a4f7bb",
  ["REF"] = "#ffd86a",
}
-- Aliases for different (existing) types
local ccl_aliases = {
  ["REFACTOR"] = "REF",
}

-- stylua: ignore start
local apply_aliasing = function(alias)
  if type(alias) ~= "string" then return end
  alias = string.upper(alias) or ""

  local alias_value = ccl_aliases[alias]
  if not alias_value then return end                        -- ccl_aliases doesn't have the alias we're mapping over - this almost imp
  if not ccl[alias] then rawset(ccl, alias, ccl[alias_value]) end  -- set the alias in ccl to the value of the original key
  return ccl[alias]
end
-- stylua: ignore end

require("vim_ext").lst.map(vim.tbl_keys(ccl_aliases), apply_aliasing)

--- Get the color for a given key from the ccl table.
---@param key any
---@return string
ccl.get = function(key)
  key = string.upper(key) or "DEFAULT"
  local val = rawget(ccl, key)
  if not val then
    require("utils").output.warn(
      "Color for key '" .. key .. "' not found in ccl table. Returning default color #FFFFFF."
    )
    return "#FFFFFF"
  end
  return val
end

--- Verify that the given key is valid and exists in the ccl table.
--- Uses rawget to avoid triggering the metatable __index method.
---@param key any
---@return string|nil The return value here is the uppercased key if valid, or nil if invalid.
ccl.verify = function(key)
  if type(key) ~= "string" and type(key) ~= "table" then
    return nil
  end
  if type(key) == "table" then
    key = string.upper(key[#key])
  else
    key = string.upper(key)
  end
  if not rawget(ccl, key) then
    return nil
  end
  return key
end

--- Get the color for a given key from the ccl table, verifying the key first.
---@param caller string
---@param tbl GettableTable
---@param key any
---@return string|nil
local verify_and_ret = function(caller, tbl, key)
  local vk = tbl.verify(key)
  if not vk then
    require("utils.output").warn("[todo-comments :: ccl :: " .. string.format("%s ", caller) .. "] Failed to validate")
    return nil
  end
  key = vk
  return tbl.get(key)
end

setmetatable(ccl, {
  --- __index metamethod for the ccl table. This allows for accessing colors using ccl[key].
  ---@param _ any
  ---@param key any
  ---@return string|nil
  __index = function(_, key)
    return verify_and_ret("__index", ccl, key)
  end,
  --- __call metamethod for the ccl table. This allows for calling ccl(key) to get the color.
  ---@param _ any
  ---@param key any
  ---@return string|nil
  __call = function(_, key)
    return verify_and_ret("__call", ccl, key)
  end,
})

---@type TodoOptions
local opts = {
  highlight = {
    -- pattern or table of patterns, used for highlighting (vim regex)
    -- THIS IS VIMGREP-esq
    pattern = {
      -- default
      -- TODO: asd
      [[.*<(KEYWORDS)\s*:]],

      -- below will match either:
      -- TODO(@refactor):

      -- TODO(#1):

      [[.*<(KEYWORDS)\([\@\#].*\)\s*:]],
    },
  },
  signs = true, -- Show icons in the signs column
  merge_keywords = true,
      -- stylua: ignore start
  keywords = {
      FIX = { icon = " ",      color = "error" },
      HACK = { icon = " ",     color = "warning" },
      NOTE = { icon = " ",     color = "hint" }, -- Original icon: icon = " ",
      PERF = { icon = " ",     color = "warning" },
      TODO = { icon = " ",     color = "info" },
      WARN = { icon = " ",     color = "warning" },

      -- custom additions
      IMP = { icon = " ",      color = "hint" },          -- nf-fa-exclamation
      HINT = { icon = " ",     color = "hint" },         -- nf-fa-diaspora
      SEE = { icon = " ",      color = "warning" },       -- nf-fa-eye
      FEAT = { icon = " " ,    color = ccl("feat") },   -- nf-fa-rocket
      REF = { icon = " ",      color = ccl("ref") },      -- nf-fa-code_merge
      REFACTOR = { icon = " ", color = ccl("ref") }, -- nf-fa-code_merge

  },
  -- stylua: ignore end
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- THIS USES RG SYNTAX! not vimgrep!!
    pattern = [[\b(KEYWORDS)(\([\@\#].*\))?:]],
  },
}

---@type LazyPluginBase
return {
  "folke/todo-comments.nvim",
  lazy = true,
  ---@type LazyEventSpec
  event = "BufReadPost",
  dependencies = { "nvim-lua/plenary.nvim" },
  ---@type LazyKeys
  keys = {
    -- stylua: ignore start
    -- { "q:", false },
    { "]t", function() return require("todo-comments").jump_next() end, desc = "Next todo comment", },
    { "[t", function() return require("todo-comments").jump_prev() end, desc = "Previous todo comment", },

    { "<leader>ft", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "BUG", "PERF", "HACK", "TEST", "NOTE", "IMP", "FEAT" } }) end, desc = "Todo" },
    { "<leader>fT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "BUG", "FEAT" } }) end, desc = "Todo/Fix/Fixme" },

    -- { "<Leader>ft", "<CMD>TodoFzfLua{tag = {TODO,FIX,FIXME,BUG}}<cr>", desc = "Todo/Fix/Fixme (Trouble)", },
    -- {
    --   "<Leader>ft",
    --   function()
    --     local project_wide = string.format("rg --files --glob '.*' --glob '!%s'",
    --       vim.fn.escape(vim.fn.getcwd() .. "/.git/**", " "))
    --     vim.cmd("TodoFzfLua keywords=TODO,FIX,FIXME cwd=" .. project_wide)
    --   end,
    --   desc = "Todo/Fix/Fixme (FzfLua)"
    -- },

    -- { "<Leader>lt", "<CMD>TodoLocList<CR>",                                           desc = "list [t]odo's",            mode = "n" },
    -- stylua: ignore end
  },

  ---@type TodoOptions
  opts = opts,
}
