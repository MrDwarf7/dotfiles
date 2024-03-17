local autocmd = vim.api.nvim_create_autocmd

local map = vim.keymap.set

autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		-- require("telescope").load_extension("lazygit")
		require("lazygit.utils").project_root_dir()

		-- local lzgt = package.loaded.lazygit or require("lazygit")
		-- local lzgt_tele = require("telescope").load_extension("lazygit")
		map("n", "<leader>gg", require("lazygit").lazygit, { desc = "[l]azy git" })
		map("n", "<leader>gp", require("telescope").load_extension("lazygit").lazygit, { desc = "[p]rojects" })
	end,
})
