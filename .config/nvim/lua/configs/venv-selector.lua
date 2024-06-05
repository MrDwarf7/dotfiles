return {
	"linux-cultist/venv-selector.nvim",
	branch = "regexp",
	lazy = true,
	event = "InsertEnter",
	config = function()
		require("venv-selector").setup({
			name = { ".venv", ".venv/", "$HOME/.config/.pyenv/versions/3.12.1/bin/python3" },
			pdm_path = "pdm",
		})

		local opts = { silent = true, nowait = true }
		vim.api.nvim_create_autocmd("BufReadPost", {
			desc = "Auto select virtualenv Nvim open",
			pattern = "*",
			callback = function()
				vim.keymap.set("n", "<Leader>fv", "<cmd>VenvSelect<CR>", opts)
				vim.keymap.set("n", "<Leader>fz", "<cmd>VenvSelectCached<CR>", opts)
				local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ".venv")
				if venv ~= "" then
					require("venv-selector").retrieve_from_cache()
				end
			end,
			once = true,
		})
	end,
}
