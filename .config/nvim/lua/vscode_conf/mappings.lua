---@diagnostic disable: redundant-parameter
print("Vscode specific mappings file loads...")
-- local current_line = vim.api.nvim_get_current_line
-- local g = vim.g
-- local map = vim.keymap.set

local silent_opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map("n", "<Leader>e", vim.cmd.Ex, { desc = "[e]xplorer" })

vim.keymap.set("n", "<Esc>", ":nohl<CR>", silent_opts)
vim.keymap.set("v", "<Esc>", "<Esc>:nohl<CR>", silent_opts)
-- vim.keymap.set("i", "jj", "<Esc>", silent_opts)
vim.keymap.set("v", "p", '"_dP', silent_opts)

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", silent_opts) -- Shifting lines down / move
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", silent_opts) -- Shifting lines up / move

vim.keymap.set("v", "<", "<gv", silent_opts)
vim.keymap.set("v", ">", ">gv", silent_opts)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

vim.keymap.set("n", "H", "^", silent_opts) -- Shift + h (Or just H) to jump to start of line
vim.keymap.set("n", "L", "$", silent_opts) -- Shift + l (Or just L) to jump to end of line

vim.keymap.set("v", "H", "^", silent_opts) -- Shift + h (Or just H) to jump to start of line
vim.keymap.set("v", "L", "$", silent_opts) -- Shift + l (Or just L) to jump to end of line

vim.keymap.set("n", "y<S-h>", "y^", silent_opts) -- Same as above for yanking
vim.keymap.set("n", "y<S-l>", "y$", silent_opts) -- Same as above for yanking

vim.keymap.set("n", "d<S-h>", "d^", silent_opts) -- Same as above for yanking
vim.keymap.set("n", "d<S-l>", "d$", silent_opts) -- Same as above for yanking

vim.keymap.set("n", "dd", function() -- Empty/blank lines go into blackhole register
	if #vim.api.nvim_get_current_line() == 0 then
		return '"_dd'
	else
		return "dd"
	end
end, { expr = true })

vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", silent_opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", silent_opts)

vim.keymap.set("n", "<C-h>", ":vertical resize +2<CR>", silent_opts)
vim.keymap.set("n", "<C-l>", ":vertical resize -2<CR>", silent_opts)
vim.keymap.set("n", "<Down>", ":resize -2<CR>", silent_opts)
vim.keymap.set("n", "<Up>", ":resize +2<CR>", silent_opts)

vim.keymap.set("n", "<C-w>e", "<C-w>=", silent_opts, { desc = "[e]qualize" }) -- ctrl + w + = : easier to hit to equalize the width of buffers
vim.keymap.set("n", "<C-w>X", "<cmd>only<CR>", silent_opts, { desc = "buffers - CLOSE all except" })
