return {
	"NeogitOrg/neogit",
	lazy = true,
	-- event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true }, -- required
		{ "sindrets/diffview.nvim", lazy = true }, -- optional - Diff integration

		-- Only one of these is needed.
		{ "nvim-telescope/telescope.nvim", lazy = true }, -- optional
		{ "ibhagwan/fzf-lua", lazy = true }, -- optional
		{ "echasnovski/mini.pick", lazy = true }, -- optional
	},
	keys = {
		{
			"<Leader>gg",
			function()
				return require("neogit").open({ kind = "vsplit" })
			end,

			desc = "[g]it",
		},

		{
			"<Leader>gf",
			function()
				return require("neogit").open({ "fetch" })
			end,

			desc = "fetch",
		},
		{
			"<Leader>gF",
			function()
				return require("neogit").open({ "fetch", "--all" })
			end,

			desc = "fetch --all",
		},

		{
			"<Leader>gp",
			function()
				return require("neogit").open({ "pull" })
			end,

			desc = "pull",
		},
		{
			"<Leader>gP",
			function()
				return require("neogit").open({ "push" })
			end,

			desc = "push",
		},

		{
			"<Leader>gl",
			function()
				return require("neogit").open({ kind = "vsplit" })
			end,
			desc = "log",
		},

		{
			"<Leader>gb",
			function()
				return require("neogit").open({ "branch" })
			end,
			desc = "branch",
		},

		{
			"<Leader>gm",
			function()
				return require("neogit").merge()
			end,

			desc = "mergetool",
		},
	},

	config = function()
		require("neogit").setup({
			console_timeout = 2000,
			auto_show_console = false,
			graph_style = "unicode",
			use_default_keymaps = false,
			merge_editor = {
				kind = "tab",
			},

			telescope_sorter = require("telescope.sorters").get_fzy_sorter,
			disable_relative_line_numbers = true,

			signs = {
				hunk = { "", "" }, -- [ first is icon nextg to the hunk header label, I assume the second one is the changes?? ]
				item = { "", "" }, --		[ first is item closed, second one is item open ]
				section = { "-", "" }, --		[ first is speceal stuff (like stashes/recent commits),  second one is the header icon next to unstages changes etc. ]
			},

			integrations = {
				fzf_lua = true,
				mini_pick = true,
				telescope = true,
			},

			mappings = {
				commit_editor = {
					["q"] = "Close",
					["<m-p>"] = "PrevMessage",
					["<m-n>"] = "NextMessage",
					["<m-r>"] = "ResetMessage",
					["<C-c><C-c>"] = "Submit",
					["<C-c><C-k>"] = "Abort",
				},
				commit_editor_I = {
					["<C-c><C-c>"] = "Submit",
					["<C-c><C-k>"] = "Abort",
				},

				rebase_editor = {
					["p"] = "Pick",
					["r"] = "Reword",
					["e"] = "Edit",
					["s"] = "Squash",
					["f"] = "Fixup",
					["x"] = "Execute",
					["d"] = "Drop",
					["b"] = "Break",
					["q"] = "Close",
					["<CR>"] = "OpenCommit",
					["gk"] = "MoveUp",
					["gj"] = "MoveDown",
					["<C-c><C-c>"] = "Submit",
					["<C-c><C-k>"] = "Abort",
					["[c"] = "OpenOrScrollUp",
					["]c"] = "OpenOrScrollDown",
				},
				rebase_editor_I = {
					["<C-c><C-c>"] = "Submit",
					["<C-c><C-k>"] = "Abort",
				},

				finder = {
					["<CR>"] = "Select",
					["<C-c>"] = "Close",
					["<ESC>"] = "Close",
					["<C-n>"] = "Next",
					["<C-p>"] = "Previous",
					["<down>"] = "Next",
					["<up>"] = "Previous",
					["<tab>"] = "MultiselectToggleNext",
					["<s-tab>"] = "MultiselectTogglePrevious",
				},

				popup = {
					["?"] = "HelpPopup",
					["A"] = "CherryPickPopup",
					["B"] = "BisectPopup",
					["b"] = "BranchPopup",
					["c"] = "CommitPopup",
					["d"] = "DiffPopup",
					["f"] = "FetchPopup",
					["i"] = "IgnorePopup",
					["l"] = "LogPopup",
					["m"] = "MergePopup",
					["M"] = "RemotePopup",
					["p"] = "PullPopup",
					["P"] = "PushPopup",
					["r"] = "RebasePopup",
					["t"] = "TagPopup",
					["v"] = "RevertPopup",
					["w"] = "WorktreePopup",
					["X"] = "ResetPopup",
					["Z"] = "StashPopup",
				},

				status = {
					["q"] = "Close",
					["I"] = "InitRepo",
					["1"] = "Depth1",
					["2"] = "Depth2",
					["3"] = "Depth3",
					["4"] = "Depth4",
					["<TAB>"] = "Toggle",
					["-"] = "Toggle",
					["x"] = "Discard",
					["s"] = "Stage",
					["S"] = "StageUnstaged",
					["<C-a>"] = "StageAll",
					["u"] = "Unstage",
					["U"] = "UnstageStaged",
					["y"] = "ShowRefs",
					["$"] = "CommandHistory",
					-- [""] = "Console",
					["Y"] = "YankSelected",
					["<C-r>"] = "RefreshBuffer",
					["<CR>"] = "GoToFile",
					["<C-v>"] = "VSplitOpen",
					["<C-x>"] = "SplitOpen",
					["<C-t>"] = "TabOpen",
					["<"] = "GoToPreviousHunkHeader",
					[">"] = "GoToNextHunkHeader",
					["[c"] = "OpenOrScrollUp",
					["]c"] = "OpenOrScrollDown",
				},
			},
		})
	end,
}
