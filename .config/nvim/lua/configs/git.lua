return {
	{
		"kdheepak/lazygit.nvim",
		event = "BufEnter",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope")
			require("telescope").load_extension("lazygit")
			local autocmd = vim.api.nvim_create_autocmd
			local silent_opts = {
				noremap = true,
				silent = true,
			}

			autocmd("BufEnter", {
				pattern = "*",
				callback = function()
					require("telescope").load_extension("lazygit")
					require("lazygit.utils").project_root_dir()
				end,
			})

			vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", silent_opts, { desc = "[l]azy Git" })
			vim.keymap.set(
				"n",
				"<Leader>gp",
				":lua require('telescope').extensions.lazygit.lazygit()<CR>",
				silent_opts,
				{ desc = "[p]rojects" }
			)
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "InsertEnter",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "󰍵" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "│" },
			},
		},
	},
}
