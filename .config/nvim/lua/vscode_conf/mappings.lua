print("Vscode specific mappings file loads...")
local silent_opts = { noremap = true, silent = true }

---@diagnostic disable: redundant-parameter
local current_line = vim.api.nvim_get_current_line
local g = vim.g
local map = vim.keymap.set

g.mapleader = " "
g.maplocalleader = " "

map("n", "<Esc>", ":nohl<CR>", silent_opts)
map("v", "<Esc>", "<Esc>:nohl<CR>", silent_opts)

-- Let vscode-vim handle these via actions
-- Are these needed when vscode-vim has them mapped?
-- map("i", "jj", "<Esc>", silent_opts)
-- map("i", "jk", "<Esc>", silent_opts)
-- map("i", "kj", "<Esc>", silent_opts)

map("v", "p", '"_dP', silent_opts)

-- Add undo break-points ---- testing
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- commenting lines above and below
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

map("v", "<C-j>", ":m '>+1<CR>gv=gv", silent_opts) -- Shifting lines down / move
map("v", "<C-k>", ":m '<-2<CR>gv=gv", silent_opts) -- Shifting lines up / move

map("v", "<", "<gv", silent_opts)
map("v", ">", ">gv", silent_opts)

-- Remap for dealing with word wrap
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- same as above but if mvoement greater than 5 then add to jump list

map({ "n", "x" }, "j", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'j' : 'gj'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'k' : 'gk'", { expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map("n", "n", "nzzzv", silent_opts)
map("n", "N", "Nzzzv", silent_opts)

map("n", "H", "^", silent_opts) -- Shift + h (Or just H) to jump to start of line
map("n", "L", "$", silent_opts) -- Shift + l (Or just L) to jump to end of line

map("v", "H", "^", silent_opts) -- Shift + h (Or just H) to jump to start of line
map("v", "L", "$", silent_opts) -- Shift + l (Or just L) to jump to end of line

map("n", "y<S-h>", "y^", silent_opts) -- Same as above for yanking
map("n", "y<S-l>", "y$", silent_opts) -- Same as above for yanking

map("n", "d<S-h>", "d^", silent_opts) -- Same as above for yanking
map("n", "d<S-l>", "d$", silent_opts) -- Same as above for yanking

map("n", "dd", function() -- Empty/blank lines go into blackhole register
	if #current_line() == 0 then
		return '"_dd'
	else
		return "dd"
	end
end, { expr = true })

map("n", "<Left>", ":vertical resize +2<CR>", silent_opts)
map("n", "<Right>", ":vertical resize -2<CR>", silent_opts)

map("n", "<Down>", ":resize -2<CR>", silent_opts)
map("n", "<Up>", ":resize +2<CR>", silent_opts)

-- map("n", "<C-w>e", "<C-w>=", silent_opts, { desc = "[e]qualize" }) -- ctrl + w + = : easier to hit to equalize the width of buffers
-- map("n", "<C-w>X", "<cmd>only<CR>", silent_opts, { desc = "buffers - CLOSE all except" })

map("n", "]b", "<cmd>bnext<cr>", { desc = "[n]ext" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "[p]revious" })

map("n", "[f", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]f", vim.cmd.cnext, { desc = "Next Quickfix" })

---------- These should end up getting overwritten anyway, or some at least

-- local diagnostic_goto = function(next, severity)
-- 	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
-- 	severity = severity and vim.diagnostic.severity[severity] or nil
-- 	return function()
-- 		go({ severity = severity })
-- 	end
-- end
-- map("n", "]d", diagnostic_goto(true)({ desc = "Next Diagnostic" }))
-- map("n", "[d", diagnostic_goto(false)({ desc = "Prev Diagnostic" }))
-- map("n", "]e", diagnostic_goto(true, "ERROR")({ desc = "Next Error" }))
-- map("n", "[e", diagnostic_goto(false, "ERROR")({ desc = "Prev Error" }))
-- map("n", "]w", diagnostic_goto(true, "WARN")({ desc = "Next Warning" }))
-- map("n", "[w", diagnostic_goto(false, "WARN")({ desc = "Prev Warning" }))

-------- maybe these work lol

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
--
-- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
