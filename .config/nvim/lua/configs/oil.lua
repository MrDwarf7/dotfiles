require("oil").setup({
	default_file_explorer = true,

	win_options = {
		wrap = false,
		signcolumn = "no",
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

	-- is_hidden_file = function(name, bufnr)
	-- 	return vim.startswith(name, ".node_m")
	-- end,
	--
	-- is_always_hidden = function(name, bufnr)
	-- 	return true
	-- end,
})
