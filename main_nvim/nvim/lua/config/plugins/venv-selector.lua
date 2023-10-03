return {
"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
	config = function()
      require("venv-selector").setup({
			name = {"venv", "env", ".venv", ".env"},
  })
	end,
	event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	-- Keys defined in mappings for now
	--
	--[[ keys = {{ ]]
	--[[ 	"<leader>fv", "<cmd>:VenvSelect<CR>", ]]
	--[[ 	desc = "Venv Select", ]]
	--[[]]
	--[[ 	"<leader>lv", "<cmd>:VenvSelectCached<CR>", ]]
	--[[ 	desc = "Venv Select Cached", ]]
	--[[ }} ]]
}
