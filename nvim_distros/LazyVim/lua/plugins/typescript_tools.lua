return {
	{

		"pmizio/typescript-tools.nvim",
		ft = {
			"css",
			"html",
			"javascript",
			-- "lua",
			-- "markdown",
			"scss",
			"txt",
			"vim",
			"yaml",
			"json",
			"typescript",
			"typescriptreact",
			"javascriptreact",
			-- "norg",
			-- "org",
			"pandoc",
			"markdown",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},

	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		event = "VeryLazy",
		ft = {
			"css",
			"html",
			"javascript",
			"lua",
			"markdown",
			"scss",
			"txt",
			"vim",
			"yaml",
			"json",
			"typescript",
			"typescriptreact",
			"javascriptreact",
			"norg",
			"org",
			"pandoc",
			"markdown",
		},
		opts = {
			user_default_options = {
				tailwind = "both",
				css = true,
				css_fn = true,
				names = false,
			},
		},
	},
}
