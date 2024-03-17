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
		require("util.gitsigns-mappings").gitsigns_mappings()
	end,
})
