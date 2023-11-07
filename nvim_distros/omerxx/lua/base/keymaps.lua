vim.keymap.set("n", "<Esc>", ":nohl<CR>", { noremap = false, silent = true })
vim.keymap.set("v", "<Esc>", "<Esc>:nohl<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })

-- twilight
--


vim.api.nvim_set_keymap("n", "tw", ":Twilight<CR>", { noremap = false })
-- buffers
vim.api.nvim_set_keymap("n", "<Tab>", ":bprev<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "S-Tab", ":bnext<CR>", { noremap = false, silent = true })

-- vim.api.nvim_set_keymap("n", "<leader>e", ":Explore<CR>", { noremap = false, silent = true })

vim.api.nvim_set_keymap("n", "<leader>bn", ":bnext<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bp", ":bprev<CR>", { noremap = false, silent = true })

vim.api.nvim_set_keymap("n", "th", ":bfirst<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "tl", ":blast<CR>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<leader>x", ":bdelete<CR>", { noremap = false, silent = true })
-- files
vim.api.nvim_set_keymap("n", "qa", ":qa!<CR>", { noremap = false })
--vim.api.nvim_set_keymap("n", "WW", ":w!<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = false })

-- Macroing easier use of h/H and l/L to home/end keys
vim.keymap.set("n", "H", "^", { noremap = false, silent = true })      -- Shift + h (Or just H) to jump to start of line
vim.keymap.set("n", "L", "$", { noremap = false, silent = true })      -- Shift + l (Or just L) to jump to end of line

vim.keymap.set("v", "H", "^", { noremap = false, silent = true })      -- Shift + h (Or just H) to jump to start of line
vim.keymap.set("v", "L", "$", { noremap = false, silent = true })      -- Shift + l (Or just L) to jump to end of line

vim.keymap.set("n", "y<S-h>", "y^", { noremap = true, silent = true }) -- Same as above for yanking
vim.keymap.set("n", "y<S-l>", "y$", { noremap = true, silent = true }) -- Same as above for yanking

vim.keymap.set("n", "d<S-h>", "d^", { noremap = true, silent = true }) -- Same as above for yanking
vim.keymap.set("n", "d<S-l>", "d$", { noremap = true, silent = true }) -- Same as above for yanking


-- vim.keymap.set("n", "<C-d>,", "<C-d>zz", { noremap = false, silent = true }) -- These feel really bad on this config version and not sure why, very laggy
-- vim.keymap.set("n", "<C-u>,", "<C-u>zz", { noremap = false, silent = true }) -- These feel really bad on this config version and not sure why, very laggy

vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap("n", "<leader>tT", ":TransparentToggle<CR>", { noremap = true })

-- splits
vim.api.nvim_set_keymap("n", "<C-W>,", ":vertical resize -10<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-W>.", ":vertical resize +10<CR>", { noremap = true })

vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Up>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', ':resize +2<CR>', { noremap = true, silent = true })


vim.keymap.set("n", "<C-h>,", "<C-w>h", { noremap = false, silent = true })
vim.keymap.set("n", "<C-j>,", "<C-w>j", { noremap = false, silent = true })
vim.keymap.set("n", "<C-k>,", "<C-w>k", { noremap = false, silent = true })
vim.keymap.set("n", "<C-l>,", "<C-w>l", { noremap = false, silent = true })


--vim.keymap.set('n', '<space><space>', "<cmd>set nohlsearch<CR>")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>ft", ":TodoTelescope<CR>", { noremap = true })
-- From the 'misc' file (top level one)

-- Options through Telescope
vim.api.nvim_set_keymap(
	"n",
	"<Leader><tab>",
	"<Cmd>lua require('telescope.builtin').commands()<CR>",
	{ noremap = false }
)


vim.keymap.set('n', '<leader>pl', ':Lazy<CR>', { noremap = false, silent = true, desc = 'Lazy Plugins' })
vim.keymap.set('n', '<leader>pm', ':Mason<CR>', { noremap = false, silent = true, desc = 'Mason Manager' })

vim.keymap.set(
	'n',
	'<leader>pU',
	":lua require('lazy').update()<CR>",
	{ noremap = true, silent = true, desc = 'Lazy Update' }
)
vim.keymap.set(
	'n',
	'<leader>pS',
	":lua require('lazy').sync()<CR>",
	{ noremap = true, silent = true, desc = 'Lazy Update' }
)



-- Fterm
--[[ vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('FTerm').toggle()<CR>", { noremap = true }) ]]
--[[ vim.api.nvim_set_keymap("t", "<leader>tt", '<C-\\><C-n>:lua require("FTerm").toggle()<CR>', { noremap = true }) ]]

-- Noice
vim.api.nvim_set_keymap("n", "<leader>nn", ":NoiceDismiss<CR>", { noremap = true })

vim.keymap.set("n", "<leader>ee", "<cmd>GoIfErr<cr>", { silent = true, noremap = true })

-- Git
vim.api.nvim_set_keymap("n", "<leader>gc", ':Git commit -m "', { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push -u origin HEAD<CR>", { noremap = false })

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua require('config.toggleterm')<CR>",
	{ noremap = true, silent = true, desc = "LazyGit" })


return M
