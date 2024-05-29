--

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
-- local previewer = require("telescope.previewers")
local trouble_prov = require("trouble.providers.telescope")
local trouble = require("trouble")

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	lazy = false,
	-- event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },

		{
			"nvim-telescope/telescope-fzy-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "AckslD/nvim-neoclip.lua" }, -- Telescope
		{ "nvim-telescope/telescope-live-grep-args.nvim" }, -- Telescope
		{ "cljoly/telescope-repo.nvim" }, -- Telescope
	},

	opts = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
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
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			prompt_prefix = "   ",
			selection_caret = "|> ",
			set_env = { ["COLORTERM"] = "truecolor" },
			winblend = 12,
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,

					["<C-p>"] = actions.move_selection_previous,
					["<C-n>"] = actions.move_selection_next,

					["<C-t>"] = trouble_prov.open_with_trouble,
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
			},
		},
		-------------------------------------------------
	},

	config = function(opts)
		local map = vim.keymap.set
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		require("telescope").load_extension("fzy_native")
		require("telescope").load_extension("live_grep_args")
		require("telescope").load_extension("neoclip")
		require("telescope").load_extension("harpoon")
		-- require("telescope").load_extension("lazygit")
		-- require("configs.harpoon")

		require("telescope").setup({

			-- Mappings for telescope, that aren't part of pickers etc.
			map("n", "<Leader>ff", builtin.find_files, { desc = "[f]iles" }),
			map("n", "<Leader>fw", builtin.live_grep, { desc = "[w]ord" }),
			map("n", "<Leader>fb", builtin.buffers, { desc = "[b]uffers" }),
			map("n", "<Leader>fr", builtin.oldfiles, { desc = "[r]ecents" }),
			map("n", "<Leader>fl", builtin.resume, { desc = "[l]ast search" }),
			map("n", "<Leader>fj", builtin.jumplist, { desc = "[j]ump list" }),
			map("n", "<Leader>fV", builtin.vim_options, { desc = "[v]im options browser" }),
			map("n", "<Leader>fg", builtin.git_files, { desc = "[g]it files" }),
			map("n", "<Leader>fm", builtin.marks, { desc = "[m]arks" }),
			map("n", "<Leader>fp", trouble.toggle, { desc = "[p]roblems - trouble" }),
			map("n", "<Leader>fd", builtin.diagnostics, { desc = "[d]iagnostics (same as ld)" }),

			map("n", "<Leader>pr", builtin.reloader, { desc = "[r]eloader" }),

			map("n", "<Leader>ft", ":TodoTelescope<CR>", { desc = "[t]odo's" }),

			map("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer]" }),

			map("n", '<Leader>f"', ":Telescope neoclip<CR>", { noremap = true, silent = true, desc = "Clipboard/Registers" }),

			map({ "n", "v" }, "<Leader>fs", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end, { desc = "[s]earch [w]ord" }),

			map({ "n", "v" }, "<Leader>fS", function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end, { desc = "[S]earch [W]ORD" }),

			-- Telescope extension setups
			-------------------------------------------------

			-- NOTE: Add 'extension' mappings here later

			-- Niche autocmd to fix TS highlinging in preview buffer windows

			autocmd("User", {
				pattern = "TelescopePreviewwerLoaded",
				callback = function()
					vim.opt_local.splitkeep = "cursor"
				end,
				group = augroup("TelescopePluginEvents", {}),
			}),

			autocmd("BufEnter", {
				pattern = "*",
				callback = function()
					-- require("telescope").load_extension("lazygit")
					require("lazygit.utils").project_root_dir()

					-- local lzgt = package.loaded.lazygit or require("lazygit")
					-- local lzgt_tele = require("telescope").load_extension("lazygit")
					map("n", "<leader>gg", require("lazygit").lazygit, { desc = "[l]azy git" })
					map("n", "<leader>gp", require("telescope").load_extension("lazygit").lazygit, { desc = "[p]rojects" })
				end,
			}),
		})
	end,
}
