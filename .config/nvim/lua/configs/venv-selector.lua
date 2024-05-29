-- 	config = function()
-- 		require("configs.venv-selector")
-- 	end,
-- },
--

return {

	"linux-cultist/venv-selector.nvim",
	event = "LspAttach",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-telescope/telescope.nvim",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local autocmd = vim.api.nvim_create_autocmd
		local map = vim.keymap.set
		local fn = vim.fn
		local opts = { silent = true, nowait = true }

		require("venv-selector").setup({
			name = { ".venv", ".venv/", "$HOME/.config/.pyenv/versions/3.12.1/bin/python3" },
			pdm_path = "pdm",
		})

		autocmd("BufReadPost", {
			desc = "Auto select virtualenv Nvim open",
			pattern = "*",
			callback = function()
				map("n", "<Leader>fv", "<cmd>VenvSelect<CR>", opts)
				map("n", "<Leader>fz", "<cmd>VenvSelectCached<CR>", opts)
				local venv = fn.findfile("pyproject.toml", fn.getcwd() .. ".venv")
				if venv ~= "" then
					require("venv-selector").retrieve_from_cache()
				end
			end,
			once = true,
		})
	end,
}
