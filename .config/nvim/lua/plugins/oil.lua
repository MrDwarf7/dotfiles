local Converter = require("utils.converter")
-- local map = vim.keymap.set

---@enum ResizeDirection
local ResizeDirection = {
  INCREASE = 1,
  DECREASE = -1,
}

---@param by_value number
---@param pos_neg ResizeDirection
---@return fun(): string
local silent_vert_resize = function(by_value, pos_neg)
  assert(pos_neg == ResizeDirection.INCREASE or pos_neg == ResizeDirection.DECREASE, "Invalid ResizeDirection")
  return function() ---@return fun(): string
    return vim.cmd.resize({ ---@return string
      (pos_neg == ResizeDirection.INCREASE and "+" or "-") .. (by_value or 2),
      mods = { vertical = true },
    })
  end
end

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
    { "<Leader>e", "<CMD>Oil<CR>", desc = "Oily" },
    { "<C-w>E", "<CMD>lua =require('oil').open_float()<CR>", silent = true, desc = "oil" },
  },

  init = function()
    if package.loaded["oil"] then
      return
    end

    vim.defer_fn(function()
      if not package.loaded["oil"] then
        require("oil").setup(require("plugins.oil").opts)
      end
    end, 30)
  end,

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
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        return false
      end,
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

    keymaps = {
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

      -- directory path
      ["<Leader>yC"] = function()
        -- vim.fn.setreg("+", Converter._filepath()) -- write to clippoard
        vim.fn.setreg("+", Converter.fullpath())
      end,

      -- full_path (incl. filename + extension)
      ["<leader>yc"] = function()
        -- vim.fn.setreg("+", Converter._filepath())
        vim.fn.setreg("+", Converter.relative())
      end,

      ["<Leader>f/"] = "<CMD>Oil<Tab>",
    },
  },
}
