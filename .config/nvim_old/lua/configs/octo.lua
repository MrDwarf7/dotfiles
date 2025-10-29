return {
	"pwntester/octo.nvim",
	-- lazy = false,
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		{ "nvim-telescope/telescope.nvim", lazy = true },
		-- OR 'ibhagwan/fzf-lua',
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	keys = {
		{
			"<Leader>O",
			"<cmd>Octo<CR>",
			desc = "Octo",
		},

		{
			"<Leader>gO",
			"<cmd>Octo<CR>",
			desc = "Octo",
		},
	},

	opts = {
		enable_builtin = true,
		suppress_missing_scope = {
			projects_v2 = true,
		},
	},
}
