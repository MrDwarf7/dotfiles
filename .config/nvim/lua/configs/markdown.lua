return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = "markdown",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		-- "echasnovski/mini.nvim", -- if you use the mini.nvim suite
		"nvim-tree/nvim-web-devicons",
	},
	-- dependencies = { 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { ' }, -- if you prefer nvim-web-devicons
	opts = {},
	keys = {
		{
			"<Leader>tm",
			function()
				require("render-markdown").toggle()
			end,
			desc = "Toggle markdown preview",
		},
	},
}
