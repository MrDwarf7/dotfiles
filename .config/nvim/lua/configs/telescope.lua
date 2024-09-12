return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	-- lazy = false,
	-- event = "UIEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		{
			"nvim-telescope/telescope-fzy-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"AckslD/nvim-neoclip.lua",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},

	keys = {
		{
			"<Leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "[f]iles",
		},

		{
			"<Leader>fw",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "[w]ord",
		},

		{
			"<Leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "[b]uffers",
		},

		{
			"<Leader>fr",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "[r]ecents",
		},

		{
			"<Leader>fl",
			function()
				require("telescope.builtin").resume()
			end,
			desc = "[l]ast search",
		},

		{
			"<Leader>fj",
			function()
				require("telescope.builtin").jumplist()
			end,
			desc = "[j]ump list",
		},

		{
			"<Leader>fV",
			function()
				require("telescope.builtin").vim_options()
			end,
			desc = "[v]im options browser",
		},

		{
			"<Leader>fg",
			function()
				require("telescope.builtin").git_files()
			end,
			desc = "[g]it files",
		},

		{
			"<Leader>fm",
			function()
				require("telescope.builtin").marks()
			end,
			desc = "[m]arks",
		},

		{
			"<Leader>fp",
			function()
				require("trouble").toggle()
			end,
			desc = "[p]roblems - trouble",
		},

		{
			"<Leader>fd",
			function()
				require("telescope.builtin").diagnostics()
			end,
			desc = "[d]iagnostics (same as ld)",
		},

		{
			"<Leader>pr",
			function()
				require("telescope.builtin").reloader()
			end,
			desc = "[r]eloader",
		},

		{ "<Leader>ft", ":TodoTelescope<CR>", desc = "[t]odo's" },

		{
			"<leader>/",
			function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
			desc = "[/] Fuzzily search in current buffer]",
		},

		{ '<Leader>f"', ":Telescope neoclip<CR>", noremap = true, silent = true, desc = "Clipboard/Registers" },

		{
			"<Leader>fs",
			function()
				local word = vim.fn.expand("<cword>")
				require("telescope.builtin").grep_string({ search = word })
			end,
			desc = "[s]earch [w]ord",
			mode = { "n", "v" },
		},

		{
			"<Leader>fS",
			function()
				local word = vim.fn.expand("<cWORD>")
				require("telescope.builtin").grep_string({ search = word })
			end,
			desc = "[S]earch [W]ORD",
			mode = { "n", "v" },
		},
	},

	-- init = function()
	-- 	local my_default_maps = function()
	-- 		return {
	-- 			i = {
	-- 				["<C-k>"] = require("telescope.actions").move_selection_previous,
	-- 				["<C-j>"] = require("telescope.actions").move_selection_next,
	--
	-- 				["<C-p>"] = require("telescope.actions").move_selection_previous,
	-- 				["<C-n>"] = require("telescope.actions").move_selection_next,
	--
	-- 				["<C-t>"] = require("trouble.sources.telescope").open,
	-- 				["<C-q>"] = require("telescope.actions").close,
	-- 				["<C-d>"] = require("telescope.actions").delete_buffer,
	--
	-- 				["<C-s>"] = require("telescope.actions").select_horizontal,
	-- 				["<C-l>"] = require("telescope.actions").select_vertical,
	-- 			},
	-- 			n = {
	-- 				["q"] = require("telescope.actions").close,
	-- 				["<C-q>"] = require("telescope.actions").close,
	-- 				["<esc>"] = require("telescope.actions").close,
	-- 				["<C-k>"] = require("telescope.actions").move_selection_previous,
	-- 				["<C-j>"] = require("telescope.actions").move_selection_next,
	-- 				["<C-p>"] = require("telescope.actions").move_selection_previous,
	-- 				["<C-n>"] = require("telescope.actions").move_selection_next,
	-- 				["<C-d>"] = require("telescope.actions").delete_buffer,
	--
	-- 				["<C-s>"] = require("telescope.actions").select_horizontal,
	-- 				["<C-l>"] = require("telescope.actions").select_vertical,
	-- 			},
	-- 		}
	-- 	end
	-- end,

	opts = function()
		local previewers = require("telescope.previewers")
		return {
			vimgrep_arguments = {
				"rg",
				"--vimgrep",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--no-ignore",
				"--hidden",
			},
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "bottom",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
					-- preview_width = 0.55,
					-- results_width = 0.8,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			border = {},
			color_devicons = true,
			file_ignore_patterns = { "node_modules", ".venv", "venv", "deps", "incremental", "build" },
			file_previewer = previewers.vim_buffer_cat.new,
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			prompt_prefix = "   ",
			selection_caret = "|> ",
			set_env = { ["COLORTERM"] = "truecolor" },
			winblend = 12,

			mappings = function()
				local actions = require("telescope.actions")
				return {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,

						["<C-p>"] = actions.move_selection_previous,
						["<C-n>"] = actions.move_selection_next,

						["<C-t>"] = require("trouble.sources.telescope").open,
						["<C-q>"] = actions.close,
						["<C-d>"] = actions.delete_buffer,

						["<C-s>"] = actions.select_horizontal,
						["<C-l>"] = actions.select_vertical,
					},
					n = {
						["q"] = actions.close,
						["<C-q>"] = actions.close,
						["<esc>"] = actions.close,
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,
						["<C-n>"] = actions.move_selection_next,
						["<C-d>"] = actions.delete_buffer,

						["<C-s>"] = actions.select_horizontal,
						["<C-l>"] = actions.select_vertical,
					},
				}
			end,
		}
	end,

	config = function(_, opts)
		local telescope = require("telescope")
		telescope.load_extension("fzy_native")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("neoclip")
		telescope.load_extension("harpoon")
		return opts
	end,
}
