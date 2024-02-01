return {
	{
		"kdheepak/lazygit.nvim",
		event = { "BufEnter", "BufWinEnter" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},

		keys = {

			vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "[l]azy Git" }),
			vim.keymap.set("n", "<Leader>gp", function()
				local ext = require("telescope").extensions.lazygit()
				vim.keymap.set("n", "<leader>gp", ext.lazygit(), { desc = "[p]rojects" })
			end),
		},

		config = function(_, opts)
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
		lazy = false,
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
		config = function(_, opts)
			require("gitsigns").setup(opts)
			-- function diffThisBranch()
			-- 	local branch = vim.fn.input("Branch: ", "")
			-- 	require "gitsigns".diffthis(branch)
			-- end

			-- Navigation
			-- vim.keymap.set('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
			-- vim.keymap.set('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
			vim.keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<CR>")
			vim.keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<CR>")

			-- Actions
			vim.keymap.set({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
			-- vim.keymap.set("v", "<leader>hs", ":Gitsigns stage_hunk<CR>")
			vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
			-- vim.keymap.set("v", "<leader>hr", ":Gitsigns reset_hunk<CR>")
			vim.keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
			vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
			vim.keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
			vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")

			vim.keymap.set("n", "<leader>hb", function()
				require("gitsigns").blame_line({ full = true })
			end, { desc = "toggle [b]lame" })

			vim.keymap.set("n", "<leader>ht", "<cmd>Gitsigns toggle_current_line_blame<CR>")
			vim.keymap.set("n", "<leader>hT", "<cmd>Gitsigns toggle_deleted<CR>")

			vim.keymap.set("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
			vim.keymap.set("n", "<leader>hD", function()
				require("gitsigns").diffthis("~")
			end, { desc = "[d]iff ~" })

			vim.keymap.set("n", "<leader>hm", function()
				require("gitsigns").diffthis("main")
			end, { desc = "diff [m]ain" })

			-- vim.keymap.set('n', '<leader>hM', diffThisBranch)

			-- Text object
			vim.keymap.set("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
			vim.keymap.set("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
		end,
	},

	{
		"sindrets/diffview.nvim",
		event = "BufEnter",
		keys = {
			vim.keymap.set("n", "<Leader>gd", "+[d]iffview", {}),
			vim.keymap.set("n", "<Leader>gdo", "<cmd>DiffviewOpen<CR>", {}),
			vim.keymap.set("n", "<Leader>gdc", "<cmd>DiffviewClose<CR>", {}),
			vim.keymap.set("n", "<Leader>gdf", "<cmd>DiffviewToggleFiles<CR>", {}),
			vim.keymap.set("n", "<Leader>gdr", "<cmd>DiffviewRefresh<CR>", {}),
		},
		config = function(_, opts)
			require("diffview").setup(_, opts)
		end,
	},

	{
		"tpope/vim-fugitive",
		lazy = false,
	},
}
