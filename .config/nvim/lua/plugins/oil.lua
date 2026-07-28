local Converter = require("utils.converter")
-- local map = vim.keymap.set

---@enum ResizeDirection
local ResizeDirection = {
  INCREASE = 1,
  DECREASE = -1,
}

---@param by_value number
---@param pos_neg ResizeDirection
---@return fun()
local silent_vert_resize = function(by_value, pos_neg)
  assert(pos_neg == ResizeDirection.INCREASE or pos_neg == ResizeDirection.DECREASE, "Invalid ResizeDirection")
  return function()
    vim.cmd.resize({
      (pos_neg == ResizeDirection.INCREASE and "+" or "-") .. (by_value or 2),
      mods = { vertical = true },
    })
  end
end

-- ---- example from docs
-- wk.add(
-- {
--   { "<leader>f", group = "file" }, -- group
--   { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
-- })

---@class my_binds
---@field my_keys wk.Spec Table of which-key-compatible specs (list of {lhs, rhs, desc} entries)
---@field all_keymaps table<string, string|function> Oil-compatible merged keymaps (key -> value)
---@field register fun(self): table<string, string|function> Register personal binds with which-key
---@field merge fun(self): table<string, string|function> Merge oil defaults with personal binds
local my_binds = {
  -- stylua: ignore start
  -- These are which-key v3 spec entries: { [1]=lhs, [2]=rhs, desc="..." }
  -- merge() transmutes them into oil's { [lhs]=rhs } format.
  my_keys = {
    { "<leader>yn", function() vim.fn.setreg("+", Converter.filename()) end, desc = "Copy [Y]ank [n]ame" },
    { "<Leader>yc", function() vim.fn.setreg("+", Converter.fullpath()) end, desc = "Copy [Y]ank [c]urrent" },
    { "<leader>yd", function() vim.fn.setreg("+", Converter.dirpath()) end, desc = "Copy [Y]ank [d]irectory" },
    { "<leader>yN", function() vim.fn.setreg("+", Converter.filename({ strip_extension = true })) end, desc = "Copy [Y]ank [d]irectory" },
  -- stylua: ignore end
  },

  --- Populated by calling my_binds.merge()
  all_keymaps = {},

  --- The base oil.nvim keymaps that my_binds will merge personal binds into.
  --- Personal binds in my_keys take priority over entries here on conflict.
  _oil_defaults = {
    ["g?"] = "actions.show_help",
    ["<ESC>"] = "<ESC><cmd>nohl<CR>",

    ["<CR>"] = "actions.select",
    ["<C-]>"] = "actions.select_vsplit",
    -- ["<C-[>"] = "actions.select_split", -- this binding doesn't work

    ["<C-v>"] = "actions.select_vsplit", -- NorthSouth (left | right)
    ["<C-s>"] = "actions.select_split", -- EastWest (top _ bottom)

    -- ["<C-h>"] = silent_vert_resize(2, ResizeDirection.INCREASE)(),
    -- ["<C-l>"] = silent_vert_resize(2, ResizeDirection.DECREASE)(),

    ["<C-h>"] = silent_vert_resize(2, ResizeDirection.INCREASE),
    ["<C-l>"] = silent_vert_resize(2, ResizeDirection.DECREASE),

    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",

    ["@"] = "actions.open_cwd",

    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",

    -- Personal yank binds are in my_keys above; they override these on merge.
    -- Could alternatively use oil's built-in `actions.yank_entry` +
    -- `actions.copy_entry_filename`, but those don't give us the same
    -- control over relative paths.
  },
}

--- Register the personal binds with which-key (in their original spec form).
--- If which-key is not yet loaded, queues a deferred registration so the
--- binds are picked up once which-key becomes available.
---@return table<string, string|function> the merged oil-compatible keymaps
function my_binds:register()
  local ok, wk = pcall(require, "which-key")
  if not ok then
    -- Defer registration until which-key is actually loaded
    -- which-key loads on CursorMoved event, so this will catch it on first keypress
    vim.schedule(function()
      local defer_ok, defer_wk = pcall(require, "which-key")
      if defer_ok then
        defer_wk.add(self.my_keys)
      end
    end)
    return self.all_keymaps
  end

  self = self or my_binds

  -- Register personal binds with which-key in their original spec form
  wk.add(self.my_keys)

  return self.all_keymaps
end

--- Merges the my_binds.my_keys with the default oil.nvim keymaps.
--- Does NOT register with which-key (call register() separately for that).
--- Personal binds take priority over oil defaults.
---@return table<string, string|function> the merged oil-compatible keymaps
function my_binds:merge()
  self = self or my_binds
  self.all_keymaps = self.all_keymaps or {}

  -- Transmute my_keys (which-key specs) into oil keymaps
  -- Each entry: { [1]=lhs, [2]=rhs, desc="..." } -> { [lhs]=rhs }
  local personal_binds = {}
  for _, entry in ipairs(self.my_keys) do
    local lhs = entry[1]
    local rhs = entry[2]
    if lhs and rhs then
      personal_binds[lhs] = rhs
    end
  end

  -- Merge personal binds into oil defaults (personal wins on conflict)
  self.all_keymaps = vim.tbl_extend("force", self._oil_defaults, personal_binds)

  return self.all_keymaps
end

-- Eagerly populate all_keymaps so opts.keymaps can reference it
-- which-key registration is deferred via register() (called from init or lazy_load)
my_binds:merge()

-- Defer which-key registration -- which-key loads lazily on CursorMoved,
-- so we need to register after it's available
vim.schedule(function()
  my_binds:register()
end)

return {
  "stevearc/oil.nvim",
  lazy = false,
  -- ---@type LazyEventSpec
  -- event = { "BufReadPre", "BufNewFile", "WinEnter" },
  -- event = { "VimEnter" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    ---@type LazyEventSpec
    event = "VimEnter",
  },
  priority = 999,
  keys = {
    { "<Leader>e", "<CMD>Oil<CR>", desc = "Oil" },
    { "<C-w>E", "<CMD>lua =require('oil').open_float()<CR>", silent = true, desc = "oil" },
  },

  -- init = function()
  --   if package.loaded["oil"] then
  --     return
  --   end
  --
  --   vim.defer_fn(function()
  --     if not package.loaded["oil"] then
  --       require("oil").setup(require("plugins.oil").opts)
  --     end
  --   end, 30)
  -- end,

  ---@type oil.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    columns = {
      "icon", -- default
      -- "permissions",
      -- "size",
      -- "mtime",
    },

    default_file_explorer = true,
    skip_confirm_for_simple_edits = true, -- default: false
    ---@type oil.ViewOptions
    view_options = {
      show_hidden = true,
      ---@diagnostic disable-next-line: unused-local
      is_hidden_file = function(name, bufnr)
        return false
      end,
      ---@diagnostic disable-next-line: unused-local
      is_always_hidden = function(name, bufnr)
        return false
        -- return name == "node_modules"
        -- name == ".." or
        -- Above would hide the 'up directory' entry in the list
      end,
    },

    win_options = {
      wrap = false,
      signcolumn = "yes:2",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3, -- May want to change this to 0
      concealcursor = "nvic",
    },

    -- Use the merged keymaps from my_binds instead of duplicating them inline
    keymaps = my_binds.all_keymaps,
  },
}
