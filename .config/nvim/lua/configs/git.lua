return {
	{
		"kdheepak/lazygit.nvim",
		-- lazy = false,
		event = "BufReadPre",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},

		config = function()
			local lzgt = package.loaded.lazygit or require("lazygit")
			local lzgt_tele = require("telescope").load_extension("lazygit")

			vim.keymap.set("n", "<leader>gg", lzgt.lazygit, { desc = "[l]azy git" })
			vim.keymap.set("n", "<leader>gp", lzgt_tele.lazygit, { desc = "[p]rojects" })

			local autocmd = vim.api.nvim_create_autocmd
			autocmd("bufenter", {
				pattern = "*",
				callback = function()
					require("telescope").load_extension("lazygit")
					require("lazygit.utils").project_root_dir()
				end,
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "BufReadPre",
		config = function()
			local feedkeys = vim.api.nvim_feedkeys
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "󰍵" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "│" },
				},
				on_attach = function()
					local gs = package.loaded.gitsigns

					vim.keymap.set("n", "[c", function()
						gs.prev_hunk()
						vim.schedule(function()
							feedkeys("zz", "n", false)
						end)
					end, { desc = "[p]revious hunk" })

					vim.keymap.set("n", "]c", function()
						gs.next_hunk()
						vim.schedule(function()
							feedkeys("zz", "n", false)
						end)
					end, { desc = "[n]ext hunk" })

					vim.keymap.set("n", "<Leader>hp", gs.preview_hunk, { desc = "[p]review hunk" })

					vim.keymap.set("n", "<Leader>hs", gs.stage_hunk, { desc = "[s]tage hunk" })
					vim.keymap.set("n", "<Leader>hr", gs.reset_hunk, { desc = "[r]eset hunk" })
					vim.keymap.set("n", "<Leader>hR", gs.reset_buffer, { desc = "[R]eset buffer" })

					vim.keymap.set("n", "<Leader>hS", gs.stage_buffer, { desc = "[S]tage buffer" })
					vim.keymap.set("n", "<Leader>hu", gs.undo_stage_hunk, { desc = "[u]ndo stage" })

					vim.keymap.set("n", "<Leader>hb", function()
						gs.blame_line({ full = true })
					end, { desc = "[b]lame line" })

					vim.keymap.set("n", "<Leader>ht", gs.toggle_current_line_blame, { desc = "[t]oggle blame" })
					vim.keymap.set("n", "<Leader>hT", gs.toggle_deleted, { desc = "[T]oggle deleted" })
					vim.keymap.set("n", "<Leader>hd", gs.diffthis, { desc = "[d]iff this" })

					vim.keymap.set("n", "<Leader>hD", function()
						gs.diffthis("main")
					end, { desc = "[D]iff main" })

					vim.keymap.set("o", "ih", gs.select_hunk, { desc = "select hunk" })
					vim.keymap.set("x", "ih", gs.select_hunk, { desc = "select hunk" })

					-- vim.keymap.set("n", "<Leader>hD", function ()
					-- gs.diffthis("~")
					-- end)
				end,
			})
		end,
	},

	{
		"sindrets/diffview.nvim",
		event = "BufReadPre",
		config = function()
			require("diffview").setup({
				on_attach = function()
					local df = package.loaded.diffview

					vim.keymap.set("n", "<Leader>gd", "+[d]iffview")
					vim.keymap.set("n", "<Leader>gdo", df.DiffviewOpen)
					vim.keymap.set("n", "<Leader>gdc", df.DiffviewClose)
					vim.keymap.set("n", "<Leader>gdf", df.DiffViewToggleFiles)
					vim.keymap.set("n", "<Leader>gdr", df.DiffviewToggleFiles)
				end,
			})
		end,
	},

	{
		"tpope/vim-fugitive",
		lazy = false,
	},
}
