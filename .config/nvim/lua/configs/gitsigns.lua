local feedkeys = vim.api.nvim_feedkeys
return {
	"lewis6991/gitsigns.nvim",
	lazy = true,
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	keys = {
		{
			"<Leader>hp",
			function()
				require("gitsigns").preview_hunk()
			end,
			desc = "[p]review hunk",
		},

		{
			"<Leader>hs",
			function()
				require("gitsigns").stage_hunk()
			end,
			desc = "[s]tage hunk",
		},

		{
			--
			"<Leader>hr",
			function()
				require("gitsigns").reset_hunk()
			end,
			desc = "[r]eset hunk",
		},

		{
			"<Leader>hR",
			function()
				require("gitsigns").reset_buffer()
			end,
			desc = "[R]eset buffer",
		},

		{
			"<Leader>hS",
			function()
				require("gitsigns").stage_buffer()
			end,
			desc = "[S]tage buffer",
		},

		{
			"<Leader>hu",
			function()
				require("gitsigns").undo_stage_hunk()
			end,
			desc = "[u]ndo stage",
		},

		{
			"<Leader>hb",
			function()
				require("gitsigns").blame_line({ full = true })
			end,
			desc = "[b]lame line",
		},

		{
			"<Leader>hT",
			function()
				require("gitsigns").toggle_current_line_blame()
			end,
			desc = "[T]oggle deleted",
		},
		{
			"<Leader>ht",
			function()
				require("gitsigns").toggle_deleted()
			end,
			desc = "[t]oggle blame",
		},
		{
			"<Leader>hd",
			function()
				require("gitsigns").diffthis()
			end,
			desc = "[d]iff this",
		},

		{
			"<Leader>hD",
			function()
				require("gitsigns").diffthis("main")
			end,
			desc = "[D]iff main",
		},

		{
			"[c",
			function()
				require("gitsigns").prev_hunk()
				vim.schedule(function()
					feedkeys("zz", "n", false)
				end)
			end,
			desc = "[p]revious hunk",
		},

		{
			"]c",
			function()
				require("gitsigns").next_hunk()
				vim.schedule(function()
					feedkeys("zz", "n", false)
				end)
			end,
			desc = "[n]ext hunk",
		},

		{
			"[h",
			function()
				require("gitsigns").prev_hunk()
				vim.schedule(function()
					feedkeys("zz", "n", false)
				end)
			end,
			desc = "[p]revious hunk",
		},

		{
			"]h",
			function()
				require("gitsigns").next_hunk()
				vim.schedule(function()
					feedkeys("zz", "n", false)
				end)
			end,
			desc = "[n]ext hunk",
		},
	},

	opts = {
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
			local gs = require("gitsigns")
			map("o", "ih", gs.select_hunk, { desc = "select hunk" })
			map("x", "ih", gs.select_hunk, { desc = "select hunk" })
		end,
	},
}
