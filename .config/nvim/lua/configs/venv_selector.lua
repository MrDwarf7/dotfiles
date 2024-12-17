return {
	"linux-cultist/venv-selector.nvim",
	lazy = false,
	branch = "regexp", -- This is the regexp branch, use this for the new version
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python", --optional
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	keys = {
		{ ",v", "<cmd>VenvSelect<cr>" },
	},
	opts = {},
	-- config = function()
	-- 	require("venv-selector").setup()
	-- end,
}
