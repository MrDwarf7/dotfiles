-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---@diagnostic disable: redundant-parameter
local map = vim.keymap.set
local silent_opts = { noremap = true, silent = true }

-- local function rm_def(mode, key, opts)
-- 	vim.keymap.del(mode, key, opts)
-- end
-- rm_def("n", "<Leader>c", {})

--map("n", "<Leader><Left>", vim.cmd.Ex, { desc = "netrw" })
map("n", "<Leader>e", "<cmd>Oil<CR>", { desc = "Oily" })

-- map("n", "<Leader>E", function()
-- 	if not pcall(require, "mini.files") then
-- 		vim.cmd("lua require'mini.files'.open()")
-- 		-- require("mini.files").open()
-- 	else
-- 		vim.cmd("lua require'mini.files'.open()")
-- 	end
-- end, { desc = "mini files [E]xplorer" })

map("n", "<Esc>", "<cmd>nohl<CR><Esc>", silent_opts)
map("v", "<Esc>", "<Esc>:nohl<CR>", silent_opts)
map("i", "jj", "<Esc>", silent_opts)
map("i", "jk", "<Esc>", silent_opts)
map("i", "kj", "<Esc>", silent_opts)

map("v", "p", '"_dP', silent_opts)

-- Handles saving via Ctrl + s in normal, visual and insert mode
map("n", "<C-s>", ":wa<CR>", silent_opts)

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

map("v", "<C-s>", function()
	vim.api.nvim_buf_call(vim.api.nvim_get_current_buf(), function()
		vim.cmd("wa")
	end)
end, silent_opts, { desc = "save" })

map("i", "<C-s>", function()
	vim.cmd("stopinsert")
	local cur_pos = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_buf_call(vim.api.nvim_get_current_buf(), function()
		vim.cmd("wa")
	end)
	-- pcall because if the cursor is outside the original buffer length it will error
	pcall(vim.api.nvim_win_set_cursor, 0, cur_pos)
end, silent_opts, { desc = "save" })

map("v", "<C-j>", ":m '>+1<CR>gv=gv", silent_opts) -- Shifting lines down / move
map("v", "<C-k>", ":m '<-2<CR>gv=gv", silent_opts) -- Shifting lines up / move

map("v", "<", "<gv", silent_opts)
map("v", ">", ">gv", silent_opts)

-- map("n", "<Leader>te", "<cmd>tabnext<CR>", silent_opts, { desc = "Next Tab" })
-- map("n", "<Leader>tq", "<cmd>tabprevious<CR>", silent_opts, { desc = "Previous Tab" })

-- formatting / lsp
map({ "n", "v" }, "<leader>lf", function()
	LazyVim.format({ force = true })
end, { desc = "[f]ormat" })

-- toggle options
map("n", "<Leader>t]", "<cmd>tabnext<CR>", silent_opts, { desc = "Next Tab" })
map("n", "<Leader>t[", "<cmd>tabprevious<CR>", silent_opts, { desc = "Previous Tab" })

LazyVim.toggle.map("<leader>tf", LazyVim.toggle.format(), { desc = "Toggle formatting" })
LazyVim.toggle.map("<leader>tF", LazyVim.toggle.format(true))
LazyVim.toggle.map("<leader>ts", LazyVim.toggle("spell", { name = "Spelling" }))
LazyVim.toggle.map("<leader>tw", LazyVim.toggle("wrap", { desc = "Wrap" }))
LazyVim.toggle.map("<leader>tL", LazyVim.toggle("relativenumber", { name = "Relative Number" }))
LazyVim.toggle.map("<leader>td", LazyVim.toggle.diagnostics)
LazyVim.toggle.map(
	"<leader>tc",
	LazyVim.toggle("conceallevel", { values = { 0, vim.o.conceallevel > 0 and vim.o.conceallevel or 2 } })
)
LazyVim.toggle.map("<leader>tT", LazyVim.toggle.treesitter, { desc = "Toggle Treesitter Highlight" })

if vim.lsp.inlay_hint then
	LazyVim.toggle.map("<leader>ti", LazyVim.toggle.inlay_hints)
end

-- Remap for dealing with word wrap
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- same as above but if mvoement greater than 5 then add to jump list

-- map({ "n", "x" }, "j", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'j' : 'gj'", { expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'k' : 'gk'", { expr = true, silent = true })

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

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

map("n", "<Leader>pl", ":Lazy<CR>", silent_opts, { desc = "[l]azy" })
map("n", "<Leader>pm", ":Mason<CR>", silent_opts, { desc = "[m]ason" })

map("n", "dd", function() -- Empty/blank lines go into blackhole register
	local current_line = vim.api.nvim_get_current_line
	if #current_line() == 0 then
		return '"_dd'
	else
		return "dd"
	end
end, { expr = true })

map("n", "<Left>", ":vertical resize +2<CR>", silent_opts)
map("n", "<Right>", ":vertical resize -2<CR>", silent_opts)

map("n", "<C-h>", ":vertical resize +2<CR>", silent_opts)
map("n", "<C-l>", ":vertical resize -2<CR>", silent_opts)
map("n", "<Down>", ":resize -2<CR>", silent_opts)
map("n", "<Up>", ":resize +2<CR>", silent_opts)

map("n", "<C-w>e", "<C-w>=", silent_opts, { desc = "[e]qualize" }) -- ctrl + w + = : easier to hit to equalize the width of buffers
map("n", "<C-w>X", "<cmd>only<CR>", silent_opts, { desc = "buffers - CLOSE all except" })

map("n", "]b", "<cmd>bnext<cr>", { desc = "[n]ext" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "[p]revious" })

map("n", "<Leader>bN", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<Leader>bn", ":bnext<CR>", silent_opts, { desc = "[n]ext" })
map("n", "<Leader>bp", ":bprev<CR>", silent_opts, { desc = "[p]revious" })

map("n", "<Leader>b]", ":bnext<CR>", silent_opts, { desc = "[n]ext" })
map("n", "<Leader>b[", ":bprev<CR>", silent_opts, { desc = "[p]revious" })

map("n", "<leader>bd", LazyVim.ui.bufremove, { desc = "Delete Buffer" })

-- map("n", "<Leader>x", ":bdelete<CR>", silent_opts, { desc = "[X]close" })

map("n", "[f", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]f", vim.cmd.cnext, { desc = "Next Quickfix" })

-- map("n", "<Leader>?", ":vsplit<CR>:terminal<CR>A", silent_opts, { desc = "Inbuilt Term" }) -- Temp for the time being until lazygit // fugitive or something

map("n", "<Leader>t'", ":Telescope<CR>", silent_opts, { desc = "Generic Telescope call" })
map("n", '<Leader>"', ":Telescope neoclip<CR>", silent_opts, { desc = "Clipboard/Registers" })

---------- These should end up getting overwritten anyway, or some at least

local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-------- maybe these work lol

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

----------------- WILL NEED TO CHANGE ---- GIT / fugitive
-- lazygit
map("n", "<leader>go", function()
	LazyVim.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })

map("n", "<leader>gO", function()
	LazyVim.lazygit()
end, { desc = "Lazygit (cwd)" })

-- map("n", "<leader>gb", LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })
-- map("n", "<leader>gB", LazyVim.lazygit.browse, { desc = "Git Browse" })

map("n", "<leader>gH", function()
	local git_path = vim.api.nvim_buf_get_name(0)
	LazyVim.lazygit({ args = { "-f", vim.trim(git_path) } })
end, { desc = "Lazygit Current File History" })
map("n", "<leader>gl", function()
	LazyVim.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
end, { desc = "Lazygit Log" })
map("n", "<leader>gL", function()
	LazyVim.lazygit({ args = { "log" } })
end, { desc = "Lazygit Log (cwd)" })

-- LazyVim Changelog
map("n", "<leader>pL", function()
	LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })

-- floating terminal
local lazyterm = function()
	LazyVim.terminal(nil, { cwd = LazyVim.root() })
end

map("n", "<leader>T/", lazyterm, { desc = "Terminal (Root Dir)" })

map("n", "<leader>T.", function()
	LazyVim.terminal()
end, { desc = "Terminal (cwd)" })

map("n", "<c-/>", lazyterm, { desc = "Terminal (Root Dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>x", "<cmd>tabclose<cr>", { desc = "Close Tab" })

map("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
