--[[ vim.api.nvim_create_autocmd({"FileType"}, { ]]
--[[   pattern = "TelescopePrompt", ]]
--[[   command = "setlocal nocursorline" ]]
--[[ }) ]]

local M = {
	'nvim-telescope/telescope.nvim',
	lazy = false,
	dependencies = {
		{ 'nvim-lua/popup.nvim' },
		{ 'nvim-lua/plenary.nvim' },
		{ 'cljoly/telescope-repo.nvim' },
		{ 'nvim-telescope/telescope-dap.nvim' },
		--[[ { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, ]]
		{ 'nvim-telescope/telescope-fzy-native.nvim' },
		{ 'nvim-telescope/telescope-live-grep-args.nvim' },
	},
}

function M.config()
	local actions = require('telescope.actions')
	local trouble = require('trouble.providers.telescope')
	local telescope = require('telescope')
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
			-- prompt_prefix = "λ -> ",
			prompt_prefix = '   ',
			selection_caret = '|> ',
			winblend = 0,
			border = {},
			borderchars = {
				prompt = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
				-- preview = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
				-- results = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
				-- prompt = {" ", " ", " ", " ", " ", " ", " ", " "},
				preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
				results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
			},
			--[[ path_display = { "smart" }, ]]
			set_env = { ['COLORTERM'] = 'truecolor' },
			mappings = {
				i = {
					['<C-k>'] = actions.move_selection_previous,
					['<C-j>'] = actions.move_selection_next,
					['<C-p>'] = actions.move_selection_previous,
					['<C-n>'] = actions.move_selection_next,
					['<c-t>'] = trouble.open_with_trouble,
					--[[ ["<esc>"] = actions.close, ]]
					['<C-q>'] = actions.close,
					['<c-d>'] = actions.delete_buffer,
				},
				n = {
					['q'] = actions.close,
					['<C-q>'] = actions.close,
					['<esc>'] = actions.close,
					['<C-k>'] = actions.move_selection_previous,
					['<C-j>'] = actions.move_selection_next,
					['<C-p>'] = actions.move_selection_previous,
					['<C-n>'] = actions.move_selection_next,
					['<c-d>'] = actions.delete_buffer,
				},
			},
		},
	})

	M.extensions = {
		fzy = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	}

	telescope.load_extension('repo')
	telescope.load_extension('neoclip')
	telescope.load_extension('notify')
	telescope.load_extension('dap')
	--[[ telescope.load_extension('fzf') ]]
	telescope.load_extension('fzy_native')
	telescope.load_extension('live_grep_args')

	M.previewers = require('telescope.previewers')
	M.builtin = require('telescope.builtin')
	M.conf = require('telescope.config')
	M.delta = M.previewers.new_termopen_previewer({
		get_command = function(entry)
			-- this is for status
			-- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
			-- just do an if and return a different command
			if entry.status == ' D' then
				return
			end

			if entry.status == '??' then
				return { 'bat', '--style=plain', '--pager', 'less -R', entry.value }
			end

			return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value }
		end,
	})
end

function M.my_git_commits(opts)
	opts = opts or {}
	opts.previewer = delta

	M.builtin.git_commits(opts)
end

function M.my_git_bcommits(opts)
	opts = opts or {}
	opts.previewer = delta

	M.builtin.git_bcommits(opts)
end

function M.my_git_status(opts)
	opts = opts or {}
	opts.git_icons = {
		added = '',
		changed = '',
		copied = 'C',
		renamed = '',
		unmerged = '',
		untracked = '',
		deleted = '✖',
	}
	opts.previewer = delta

	M.builtin.git_status(opts)
end

function M.my_note(opts)
	M.builtin.live_grep({ prompt_title = ' Note ', cwd = '~/Notes' })
end

function M.project_files()
	local opts = {} -- define here if you want to define something
	local ok = pcall(require('telescope.builtin').git_files, opts)
	if not ok then
		require('telescope.builtin').find_files(opts)
	end
end

function M.my_buffers(opts)
	M.builtin.buffers({
		layout_strategy = 'vertical',
		ignore_current_buffer = true,
		sort_mru = true,
	})
end

function M.my_recents(opts)
	local opts = {} -- define here if you want to define something
	--[[ local ok = pcall(require'telescope.builtin'.git_files, opts) ]]
	local ok = pcall(require('telescope.builtin').oldfiles, opts)
	if not ok then
		require('telescope.builtin').oldfiles(opts)
	end
end

return M
