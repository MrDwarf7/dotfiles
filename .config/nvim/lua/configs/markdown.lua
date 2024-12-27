return {
	"MeanderingProgrammer/render-markdown.nvim",
	lazy = true,
	ft = { "markdown", "Avante", "help" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		-- "echasnovski/mini.nvim", -- if you use the mini.nvim suite
		-- 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		opts = {
			file_types = { "markdown", "Avante" },
		},

		keys = {
			{
				"<Leader>tm",
				function()
					require("render-markdown").toggle()
				end,
				desc = "Toggle markdown preview",
			},
		},
	},
}
