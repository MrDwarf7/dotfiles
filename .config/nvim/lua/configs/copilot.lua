return {
	"zbirenbaum/copilot.lua",
	event = "BufReadPost",

	keys = {
		{
			"<Leader>pp",
			"<cmd>Copilot panel<CR>",
			mode = "n",
			{ desc = "copilot [P]" },
		},
	},
	-- map("n", "<Leader>pp", "<cmd>Copilot panel<CR>", { desc = "copilot [P]" }),

	opts = {

		panel = {
			enabled = false, -- Temp disabled to test copilot_cmp
			auto_refresh = false, -- This is the default setting
			keymap = {},
		},
		suggestion = {
			enabled = false, -- Temp disabled to test copilot-cmp
			auto_trigger = true,
			keymap = {
				accept = "<C-l>",
				accept_word = "<A-l>",
				next = "<A-]>",
				prev = "<A-[>",
				dismiss = "<C-c>",
			},
		},

		filetypes = { -- Defaults are all false basically
			cvs = false,
			gitcommit = true,
			gitrebase = true,
			help = false,
			hgcommit = false,
			markdown = true,
			svn = false,
			yaml = true,
			["."] = true,
		},
		copilot_node_command = "node", -- What other ways can it be run??
		server_opts_overrides = {},
	},
}
