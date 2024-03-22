print("Vscode specific plugins file loads...")
return {
	{
		"folke/neodev.nvim",
		event = "BufReadPost",
		config = function()
			require("neodev").setup({
				library = {
					plugins = {
						"nvim-dap-ui",
					},
					types = true,
				},
			})
		end,
	}, -- Before lspconfig

	{
		"ggandor/leap.nvim",
		lazy = false,
		dependencies = {
			"tpope/vim-repeat",
		},
		config = function()
			local leap = require("leap")
			pcall(leap.setup({}), "leap")
			pcall(leap.create_default_mappings(), "leap")
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("Comment").setup({
				pre_hook = function()
					return vim.bo.commentstring
				end,
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local map = vim.keymap.set

			require("todo-comments").setup({
				keywords = {
					FIX = { icon = " ", color = "error" },
					TODO = { icon = " ", color = "info" },
					HACK = { icon = ",", color = "warning" },
					WARN = { icon = " ", color = "warning" },
					PERF = { icon = " ", color = "warning" },
					NOTE = { icon = " ", color = "hint" },
				},
				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					pattern = [[\b(KEYWORDS):]],
				},
			})

			map("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			map("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })

			map("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			local map = vim.keymap.set
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
				map("n", "zR", require("ufo").openAllFolds),
				map("n", "zM", require("ufo").closeAllFolds),
			})
		end,
	},
}