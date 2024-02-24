local lspsaga = require("lspsaga")
local cmd = vim.cmd
local map = vim.api.nvim_set_keymap

lspsaga.setup({
	rename = {
		keymaps = {
			quit = { "q", "<esc>" },
			exec = "<CR>",
		},
		action_keys = {
			quit = { "q", "<esc>" },
			exec = "<CR>",
		},
		finder = {
			keys = {
				quit = { "q", "<esc>" },
				vsplit = "v",
				split = "s",
			}
		},
		definition = {
			keys = {
				quit = { "q", "<esc>" },
				vsplit = "v",
				split = "s",
			}
		}

	}
})


local opts = { noremap = true, silent = true }

map("n", "<Leader>lI", "<cmd>Lspsaga incoming_calls<CR>", { desc = "[call] incoming" })
map("n", "<Leader>lO", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "[call] outgoing" })

map("n", "<Leader>la", "<cmd>Lspsaga code_action<CR>", { desc = "SAGA Code [a]ction" })

map("n", "<Leader>ld", "<cmd>Lspsaga peek_definition<CR>", { desc = "[d]efinition" })
map("n", "<Leader>lD", "<cmd>Lspsaga peek_definition ++keep<CR>", { desc = "[d]efinition Keep" })

map("n", "<Leader>li", "<cmd>Lspsaga finder imp<CR>", { desc = "[I]mplementations" })
map("n", "<Leader>lr", "<cmd>Lspsaga finder ref<CR>", { desc = "[r]eferences" })

map("n", "<Leader>lg", "<cmd>Lspsaga hover_doc<CR>", { desc = "lspSaga Hover" })
map("n", "<Leader>lH", "<cmd>Lspsaga hover_doc ++keep<CR>", { desc = "Hover Keep" })

map("n", "<Leader>lw", "<cmd>Lspsaga outline<CR>", { desc = "[outline]" })

-- map("n", "<Leader>lR", "<cmd>Lspsaga rename<CR>", { desc = "SAGA [r]rename" }) -- This conflicts/overrides

map("n", "<Leader>lt", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "[t]ype def" })

map("n", "<A-]>", "<cmd>Lspsaga term_toggle<CR>", { desc = "Toggle terminal" })
map("n", "]l", "<cmd>Lspsaga diagnostic_jump_next", { desc = "[next]" })
map("n", "[l", "<cmd>Lspsaga diagnostic_jump_prev", { desc = "[prev]" })
