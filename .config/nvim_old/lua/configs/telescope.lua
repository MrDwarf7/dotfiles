local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local themes = require("telescope.themes")
local telescope_config = require("telescope.config")

local icons = require("util.icons")

local git_icons = {
	added = icons.gitAdd,
	changed = icons.gitChange,
	copied = ">",
	deleted = icons.gitRemove,
	renamed = "➡",
	unmerged = "‡",
	untracked = "?",
}

local extensions = {
	"fzy_native",
	"live_grep_args",
	"neoclip",
	"harpoon",
}

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	lazy = true,
	event = "BufWinEnter", -- as late as possible
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		-- { "folke/trouble.nvim", lazy = true },
		{
			"nvim-telescope/telescope-fzy-native.nvim",
			lazy = true,
			-- event = "VeryLazy",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "AckslD/nvim-neoclip.lua", lazy = true },
		{ "nvim-telescope/telescope-live-grep-args.nvim", lazy = true },
	},

	keys = {
		{
			"<Leader>ff",
			function()
				builtin.find_files(themes.get_ivy({
					{
						follow = true,
						hidden = true,
						no_ignore = true,
						no_ignore_parent = true,
						dependencies = { "fd" },
						previewer = telescope_config,
					},
				}))
			end,
			desc = "[f]iles",
		},

		{
			"<Leader>fw",
			function()
				builtin.live_grep(themes.get_ivy({
					{
						initial_mode = "insert",
						previewer = telescope_config,
						sorting_strategy = "ascending",
						follow = true,
						hidden = true,
						no_ignore = true,
						no_ignore_parent = true,
						dependencies = { "fd" },
					},
				}))
			end,
			desc = "[w]ord",
		},

		{
			"<Leader>fb",
			function()
				return builtin.buffers(themes.get_ivy({
					sort_mru = true,
					sort_lastused = true,
					initial_mode = "normal",
				}))
			end,
			desc = "[b]uffers",
		},

		{
			"<Leader>fr",
			function()
				builtin.oldfiles(themes.get_ivy({
					height = 35,
					sorting_strategy = "ascending",
					sort_mru = false,
					sort_lastused = true,
					initial_mode = "insert",
				}))
			end,
			desc = "[r]ecents",
		},

		{
			"<Leader>fl",
			function()
				builtin.resume()
			end,
			desc = "[l]ast search",
		},

		{
			"<Leader>fj",
			function()
				builtin.jumplist()
			end,
			desc = "[j]ump list",
		},

		{
			"<Leader>fV",
			function()
				builtin.vim_options()
			end,
			desc = "[v]im options browser",
		},

		{
			"<Leader>fg",
			function()
				builtin.git_files(themes.get_ivy({
					{
						initial_mode = "insert",
						previewer = telescope_config,
						sorting_strategy = "ascending",
						follow = true,
						hidden = true,
						no_ignore = true,
						no_ignore_parent = true,
						dependencies = { "fd" },
					},
				}))
			end,
			desc = "[g]it files",
		},

		{
			"<Leader>fm",
			function()
				builtin.marks()
			end,
			desc = "[m]arks",
		},

		{
			"<Leader>fd",
			function()
				builtin.fd()
			end,
			desc = "FzfLua(Oil)",
		},

		{
			"<Leader>fD",
			function()
				builtin.diagnostics()
			end,
			desc = "[D]iagnostics (same as ld)",
		},

		{
			"<Leader>pr",
			function()
				builtin.reloader()
			end,
			desc = "[r]eloader",
		},

		{ "<Leader>ft", ":TodoTelescope<CR>", desc = "[t]odo's" },

		{
			"<leader>/",
			function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				builtin.current_buffer_fuzzy_find(themes.get_dropdown({
					initial_mode = "insert",
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
				builtin.grep_string({ search = word })
			end,
			desc = "[s]earch [w]ord",
			mode = { "n", "v" },
		},

		{
			"<Leader>fS",
			function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end,
			desc = "[S]earch [W]ORD",
			mode = { "n", "v" },
		},
	},

	opts = {
		defaults = {
			sorting_strategy = "descending", -- Default
			layout_strategy = "horizontal",
			layout_config = {
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,

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
			},
			winblend = 12,
			prompt_prefix = "   ",
			initial_mode = "insert",
			border = true,
			path_display = {
				hidden = false,
			},
			-- default_mappings = {}, -- Not recommended to touch

			vimgrep_arguments = {
				"rg",
				-- "--vimgrep",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				-- All abovve are default
				"--no-ignore",
				"--no-ignore-files",
				"--hidden",
			},
			file_sorter = require("telescope.sorters").get_fzy_sorter,
			generic_sorter = require("telescope.sorters").get_fzy_sorter,

			-- Escapes for the \. are important, it's a table of REGEX
			-- Cannot ignore "node_modules" because this same pattern is used for LSP servers :/
			--"\\.venv", "venv",
			file_ignore_patterns = { "deps", "incremental", "\\.git", "\\.hg", "\\.svn" },
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

			hl_result_eol = true,
			multi_icon = "",

			previewer = {
				file_previewer = themes.get_ivy({
					initial_mode = "insert",
					-- winblend = 10,
					previewer = true,
				}),
			},

			--- NEW:

			color_devicons = true,
			git_icons = git_icons,

			selection_caret = "|> ",
			set_env = { ["COLORTERM"] = "truecolor" },
		},
		--#endregion defaults

		--#region pickers
		pickers = {
			find_files = {
				file_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--no-ignore", "--no-ignore-files" },
			},
		},
		--#endregion pickers

		--#region extensions
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},

		--#endregion extensions
	},

	config = function(_, opts)
		actions = actions or require("telescope.actions")

		-- opts.mappings = {
		local t = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-n>"] = actions.move_selection_next,

				-- ["<C-t>"] = require("trouble.sources.telescope").open,
				["<C-t>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<C-x>"] = actions.delete_buffer,
				--["<C-d>"] = actions.delete_buffer,
				["<c-c>"] = function(prompt_bufnr)
					local action_set = require("telescope.actions.set")
					return action_set.close(prompt_bufnr)
				end,

				["<C-[>"] = actions.select_horizontal,
				["<C-]>"] = actions.select_vertical,

				-- ["<C-h>"] = actions.cycle_previewers_next,
				-- ["<C-l>"] = actions.cycle_previewers_prev,
			},

			n = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-n>"] = actions.move_selection_next,

				-- ["<C-t>"] = trouble_ts.open,
				["<C-t>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<C-x>"] = actions.delete_buffer,
				["d"] = actions.delete_buffer,

				["<esc>"] = function(prompt_bufnr)
					local action_set = require("telescope.actions.set")
					return action_set.close(prompt_bufnr)
				end,

				["<C-[>"] = actions.select_horizontal,
				["<C-]>"] = actions.select_vertical,

				-- ["<C-h>"] = actions.cycle_previewers_next,
				-- ["<C-l>"] = actions.cycle_previewers_prev,
			},
		}

		opts.mappings = {}
		table.insert(opts.mappings, t)

		telescope.setup(opts)

		-- Checks to see if a plugin is loaded
		-- if it is then we call the function
		--
		-- Generally used to call a plugin or submodule owned by the parent
		---@param plugin string: The name of the plugin
		---@param fn function: The function to call
		---@return nil
		local function if_loaded(plugin, fn)
			if package.loaded[plugin] then
				fn()
			end
		end

		if_loaded("telescope", function()
			for _, ext in ipairs(extensions) do
				telescope.load_extension(ext)
			end
		end)

		-- telescope.extensions
	end,
}
