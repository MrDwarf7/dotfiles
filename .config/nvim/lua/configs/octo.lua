return {
	"pwntester/octo.nvim",
	-- lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		-- OR 'ibhagwan/fzf-lua',
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<Leader>gho",
			":Octo ",
			desc = "Octo",
		},
	},

	opts = {
		suppress_missing_scope = {
			projects_v2 = true,
		},
	},
}
