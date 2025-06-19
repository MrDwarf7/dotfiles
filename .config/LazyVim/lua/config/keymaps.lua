---@diagnostic disable: redundant-parameter
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local mdel = vim.keymap.del

local aufmt = require("utils.autoformatter")

-- Mimics the equiv. of
-- local silent_opts = { noremap = true, silent = true, desc = desc or "" }
-- making the desc optional in the process,
-- while keeping silent_opts both as a table AND callable as a fn

--- Default keymap options with silent and noremap settings already applied.
--- Can be used directly as a table or called with a description to create and return a new table.
---@generic T: table
---@generic R: PartiallyApplied<vim.keymap.set.Opts>|vim.keymap.set.Opts
---@param opts? T|vim.keymap.set.Opts
---@return R|PartiallyApplied<T>
local mod = function(opts)
  ---@cast opts vim.keymap.set.Opts
  opts = opts or { noremap = true, silent = true, desc = "" }

  local mt = { --[[@as vim.keymap.set.Opts]]
    __call = function(_, desc)
      return { noremap = true, silent = true, desc = desc or "" }
    end,
  }
  setmetatable(opts, mt)
  return opts
end

--- Default keymapping options for noremap & silent
---@type PartiallyApplied<vim.keymap.set.Opts>
local silent_opts = mod()

-- Delete garbage window movement binds
mdel("n", "<C-h>")
mdel("n", "<C-j>")
mdel("n", "<C-k>")
mdel("n", "<C-l>")

-- Delete garbage buffer binds
mdel("n", "<S-h>")
mdel("n", "<S-l>")
mdel("n", "[b")
mdel("n", "]b")
mdel("n", "<Leader>bb") -- Switch to Other Buffer
mdel("n", "<Leader>`") -- Switch to Other Buffer

mdel("n", "<Leader>bl") -- Delete Buffers to the Left
-- mdel("n", "<Leader>bp") -- Toggle pinned buffer
mdel("n", "<Leader>bP") -- Delete non-pinned buffers
mdel("n", "<Leader>br") -- Delete buffers to the Right

-- mdel("n", "<Leader>bd") -- Delete Buffer
-- mdel("n", "<Leader>bD") -- Delete Other Buffers
-- mdel("n", "<Leader>bo") -- Delete Other Buffers

-- Delete garbage menu bind
mdel("n", "<Leader>l")

-- Delete garbage loc list
mdel("n", "<Leader>xl")
----- LSP UNBIND
-- Remove 'format' bind
mdel({ "n", "v" }, "<Leader>cf")
mdel("n", "<Leader>cd")

-- UNBIND inlay hints
-- mdel("n", "<Leader>uh")

-- Remove random garbage quit command
mdel("n", "<Leader>qq")

-- random garbage lazyvim changelog command?????????
mdel("n", "<Leader>L")

mdel("n", "<Leader>fT")
mdel("n", "<Leader>ft")
mdel("n", "<Leader>wd")
mdel("n", "<Leader>wm")
mdel("n", "<Leader>uZ")
mdel("n", "<Leader>uz")

-- unbind snacks
mdel("n", "<Leader>e")
mdel("n", "<Leader>E")
mdel("n", "<Leader>fn")

---
--- Non-basics ---
---

map("i", "jj", "<Esc>", silent_opts)
map("i", "jk", "<Esc>", silent_opts)
map("i", "kj", "<Esc>", silent_opts)
map("i", "kk", "<Esc>", silent_opts)

map("n", "<Leader>pl", "<CMD>Lazy<CR>", silent_opts("[l]azy"))

map("n", "<Leader>pe", "<CMD>LazyExtras<CR>", { desc = "Lazy Extras" })

map("n", "<Leader>pm", "<CMD>Mason<CR>", silent_opts("[m]ason"))
-- { noremap = true, silent = true, desc = "[m]ason" })

map("n", "H", "^", silent_opts) -- Shift + h (Or just H) to jump to start of line
map("n", "L", "$", silent_opts) -- Shift + l (Or just L) to jump to end of line

map("v", "H", "^", silent_opts) -- Shift + h (Or just H) to jump to start of line
map("v", "L", "$", silent_opts) -- Shift + l (Or just L) to jump to end of line

map("n", "y<S-h>", "y^", silent_opts) -- Same as above for yanking
map("n", "y<S-l>", "y$", silent_opts) -- Same as above for yanking

map("n", "d<S-h>", "d^", silent_opts) -- Same as above for yanking
map("n", "d<S-l>", "d$", silent_opts) -- Same as above for yanking

map("n", "<C-w>e", "<C-w>=", silent_opts("[e]qualize")) -- ctrl + w + = : easier to hit to equalize the width of buffers

map("v", "p", '"_dP', { noremap = true, silent = true })

-- stylua: ignore start
if vim.lsp.inlay_hint then require("snacks").toggle.inlay_hints():map("<Leader>ti") end
map("n", "<Leader>lf", function() LazyVim.format({ force = true }) end, { desc = "Format" })
map("n", "<Leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
-- stylua: ignore end

map("n", "]b", "<cmd>bnext<cr>", { desc = "[n]ext" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "[p]revious" })

map("n", "<Leader>bN", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<Leader>bn", ":bnext<CR>", silent_opts("[n]ext"))
map("n", "<Leader>bp", ":bprev<CR>", silent_opts("[p]revious"))

map("n", "<Leader>b]", ":bnext<CR>", silent_opts("[n]ext"))
map("n", "<Leader>b[", ":bprev<CR>", silent_opts("[p]revious"))

map("n", "<Left>", ":vertical resize +2<CR>", silent_opts)
map("n", "<Right>", ":vertical resize -2<CR>", silent_opts)

map("n", "<C-h>", ":vertical resize +2<CR>", silent_opts)
map("n", "<C-l>", ":vertical resize -2<CR>", silent_opts)
map("n", "<Down>", ":resize -2<CR>", silent_opts)
map("n", "<Up>", ":resize +2<CR>", silent_opts)

map("n", "<Leader>e", "<cmd>Oil<CR>", { desc = "Oily" })
-- map("n", "<Leader>bc", function()
--   Snacks.bufdelete()
-- end, silent_opts, { desc = "[X]close" })

-- map("n", "<Leader>x", function()
--   Snacks.bufdelete()
-- end, silent_opts, { desc = "[X]close" })

-- map("n", "<Leader><S-x>", function()
--   Snacks.bufdelete().all(_)
-- end, silent_opts, { desc = "[X]close" })

-- a sort of 'reset' to baseline' function
map({ "n", "v" }, "<Leader>l.", function()
  aufmt:formatters_reset()
  vim.print("Autoformatting has been reset to default settings.")
end, silent_opts("[.]All formatters on"))

map({ "n", "v" }, "<Leader>lx", function()
  aufmt:fmt_quit_global()
end, silent_opts("[x](Global) Quit & No fmt"))

map({ "n", "v" }, "<Leader>lX", function()
  aufmt:fmt_quit_buf()
end, silent_opts("[X](Buf) Quit & No fmt"))

-- Longer maps with function calls --
-- stylua: ignore start
map("n", "<Leader>p<S-l>", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

map("n", "]t", function() require("todo-comments").jump_next() end, silent_opts("Next [t]odo"))
map("n", "[t", function() require("todo-comments").jump_next() end, silent_opts("Next [t]odo"))
map("n", "<Leader>ft", ":lua Snacks.picker.todo_comments()<CR>", silent_opts("[F]ind [T]odo's"))
map('n', "<Leader>ft", ":lua Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME', 'NOTE', 'IMP' } })<CR>", silent_opts("[F]ind [T]odo's" ))

-- stylua: ignore end
