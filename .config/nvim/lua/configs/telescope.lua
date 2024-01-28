---@diagnostic disable: unused-function, unused-local

return {
	'nvim-telescope/telescope.nvim',
	lazy = false,
	dependencies = {
		{ 'ThePrimeagen/git-worktree.nvim' },
		{ 'nvim-telescope/telescope-fzy-native.nvim' },
		{ 'AckslD/nvim-neoclip.lua' },
		{ 'nvim-telescope/telescope-live-grep-args.nvim' },
		{ 'nvim-lua/plenary.nvim' },
		{ 'cljoly/telescope-repo.nvim' },
		{ 'nvim-telescope/telescope-dap.nvim' },
		{ 'ThePrimeagen/harpoon' },
	},

	config = function()
		-- require("telescope").load_extension("harpoon")
		-- require("telescope").load_extension("git_worktree")
		-- require("telescope").load_extension("fzy_native")
		-- require("telescope").load_extension("live_grep_args")
		-- require("telescope").load_extension("neoclip")
		-- require("telescope").load_extension("notify")

		local telescope = require('telescope')
		local builtin = require('telescope.builtin')
		local actions = require('telescope.actions')
		local trouble = require('trouble.providers.telescope')

		local extensions = {
			'harpoon',
			'git_worktree',
			'fzy_native',
			'live_grep_args',
			'neoclip',
			'notify',
		}

		local ext_setup = function(_, extenstions)
			for _, ext in ipairs(extensions) do
				return telescope.load_extenstion(ext)
			end
		end

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					'rg',
					'--color=never',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
					'--smart-case',
				},
				layout_strategy = 'horizontal',
				layout_config = {
					horizontal = {
						prompt_position = 'bottom',
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
				file_ignore_patterns = { 'node_modules' },
				file_previewer = require('telescope.previewers').vim_buffer_cat.new,
				grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
				prompt_prefix = '   ',
				selection_caret = '|> ',
				winblend = 0,
				border = {},
				--borderchars = {
				--prompt = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
				-- preview = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
				-- results = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
				-- prompt = {" ", " ", " ", " ", " ", " ", " ", " "},
				-- preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
				-- results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
				--},
				--[[ path_display = { "smart" }, ]]
				set_env = { ['COLORTERM'] = 'truecolor' },
				color_devicons = true,
				mappings = {
					i = {
						['<C-k>'] = actions.move_selection_previous,
						['<C-j>'] = actions.move_selection_next,
						['<C-p>'] = actions.move_selection_previous,
						['<C-n>'] = actions.move_selection_next,
						['<c-t>'] = trouble.open_with_trouble,
						['<C-q>'] = actions.close,
					},
					n = {
						['q'] = actions.close,
						['<C-q>'] = actions.close,
						['<esc>'] = actions.close,
						['<C-k>'] = actions.move_selection_previous,
						['<C-j>'] = actions.move_selection_next,
						['<C-p>'] = actions.move_selection_previous,
						['<C-n>'] = actions.move_selection_next,
					},
				},
			},
		})

		vim.keymap.set('n', '<Leader>ff', builtin.find_files, { desc = '[F]iles' })
		vim.keymap.set('n', '<Leader>fw', builtin.live_grep, { desc = '[W]ord' })
		vim.keymap.set('n', '<Leader>fb', builtin.buffers, { desc = '[B]uffers' })
		vim.keymap.set('n', '<Leader>fr', builtin.oldfiles, { desc = 'Recents' })
		vim.keymap.set('n', '<Leader>fl', builtin.resume, { desc = '[L]ast search' })
		vim.keymap.set('n', "<Leader>f'", builtin.marks, { desc = '[M]arks' })
		vim.keymap.set('n', '<Leader>fj', builtin.jumplist, { desc = '[J]ump list' })
		vim.keymap.set('n', '<Leader>fd', builtin.diagnostics, { desc = '[D]iagnostics (telescope)' })
		vim.keymap.set('n', '<Leader>fV', builtin.vim_options, { desc = '[V]im options browser' })

		vim.keymap.set('n', '<Leader>ft', ':TodoTelescope<CR>', { desc = "[T]odo's" })

		vim.keymap.set('n', '<Leader>/', function()
			telescope.builtin().current_buffer_fuzzy_find(telescope.themes().get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = '[/] Fuzzily search in current buffer]' })

		vim.keymap.set(
			'n',
			'<Leader>"',
			':Telescope neoclip<CR>',
			{ noremap = true, silent = true, desc = 'Clipboard/Registers' }
		)

		vim.keymap.set({ 'n', 'v' }, '<Leader>fs', function()
			local word = vim.fn.expand('<cword>')
			builtin.grep_string({ search = word })
		end, { desc = '[s]earch [w]ord' })

		vim.keymap.set({ 'n', 'v' }, '<Leader>fS', function()
			local word = vim.fn.expand('<cWORD>')
			builtin.grep_string({ search = word })
		end, { desc = '[S]earch [W]ORD' })
	end,
}
