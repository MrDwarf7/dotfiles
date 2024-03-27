print("Vscode specific mappings file loads...")
local vscode = require("vscode-neovim")
local current_line = vim.api.nvim_get_current_line
local g = vim.g
local map = vim.keymap.set

local silent_opts = { noremap = true, silent = true }

local loud_opts = { noremap = true, silent = false }

g.mapleader = " "
g.maplocalleader = " "

map("n", "<Esc>", ":nohl<CR>", silent_opts)
map("v", "<Esc>", "<Esc>:nohl<CR>", silent_opts)
map("i", "jj", "<Esc>", silent_opts)
map("v", "p", '"_dP', silent_opts)

map("v", "<C-j>", ":m '>+1<CR>gv=gv", silent_opts) -- Shifting lines down / move
map("v", "<C-k>", ":m '<-2<CR>gv=gv", silent_opts) -- Shifting lines up / move

map("v", "<", "<gv", silent_opts)
map("v", ">", ">gv", silent_opts)

-- Remap for dealing with word wrap
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- same as above but if mvoement greater than 5 then add to jump list

map("n", "j", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'j' : 'gj'", { expr = true })
map("n", "k", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'k' : 'gk'", { expr = true })

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

-- map("n", "<Left>", ":vertical resize +2<CR>", silent_opts)
-- map("n", "<Right>", ":vertical resize -2<CR>", silent_opts)
-- map("n", "<Down>", ":resize -2<CR>", silent_opts)
-- map("n", "<Up>", ":resize +2<CR>", silent_opts)

-- map("n", "<C-w>e", "<C-w>=", silent_opts, { desc = "[e]qualize" }) -- ctrl + w + = : easier to hit to equalize the width of buffers
map("n", "<C-w>X", "<cmd>only<CR>", silent_opts, { desc = "buffers - CLOSE all except" })

map("n", "<Leader>x", ":bdelete<CR>", silent_opts, { desc = "[X]close" })
map("n", "<Leader>?", ":vsplit<CR>:terminal<CR>A", silent_opts, { desc = "Inbuilt Term" }) -- Temp for the time being until lazygit // fugitive or something
map("n", '<Leader>"', ":Telescope neoclip<CR>", silent_opts, { desc = "Clipboard/Registers" })
