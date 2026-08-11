---@class config.Keymaps.actions
---@field snippet_forward fun(): boolean? Jumps forward in a snippet if active
---@field snippet_stop fun(): nil Stops the active snippet if any

---@alias config.Keymaps.modes "n" | "i" | "v" | "x" | "s" | "o" | "t" | "c"

---
---@class config.Keymaps
---@field actions config.Keymaps.actions A table of action functions for keybindings
---@field mod? fun(opts?: vim.keymap.set.Opts): vim.keymap.set.Opts A function that returns keymap options with silent and noremap set to true by default
---@field map fun(mode?: config.Keymaps.modes|config.Keymaps.modes[], lhs: string, rhs: string|fun(), opts?: vim.keymap.set.Opts): nil A function that maps keys and stores them in Keymaps.keys
---@field get? fun(mode: config.Keymaps.modes, lhs: string): string|fun()? A function that retrieves a mapped keybinding from Keymaps.keys
---@field load? fun(mappings: table<string, table<string, string|fun()>>): nil A function that loads multiple keybindings from a table
---@field keys table<string, table<string, string|fun()>> A table that stores all mapped keybindings by mode and lhs
---@field print? fun(mode: config.Keymaps.modes, lhs: string): nil A function that prints the mapped keybinding for a given mode and lhs

---@type config.Keymaps
local Keymaps = {
  actions = {},
  mod = nil,
  get = nil,
  load = nil,
  keys = {},
  print = nil,
}

Keymaps.actions = {
  snippet_forward = function()
    if vim.snippet.active({ direction = 1 }) then
      vim.schedule(function()
        vim.snippet.jump(1)
      end)
      return true
    end
  end,
  snippet_stop = function()
    if vim.snippet then
      vim.snippet.stop()
    end
  end,
}

--- Default keymap options with silent and noremap settings already applied.
--- Can be used directly as a table or called with a description to create and return a new table.
---@generic T: table
---@generic R: PartiallyApplied<vim.keymap.set.Opts>|vim.keymap.set.Opts
---@param opts? T|vim.keymap.set.Opts
---@return R|PartiallyApplied<T>
function Keymaps.mod(opts)
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

-- we want to wrap the call to 'map'
-- in a Keymaps call that also adds the key
-- to the Keymaps.keys table for reference later

--- Maps a keybinding using vim.keymap.set
--- and also stores it in Keymaps.keys for reference.
---
--- If no mode is provided, defaults to "n" (normal mode).
--- Errors on missing lhs or rhs.
--- If opts are not provided, uses Keymaps.mod() to create default options.
function Keymaps.map(mode, lhs, rhs, opts)
  -- In order to check if 'mode'
  -- is "empty" and default to 'n',
  -- we need to check the lhs and rhs
  -- and ensure they're not either nil or one of
  -- the valid modes (n, i, v, x, s, o, t, c)

  -- NOTE: revise this later
  if
    mode == nil
    or (type(mode) == "string" and mode:match("^[nivxosct]$") == nil)
    or (
      type(mode) == "table"
      and #mode > 0
      and not vim.tbl_contains(mode, "n")
      and not vim.tbl_contains(mode, "i")
      and not vim.tbl_contains(mode, "v")
      and not vim.tbl_contains(mode, "x")
      and not vim.tbl_contains(mode, "s")
      and not vim.tbl_contains(mode, "o")
      and not vim.tbl_contains(mode, "t")
      and not vim.tbl_contains(mode, "c")
    )
  then
    -- default to normal mode
    mode = "n"
  end
  local output = require("utils.output")

  lhs = lhs or output.error("Keymaps.map: lhs is required")
  rhs = rhs or output.error("Keymaps.map: rhs is required")
  opts = opts or Keymaps.mod()

  -- store the keymap in Keymaps.keys
  if type(mode) == "string" then
    mode = { mode }
  elseif type(mode) ~= "table" then
    output.error("Keymaps.map: mode must be a string or table of strings")
  end
  for _, m in ipairs(mode) do
    Keymaps.keys[m] = Keymaps.keys[m] or {}
    Keymaps.keys[m][lhs] = rhs
  end

  -- call the original map function
  vim.keymap.set(mode, lhs, rhs, opts)
end

function Keymaps.get(mode, lhs)
  if Keymaps.keys[mode] and Keymaps.keys[mode][lhs] then
    return Keymaps.keys[mode][lhs]
  end
  return nil
end

function Keymaps.load(mappings)
  for mode, binds in pairs(mappings) do
    for lhs, rhs in pairs(binds) do
      Keymaps.map(mode, lhs, rhs)
    end
  end
end

function Keymaps.print(mode, lhs)
  -- handle case where only lhs is provided
  if mode:match("^%<Leader%>") then
    lhs = mode
    mode = "n"
  end

  -- handle different mode inputs (or lack thereof)
  if not mode:match("^[nivxosct]$") then
    lhs = lhs or mode
    mode = "n"
  end

  -- attempt to get the mapping via custom Keymaps builtin
  local mapped = Keymaps.get(mode, lhs)
  if mapped then
    print(string.format("Keymaps[%s][%s] = %s", mode, lhs, vim.inspect(mapped)))
  else
    print(string.format("Keymaps[%s][%s] is not mapped", mode, lhs))
  end

  if vim.tbl_isempty(Keymaps.keys) then
    print("Keymaps.keys is empty")
  end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- assign alias for partial fn application
local silent_opts = Keymaps.mod()
local map = Keymaps.map or vim.keymap.set

-- clear highlighting
map({ "i", "n", "s" }, "<ESC>", function()
  vim.cmd("noh")
  Keymaps.actions.snippet_stop()
  ---@diagnostic disable-next-line: redundant-return-value
  return "<ESC>"
end, { expr = true, desc = "Escape and clear hlsearch" })

map(
  "n",
  "<Leader>th",
  "<CMD>nohlsearch<BAR>diffupdate<BAR>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)
map("n", "<Leader>nm", "<CMD>messages<CR>", { desc = "Messages" })

map("n", "<Leader>pu", "<CMD>lua vim.pack.update()<CR>", { desc = "Messages" })

-- escape on kj/jk
map("i", "jk", "<Esc>", silent_opts)
map("i", "kj", "<Esc>", silent_opts)
-- map("i", "kk", "<Esc>", silent_opts)

-- -------------------- goofy ahh line/yank binds

map("n", "H", "^", silent_opts) -- Shift + h (Or just H) to jump to start of line
map("n", "L", "$", silent_opts) -- Shift + l (Or just L) to jump to end of line

map("v", "H", "^", silent_opts) -- Shift + h (Or just H) to jump to start of line
map("v", "L", "$", silent_opts) -- Shift + l (Or just L) to jump to end of line

map("n", "y<S-h>", "y^", silent_opts) -- Same as above for yanking
map("n", "y<S-l>", "y$", silent_opts) -- Same as above for yanking

map("n", "d<S-h>", "d^", silent_opts) -- Same as above for yanking
map("n", "d<S-l>", "d$", silent_opts) -- Same as above for yanking

-- map({ "n", "v" }, "yf", "ggVGy", silent_opts("[y]ank [f]ile")) -- Yank entire file
map("n", "ygf", "<CMD>normal! gg<S-v><S-g>y<CR>", silent_opts("[y]ank [f]ile")) -- Yank entire file
map("n", "ygF", "<CMD>normal! gg<S-v><S-g>y<CR><CMD>normal! G<CR>", silent_opts("[y]ank [F]ile (bottom)")) -- Yank entire file and end at the bottom of file

-- FIX: [feedkeys] : This isn't properly set up lol...
-- We _want_ to be able to set a temp. mark and do our usual ggVy
-- then return to the initial pos.
-- --
-- Yank entire file, setting a temp-mark to return to original pos
-- map("n", "y'", function()
--   local initial_pos = vim.api.nvim_win_get_cursor(0) -- get initial cursor position
--   local mark_name = "z" -- use a temporary mark (z) to return to original position
--   local mark_pos = vim.api.nvim_buf_get_mark(0, mark_name) -- get current position of mark z
--   vim.api.nvim_feedkeys("m" .. mark_name, "n", false) -- set mark z at current position
--   -- do the yank stuff
--   vim.schedule(function()
--     vim.cmd("normal! gg<S-v><S-g>y") -- yank entire file
--   end)
--   vim.api.nvim_win_set_cursor(0, initial_pos) -- return to initial position
-- end, { silent = false, expr = true, desc = "[y]ank [g]lobal [g]lobal" }) -- Yank entire file and return to original position

map("n", "<C-w>e", "<C-w>=", silent_opts("[e]qualize")) -- ctrl + w + = : easier to hit to equalize the width of buffers

map("v", "p", '"_dP', { noremap = true, silent = true })

map("n", "dd", function() -- Empty/blank lines go into blackhole register
  if #vim.api.nvim_get_current_line() == 0 then
    ---@diagnostic disable-next-line: redundant-return-value
    return '"_dd'
  else
    ---@diagnostic disable-next-line: redundant-return-value
    return "dd"
  end
end, { expr = true })

-- -------------------- goofy ahh line/yank binds

map({ "n", "x" }, "j", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'j' : 'gj'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'k' : 'gk'", { expr = true, silent = true })

-- Searching / searching
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- center on next / prev n/N
map("n", "n", "nzzzv", silent_opts)
map("n", "N", "Nzzzv", silent_opts)

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- location list
map("n", "<Leader>L", function()
  -- require("utils.list").toggle_qf("l")

  require("utils.list").toggle_qf("l")
  -- local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  -- if not success and err then
  -- 	vim.notify(err, vim.log.levels.ERROR)
  -- end
end, { desc = "Location List" })

-- quickfix list
map("n", "<Leader>q", function()
  require("utils.list").toggle_qf("q")
  -- local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  -- if not success and err then
  -- 	vim.notify(err, vim.log.levels.ERROR)
  -- end
end, { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
-- map("n", "<Leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

local toggle_inlay_hints = function()
  if type(vim.lsp.inlay_hint) ~= "nil" then
    if type(vim.lsp.inlay_hint.is_enabled) == "function" then
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end
  end
end
map("n", "<Leader>ti", toggle_inlay_hints, { desc = "[T]oggle [I]nlay hints" })

-- TODO: @move -- likely want to move this later
map("n", "<Leader>lh", vim.diagnostic.open_float, { desc = "LSP Hover" })

-- map("n", "<Leader>lf", function()
--   if package.loaded["conform"] then
--     require("conform").format()
--   elseif package.loaded["conform"] == nil then
--     pcall(require, "conform")
--     vim.lsp.buf.format({ async = true })
--   end
-- end, { desc = "format [lspconfig]" })

-- buffer things
map("n", "<Leader>be", function()
  local bufisvalid = require("utils.buf").is_valid({ bufnr = 0 })
  if bufisvalid then -- all conditions must be true for the buffer to be considered 'valid'
    local uor = (vim.api.nvim_get_option_value("splitright") == true and "right" or "left")
    vim.api.nvim_open_win(0, true, { split = uor, win = 0 })
    local id_or_err = vim.api.nvim_create_buf(true, false) -- integer: Buffer id, or 0 on error :: _Create_ the new buffer
    if id_or_err == 0 then
      require("utils.output").error("Failed to create new buffer")
      return
    end
    vim.api.nvim_win_set_buf(0, id_or_err) -- actually set the buffer in the current window
    return
  end
  return require("utils.output").error("Current buffer is not valid for splitting")
end, silent_opts("[e]new"))

map("n", "<Leader>bn", "<CMD>bnext<CR>", silent_opts("[n]ext"))
map("n", "<Leader>bp", "<CMD>bprev<CR>", silent_opts("[p]revious"))

map("n", "]b", "<CMD>bnext<cr>", { desc = "[n]ext" })
map("n", "[b", "<CMD>bprevious<cr>", { desc = "[p]revious" })

map("n", "[[", function()
  -- if the qf list or location list is open, navigate that instead of buffers
  local ql = require("utils").list.find_qf("q")
  dd(ql)
  if #ql > 0 then
    return vim.cmd.cprev()
  end
  local ll = require("utils").list.find_qf("l")
  if #ll > 0 then
    return vim.cmd.lprev()
  end
end, { desc = "Prev item in LIST" })

map("n", "]]", function()
  -- if the qf list or location list is open, navigate that instead of buffers
  local ql = require("utils").list.find_qf("q")
  if #ql > 0 then
    return vim.cmd.cnext()
  end
  local ll = require("utils").list.find_qf("l")
  if #ll > 0 then
    return vim.cmd.lnext()
  end
end, { desc = "Next item in LIST" })

map("n", "<Leader>bd", function()
  require("utils.buf").delete()
end, silent_opts("[b]uf [d]elete"))

map("n", "<Leader>bD", function()
  require("utils.buf").other()
end, silent_opts("[b]uf Wipe"))

-- buffer resizing
map("n", "<Left>", "<CMD>vertical resize +2<CR>", silent_opts)
map("n", "<Right>", "<CMD>vertical resize -2<CR>", silent_opts)

map("n", "<C-h>", "<CMD>vertical resize +2<CR>", silent_opts)
map("n", "<C-l>", "<CMD>vertical resize -2<CR>", silent_opts)
map("n", "<Down>", "<CMD>resize -2<CR>", silent_opts)
map("n", "<Up>", "<CMD>resize +2<CR>", silent_opts)

map("n", "<Leader>W", function()
  require("utils.sudo").sudo_write()
end, silent_opts("[W]rite with sudo"))

-- TODO: @plugin -- turn this on _inside_ the plugin
--
-- map("n", "<Leader>go", function()
--   vim.cmd([[ :Octo ]])
-- end, silent_opts("[G]ithub [O]cto"))

map("n", "<Leader>pl", "<CMD>Lazy<CR>", silent_opts("Lazy"))

-- TODO: We could also write some small helper function
-- for something like:
-- yi
-- and
-- ya
--
-- And we search the current line/surroundings for each of the pairable items and yank the text in between them.
-- mini.nvim / mini.ai (MiniQuotes and MiniSurround) has current line => search outwards way of doing this.

map("n", "YY", "va{Vy", silent_opts("Yank Block {}"))
map("n", "Yy", "vi{Vy", silent_opts("Yank Block {}"))

map("n", "<leader>tw", function()
  if vim.wo.wrap then
    vim.wo.wrap = false
    require("utils.output").info("Wrap disabled")
  else
    vim.wo.wrap = true
    require("utils.output").info("Wrap enabled")
  end
end, silent_opts("[t]oggle [w]rap on"))

map({ "v" }, "<Leader>=", function()
  -- TODO: it's... kinda wonky
  require("utils.align_by").align_selection_by_char()
end, silent_opts("Align by char"))

local cs = require("utils.comment_swap")
map({ "n", "v" }, "<Leader>tk", function()
  cs.handle_comment_swap({
    direction = "above",
    move_cursor = true,
  })
end, { desc = "Swap comment state of current line and ABOVE" })

map({ "n", "v" }, "<Leader>tj", function()
  cs.handle_comment_swap({
    direction = "below",
    move_cursor = true,
  })
end, { desc = "Swap comment state of current line and BELOW" })

-- local insert = require("utils.insert")
-- insert.setup(Keymaps)
require("utils.insert").setup(Keymaps)

----------------------------------------------------------------------------------------------------------------------------------------------------------------

setmetatable(Keymaps, {
  __index = function(table, key)
    return rawget(table, key) or vim.keymap.set
  end,

  __call = function(_, ...)
    return Keymaps.map(...)
  end,

  __tostring = function()
    return "config.Keymaps: " .. vim.inspect(Keymaps.keys)
  end,

  __type = function()
    return "config.Keymaps"
  end,

  ---@param ... vim.keymap.set.Opts
  __add = function(...)
    Keymaps.load(...)
  end,
})

---@return config.Keymaps
return Keymaps
