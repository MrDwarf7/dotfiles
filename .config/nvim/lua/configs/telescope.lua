---@diagnostic disable: unused-function, unused-local
return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = {
			{ "ThePrimeagen/git-worktree.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
			{ "AckslD/nvim-neoclip.lua" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "cljoly/telescope-repo.nvim" },
			{ "nvim-telescope/telescope-dap.nvim" },
			{ "ThePrimeagen/harpoon" },
		},

		config = function()
			-- require("telescope").load_extension("harpoon")
			-- require("telescope").load_extension("git_worktree")
			-- require("telescope").load_extension("fzy_native")
			-- require("telescope").load_extension("live_grep_args")
			-- require("telescope").load_extension("neoclip")
			-- require("telescope").load_extension("notify")

			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			local trouble = require("trouble.providers.telescope")

			-- require("telescope").load_extension "file_browser"

			local extensions = {
				"harpoon",
				"git_worktree",
				"fzy_native",
				"live_grep_args",
				"neoclip",
				"notify",
			}

			local ext_setup = function(_, extenstions)
				for _, ext in ipairs(extensions) do
					return telescope.load_extenstion(ext)
				end
			end

			telescope.setup({

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
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_ignore_patterns = { "node_modules" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					prompt_prefix = "   ",
					selection_caret = "|> ",
					winblend = 0,
					border = {},
					set_env = { ["COLORTERM"] = "truecolor" },
					color_devicons = true,
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-n>"] = actions.move_selection_next,
							["<c-t>"] = trouble.open_with_trouble,
							["<C-q>"] = actions.close,
							["<C-d>"] = require("telescope.actions").delete_buffer,
						},
						n = {
							["q"] = actions.close,
							["<C-q>"] = actions.close,
							["<esc>"] = actions.close,
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-n>"] = actions.move_selection_next,
							["<C-d>"] = require("telescope.actions").delete_buffer,
						},
					},
				},
				-------------------------------------------------
			})

			vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "[f]iles" })
			vim.keymap.set("n", "<Leader>fw", builtin.live_grep, { desc = "[w]ord" })
			vim.keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "[b]uffers" })
			vim.keymap.set("n", "<Leader>fr", builtin.oldfiles, { desc = "[r]ecents" })
			vim.keymap.set("n", "<Leader>fl", builtin.resume, { desc = "[l]ast search" })
			vim.keymap.set("n", "<Leader>f'", builtin.marks, { desc = "[']marks" })
			vim.keymap.set("n", "<Leader>fj", builtin.jumplist, { desc = "[j]ump list" })
			vim.keymap.set("n", "<Leader>fp", builtin.diagnostics, { desc = "[p]roblems (telescope)" })
			vim.keymap.set("n", "<Leader>fV", builtin.vim_options, { desc = "[v]im options browser" })

			vim.keymap.set("n", "<Leader>ft", ":TodoTelescope<CR>", { desc = "[t]odo's" })

			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer]" })

			vim.keymap.set(
				"n",
				'<Leader>f"',
				":Telescope neoclip<CR>",
				{ noremap = true, silent = true, desc = "Clipboard/Registers" }
			)

			vim.keymap.set({ "n", "v" }, "<Leader>fs", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end, { desc = "[s]earch [w]ord" })

			vim.keymap.set({ "n", "v" }, "<Leader>fS", function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end, { desc = "[S]earch [W]ORD" })
		end,
	},
}
