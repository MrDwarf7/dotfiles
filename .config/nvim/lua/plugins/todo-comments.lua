-- ## Known mappings of generic name to actual hex codes
-- error      = "#DC2626"
-- warning    = "#FBBF24"
-- info       = "#2563EB"
-- hint       = "#10B981"
-- default    = "#7C3AED"
-- test       = "#FF00FF"

local ccl = {
  ["FEAT"] = "#BEE1D4",
}

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

-- So.... This version of verify outright CRASHES/LOCKS UP
-- the entire system.
-- Not crash - no kernel reset, no nothing like that.
-- Just...
-- -> Crashes compositor (Hyprland)
-- -> crash to Ly (tui login manager)
-- -> Crashes Ly after about 40s or so
-- -> back to raw tty where can type for about
--    30s then _NOTHING_, full lockup
--
-- This.. Doesn't seem like intended behavior lol....
--
--
--
-- ---@param key string|string[]|table
-- ccl.verify = function(key)
--   local ret
--   vim.validate("key", key, { "string", "table" })
--
--   if type(key) == "string" then
--     key = { key }
--     return ccl.verify(key) -- maybe this? lol.... ooops
--   end
--   if type(key) ~= "table" then
--     require("utils.output").err("ccl.verify: key must be a string or a table of strings.")
--     ret = false
--   end
--   if type(key) == "table" and vim.tbl_isempty(key) then
--     require("utils.output").err("ccl.verify: key table must not be empty.")
--     ret = false
--   end
--
--   local _, err = vim.schedule(function()
--     vim.tbl_map(function(k)
--       vim.validate("key element", k, { "string" })
--       vim.validate("ccl key", ccl[k:upper()], { "string" }, "Color for key '" .. k .. "' not found in ccl table.")
--       ret = true
--     end, key)
--   end)
--
--   if err then
--     require("utils.output").err("ccl.verify: " .. err)
--     ret = false
--   else
--     ret = true
--   end
--   return ret
-- end

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
  keywords = {
      -- stylua: ignore start
      FIX = { icon = " ", color = "error" },
      HACK = { icon = ",", color = "warning" },
      NOTE = { icon = " ", color = "hint" },
      PERF = { icon = " ", color = "warning" },
      TODO = { icon = " ", color = "info" },
      WARN = { icon = " ", color = "warning" },
      -- custom additions
      IMP = { icon = " ", color = "hint" }, -- nf-fa-exclamation
      SEE = { icon = " ", color = "warning" },
      FEAT = { icon = "", color = ccl("feat") }, -- nf-fa-lightbulb_o
    -- FEAT = { icon = "", color = ccl["feat"] },

    -- stylua: ignore end
  },
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
