local map = vim.keymap.set
local silent_opts = { silent = true, noremap = true }

return {

	"sindrets/winshift.nvim",
	event = "BufReadPost",
	opts = {},

	map("n", "<Leader>w", "+[w]inShift", { desc = "+[w]inShift" }),
	map("n", "<Leader>ww", ":WinShift<CR>", silent_opts),
	map("n", "<Leader>wh", ":WinShift left<CR>", silent_opts),
	map("n", "<Leader>wj", ":WinShift down<CR>", silent_opts),
	map("n", "<Leader>wk", ":WinShift up<CR>", silent_opts),
	map("n", "<Leader>wl", ":WinShift right<CR>", silent_opts),

	map("n", "<Leader>wH", ":WinShift far_left<CR>", silent_opts),
	map("n", "<Leader>wJ", ":WinShift far_down<CR>", silent_opts),
	map("n", "<Leader>wK", ":WinShift far_up<CR>", silent_opts),
	map("n", "<Leader>wL", ":WinShift far_right<CR>", silent_opts),
}
