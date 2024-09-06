return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons", lazy = false },
	priority = 1000,
	keys = {
		{ "<C-w><Leader>", "<cmd>lua =require('oil').open_float()<CR>", silent = true, desc = "oil" },
	},
	opts = {
		columns = {
			"icon", -- default
			-- "permissions",
			-- "size",
			-- "mtime",
		},
		default_file_explorer = true,
		skip_confirm_for_simple_edits = true, -- default: false
		win_options = {
			wrap = false,
			signcolumn = "yes:2",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			conceallevel = 3, -- May want to change this to 0
			concealcursor = "nvic",
		},
		keymaps = {
			["g?"] = "actions.show_help",

			["<CR>"] = "actions.select",
			["<C-]>"] = "actions.select_vsplit",
			["<C-[>"] = "actions.select_split",

			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",

			["@"] = "actions.open_cwd",

			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},
		view_options = {
			show_hidden = true,
		},
	},
}
