return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		-- lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"regex",
					"c",
					"rust",
					"python",
					"typescript",
					"tsx",
					"toml",
					"css",
					"html",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"javascript",
					"json",
					"c_sharp",
					"cpp",
				},
				sync_install = false,
				auto_install = true,
				autotag = {
					enable = true,
				},
				highlight = {
					enable = true,
				},
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		lazy = false,
		event = "BufReadPre",
		config = function()
			require("Comment").setup({
				pre_hook = function()
					return vim.bo.commentstring
				end,
			})
		end,
	},
}
