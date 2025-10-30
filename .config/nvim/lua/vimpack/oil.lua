local converter = require("utils.converter")
local map = vim.keymap.set

local M = {}

local module_opts = {
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
    ["<C-[>"] = "actions.select_split",
    -- ["<C-h>"] = ":vertical resize +2<CR>",

    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",

    ["@"] = "actions.open_cwd",

    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",

    -- directory path
    ["<Leader>yc"] = function()
      vim.fn.setreg("+", converter.handle_filepath()) -- write to clippoard
    end,
    -- { desc = "[c]urrent", noremap = true, silent = true },

    -- full_path (incl. filename + extension)
    ["<leader>yC"] = function()
      -- local filepath = vim.fn.expand("%")
      -- filepath = converter.handle_filepath(filepath)
      -- vim.fn.setreg("+", filepath) -- write to clippoard
      vim.fn.setreg("+", converter.handle_filepath()) -- write to clippoard
    end,
    -- desc = "[c]urrent",
    -- noremap = true,
    -- silent = true,

    ["<Leader>f/"] = "<CMD>Oil<Tab>",
  },
}

---@param opts? any
M.setup = function(opts)
  opts = vim.tbl_deep_extend("force", module_opts, opts or {})
  require("oil").setup(opts)
  return M
end

M.keys = function()
  map("n", "<Leader>e", "<cmd>Oil<CR>", { desc = "Oily" })
  map("n", "<C-w>E", "<cmd>lua =require('oil').open_float()<CR>", { silent = true, desc = "oil" })
  -- map("n", "<Leader>fz", ":Oil ", { desc = "<cmd>Oil" })

  return M
end

return M
