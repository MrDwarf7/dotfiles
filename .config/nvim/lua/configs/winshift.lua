return {
	"sindrets/winshift.nvim",
	event = "BufReadPost",
	keys = {
		{ "<Leader>w", "+[w]inShift", desc = "+[w]inShift", mode = "n" },
		{ "<Leader>ww", ":WinShift<CR>", silent = true, noremap = true },
		{ "<Leader>wh", ":WinShift left<CR>", silent = true, noremap = true },
		{ "<Leader>wj", ":WinShift down<CR>", silent = true, noremap = true },
		{ "<Leader>wk", ":WinShift up<CR>", silent = true, noremap = true },
		{ "<Leader>wl", ":WinShift right<CR>", silent = true, noremap = true },
		{ "<Leader>wH", ":WinShift far_left<CR>", silent = true, noremap = true },
		{ "<Leader>wJ", ":WinShift far_down<CR>", silent = true, noremap = true },
		{ "<Leader>wK", ":WinShift far_up<CR>", silent = true, noremap = true },
		{ "<Leader>wL", ":WinShift far_right<CR>", silent = true, noremap = true },
	},
	opts = {},
}
