local icons = require("util.icons")
local actions = require("telescope.actions")
local themes = require("telescope.themes")

local git_icons = {
	added = icons.gitAdd,
	changed = icons.gitChange,
	copied = ">",
	deleted = icons.gitRemove,
	renamed = "➡",
	unmerged = "‡",
	untracked = "?",
}

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

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	lazy = true,
	event = "UIEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- { "folke/trouble.nvim", lazy = true },
		{
			"nvim-telescope/telescope-fzy-native.nvim",
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
				return require("telescope.builtin").find_files(require("telescope.themes").get_ivy({
					initial_mode = "insert",
					-- winblend = 10,
					previewer = true,
				}))
			end,
			desc = "[f]iles",
		},

		{
			"<Leader>fw",
			function()
				return require("telescope.builtin").live_grep(require("telescope.themes").get_ivy({
					initial_mode = "insert",
					previewer = true,
					sorting_strategy = "ascending",
				}))
			end,
			desc = "[w]ord",
		},

		{
			"<Leader>fb",
			function()
				return require("telescope.builtin").buffers(require("telescope.themes").get_ivy({
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
				return require("telescope.builtin").oldfiles(require("telescope.themes").get_ivy({
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
				return require("telescope.builtin").resume()
			end,
			desc = "[l]ast search",
		},

		{
			"<Leader>fj",
			function()
				return require("telescope.builtin").jumplist()
			end,
			desc = "[j]ump list",
		},

		{
			"<Leader>fV",
			function()
				return require("telescope.builtin").vim_options()
			end,
			desc = "[v]im options browser",
		},

		{
			"<Leader>fg",
			function()
				return require("telescope.builtin").git_files()
			end,
			desc = "[g]it files",
		},

		{
			"<Leader>fm",
			function()
				return require("telescope.builtin").marks()
			end,
			desc = "[m]arks",
		},

		{
			"<Leader>fd",
			function()
				return require("telescope.builtin").fd()
			end,
			desc = "FzfLua(Oil)",
		},

		{
			"<Leader>fD",
			function()
				return require("telescope.builtin").diagnostics()
			end,
			desc = "[D]iagnostics (same as ld)",
		},

		{
			"<Leader>pr",
			function()
				return require("telescope.builtin").reloader()
			end,
			desc = "[r]eloader",
		},

		{ "<Leader>ft", ":TodoTelescope<CR>", desc = "[t]odo's" },

		{
			"<leader>/",
			function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				return require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
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
				return require("telescope.builtin").grep_string({ search = word })
			end,
			desc = "[s]earch [w]ord",
			mode = { "n", "v" },
		},

		{
			"<Leader>fS",
			function()
				local word = vim.fn.expand("<cWORD>")
				return require("telescope.builtin").grep_string({ search = word })
			end,
			desc = "[S]earch [W]ORD",
			mode = { "n", "v" },
		},
	},

	opts = {
		defaults = {
			border = true,
			hl_result_eol = true,
			multi_icon = "",

			vimgrep_arguments = {
				"rg",
				"--vimgrep",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				-- "--no-ignore",
				"--hidden",
			},

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
			--- NEW:
			file_sorter = require("telescope.sorters").get_fzy_sorter,

			prompt_prefix = "   ",
			color_devicons = true,
			git_icons = git_icons,
			sorting_strategy = "descending",

			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

			file_ignore_patterns = { "node_modules", ".venv", "venv", "deps", "incremental", ".git", ".hg", ".svn" },

			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,
					["<C-n>"] = actions.move_selection_next,

					-- ["<C-t>"] = require("trouble.sources.telescope").open,
					["<C-t>"] = actions.smart_send_to_qflist + actions.open_qflist,
					["<C-x>"] = actions.delete_buffer,
					--["<C-d>"] = actions.delete_buffer,
					["<Esc>"] = actions.close,

					["<C-[>"] = actions.select_horizontal,
					["<C-]>"] = actions.select_vertical,

					["<C-h>"] = actions.cycle_previewers_next,
					["<C-l>"] = actions.cycle_previewers_prev,
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

					-- ["q"] = actions.close,
					["<Esc>"] = actions.close,

					["<C-[>"] = actions.select_horizontal,
					["<C-]>"] = actions.select_vertical,

					["<C-h>"] = actions.cycle_previewers_next,
					["<C-l>"] = actions.cycle_previewers_prev,
				},
			},

			selection_caret = "|> ",
			set_env = { ["COLORTERM"] = "truecolor" },
			winblend = 12,
		},

		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	},

	config = function(_, opts)
		local extensions = {
			"fzy_native",
			"live_grep_args",
			"neoclip",
			"harpoon",
		}

		if_loaded("telescope", function()
			for _, ext in ipairs(extensions) do
				require("telescope").load_extension(ext)
			end
		end)
		require("telescope").setup(opts)
	end,
}
