require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		changedelete = { text = "~" },
		change = { text = "│" },
		delete = { text = "󰍵" },
		topdelete = { text = "‾" },
		untracked = { text = "│" },
	},
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' (default) | 'overlay' | 'right_align'
		delay = 750,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = "<author> - <summary> - <author_time:%Y-%m-%d>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)

	on_attach = function()
		local map = vim.keymap.set
		local feedkeys = vim.api.nvim_feedkeys
		-- require("util.gitsigns-mappings").gitsigns_mappings()

		local gs = package.loaded.gitsigns

		map("n", "[c", function()
			gs.prev_hunk()
			vim.schedule(function()
				feedkeys("zz", "n", false)
			end)
		end, { desc = "[p]revious hunk" })

		map("n", "]c", function()
			gs.next_hunk()
			vim.schedule(function()
				feedkeys("zz", "n", false)
			end)
		end, { desc = "[n]ext hunk" })

		map("n", "<Leader>hp", gs.preview_hunk, { desc = "[p]review hunk" })

		map("n", "<Leader>hs", gs.stage_hunk, { desc = "[s]tage hunk" })
		map("n", "<Leader>hr", gs.reset_hunk, { desc = "[r]eset hunk" })
		map("n", "<Leader>hR", gs.reset_buffer, { desc = "[R]eset buffer" })

		map("n", "<Leader>hS", gs.stage_buffer, { desc = "[S]tage buffer" })
		map("n", "<Leader>hu", gs.undo_stage_hunk, { desc = "[u]ndo stage" })

		map("n", "<Leader>hb", function()
			gs.blame_line({ full = true })
		end, { desc = "[b]lame line" })

		map("n", "<Leader>hT", gs.toggle_current_line_blame, { desc = "[T]oggle deleted" })
		map("n", "<Leader>ht", gs.toggle_deleted, { desc = "[t]oggle blame" })
		map("n", "<Leader>hd", gs.diffthis, { desc = "[d]iff this" })

		map("n", "<Leader>hD", function()
			gs.diffthis("main")
		end, { desc = "[D]iff main" })

		map("o", "ih", gs.select_hunk, { desc = "select hunk" })
		map("x", "ih", gs.select_hunk, { desc = "select hunk" })
	end,
})
