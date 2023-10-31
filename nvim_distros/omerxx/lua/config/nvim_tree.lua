local nvim_tree = require("nvim-tree")

local function my_on_attach(bufnr)
	local api = require('nvim-tree.api')
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	-- default mappings
	api.config.mappings.default_on_attach(bufnr)
	-- custom mappings
	vim.keymap.set('n', '.', api.tree.change_root_to_node, opts('cd'))
	vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('vsplit'))
	vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('split'))
	vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('tabnew'))
	vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('preview'))
	vim.keymap.set('n', 'R', api.tree.reload, opts('refresh'))
	vim.keymap.set('n', 'a', api.fs.create, opts('create'))
	vim.keymap.set('n', 'D', api.fs.trash, opts('trash'))
	vim.keymap.set('n', 'r', api.fs.rename, opts('rename'))
	vim.keymap.set('n', '<C-r>', api.fs.rename_basename, opts('full_rename'))
	vim.keymap.set('n', 'x', api.fs.cut, opts('cut'))
	vim.keymap.set('n', 'y', api.fs.copy.filename, opts('copy'))
	vim.keymap.set('n', 'p', api.fs.paste, opts('paste'))
	vim.keymap.set('n', '/', api.live_filter.start, opts('live_filter'))
	vim.keymap.set('n', 'T', api.live_filter.clear, opts('Clean Filter'))
	vim.keymap.set('n', 'z', api.tree.collapse_all, opts('collapse_all'))
	vim.keymap.set('n', 'gyn', api.fs.copy.filename, opts('copy_name'))
	vim.keymap.set('n', 'gyp', api.fs.copy.relative_path, opts('copy_path'))
	vim.keymap.set('n', 'gya', api.fs.copy.absolute_path, opts('copy_absolute_path'))
	vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('dir_up'))
	-- To open and close nodes using l and h respectively
	vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
	vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('close_node'))

	vim.keymap.set('n', '<m>', api.marks.toggle, opts('toggle_mark'))
	vim.keymap.set('n', 'K', api.node.show_info_popup, opts('toggle_file_info'))
	vim.keymap.set('n', '<', api.node.navigate.sibling.first, opts('first_sibling'))
	vim.keymap.set('n', '>', api.node.navigate.sibling.last, opts('last_sibling'))
end

nvim_tree.setup({
	on_attach = my_on_attach,
	update_cwd = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = true,
	git = {
		timeout = 1000,
		ignore = false,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	view = {
		width = 32,
		number = true,
		relativenumber = true,
	},

	renderer = {
		highlight_git = true,
		root_folder_modifier = ':t',
		icons = {
			glyphs = {
				-- 	default = ' ',
				-- 	symlink = '',
				-- 	bookmark = '◉',
				git = {
					unstaged = 'U',
					-- 		staged = '',
					-- 		unmerged = '! ',
					-- 		renamed = '! ',
					deleted = '',
					-- 		untracked = '',
					-- 		ignored = '',
					-- 	},
					-- 	folder = {
					-- 		default = '',
					-- 		open = '',
					-- 		symlink = '',
				},
			},
			show = {
				git = true,
				file = true,
				folder = true,
				folder_arrow = false,
			},
		},
		indent_markers = {
			enable = true,
		},
	},

	diagnostics = {
		enable = true,
		show_on_dirs = false,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	modified = {
		enable = false,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},

	filters = {
		git_ignored = true,
		dotfiles = false,
		git_clean = false,
		no_buffer = false,
		custom = { "node_modules" }, -- add things to NOT show here
		exclude = {},
	},
	ui = {
		confirm = {
			remove = true,
			trash = true,
			default_yes = true,
		},
	},
})

-- Globally accessible binds
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>E', ':NvimTreeFocus<CR>', { silent = true })
-- vim.keymap.set('n', '<leader>E', ':NvimTreeFindFile<CR>.', { silent = true })
