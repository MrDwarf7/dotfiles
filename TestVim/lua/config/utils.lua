local M = {}

M.load = {}
local keymap = vim.api.nvim_set_keymap

M.load.project_nvim = function()
	require("project_nvim").setup({
		detection_methods = { "pattern" },
		patterns = {
			".git",
			".svn",
			"Makefile",
			"package.json",
			"NAMESPACE",
			"setup.py",
			"venv",
			".venv",
			"virtualenv",
		},
		show_hidden = true,
	})

	keymap("n", "<Leader>fp", "<cmd>Telescope projects<CR>", { noremap = true })
end

M.load.neotree = function()
	require("neo-tree").setup({
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
				end,
				desc = "Explorer NeoTree (root dir)",
			},
			{
				"<leader>fE",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{ "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
			{ "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
		},

		deactivate = function()
			vim.cmd([[Neotree close]])
		end,

		init = function()
			if vim.fn.argc() == 1 then
				---@diagnostic disable-next-line: param-type-mismatch
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,

		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = {
					"node_modules",
				},
				always_show = {
					"AppData",
					".git",
					".gitignore",
					".gitignored",
				},
				never_show = {
					".DS_Store",
					"thumbs.db",
				},
				never_show_by_pattern = {
					"NTUSER.DAT*",
					"ntuser.ini*",
				},
			},
		},
		window = {
			mappings = {
				["<space>"] = "none",
				-- ["<Backspace>"] = "parent_or_close",
				["-"] = "navigate_up",
				["s"] = "open_split",
				["v"] = "open_vsplit",
			},
			fuzzy_finder_mappings = {
				["<C-j>"] = "move_cursor_down",
				["<C-k>"] = "move_cursor_up",
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
		},

		vim.api.nvim_create_autocmd("TermClose", {
			pattern = "*lazygit",
			callback = function()
				if package.loaded["neo-tree.sources.git_status"] then
					require("neo-tree.sources.git_status").refresh()
				end
			end,
		}),
	})

	M.load.winshift = function()
		require("winshift").setup({})
		keymap("n", "<Leader>wm", "<cmd>WinShift<CR>", { noremap = true, silent = true })
	end

	M.load.project_nvim()
	M.load.neotree()
	M.load.winshift()
end

-- END --------------------- GOING TO HAVE TO CHECK THIS OVER NOW THAT I'VE GOT THE CONFIG HERE ------------------------
