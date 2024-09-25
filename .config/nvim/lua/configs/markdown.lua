return {
	{

		"MeanderingProgrammer/render-markdown.nvim",
		lazy = false,
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			-- "echasnovski/mini.nvim", -- if you use the mini.nvim suite
			-- 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
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
		},
		{
			-- install without yarn or npm
			{
				"iamcco/markdown-preview.nvim",
				cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
				ft = { "markdown" },
				build = function()
					vim.fn["mkdp#util#install"]()
				end,
			},

			-- install with yarn or npm
			{
				"iamcco/markdown-preview.nvim",
				cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
				build = "cd app && bun install",
				init = function()
					vim.g.mkdp_filetypes = { "markdown" }
				end,
				ft = { "markdown" },
			},
		},
	},
}
