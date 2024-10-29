local queries = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/queries"
vim.opt.runtimepath:append(queries)

return {
	{

		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = "VeryLazy",
		build = ":TSUpdate",
		--install = ":TSInstall",
		dependencies = {
			-- "lewis6991/gitsigns.nvim",
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				lazy = true,
				event = "VeryLazy",
				opts = {
					enable_auto_comment = true,
				},
			},
			-- { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true, event = "VeryLazy" },
			{
				"nvim-treesitter/nvim-treesitter-context",
				lazy = true,
				opts = {
					{
						enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
						max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
						min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
						line_numbers = true,
						multiline_threshold = 20, -- Maximum number of lines to show for a single context
						trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
						mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
						-- Separator between context and content. Should be a single character string, like '-'.
						-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
						separator = nil,
						zindex = 20, -- The Z-index of the context window
						on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
					},
				},
			},
			{ "windwp/nvim-ts-autotag", lazy = true },
		},

		keys = {
			{
				"[C",
				function()
					return require("treesitter-context").go_to_context(vim.v.count1)
				end,
				expr = true,
				silent = true,
			},

			{
				"]h",
				function()
					return require("gitsigns").next_hunk()
				end,
				expr = true,
				mode = { "n", "x", "o" },
			},

			{
				"[h",
				function()
					return require("gitsigns").prev_hunk()
				end,
				expr = true,
				mode = { "n", "x", "o" },
			},
		},

		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"c_sharp",
				"cmake",
				"css",
				"embedded_template",
				"gitattributes",
				"gitcommit",
				"git_config",
				"gitignore",
				"git_rebase",
				"go",
				"html",
				"javascript",
				"just",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"meson",
				"python",
				"regex",
				"rust",
				"scss",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			},
			highlight = {
				enable = true,
				-- disable = function(_, buf)
				-- 	if require("util.buffer").is_large(buf) then
				-- 		return true
				-- end
				-- end,
			},
			incremental_selection = {
				enable = false,
			},

			indent = {
				disable = function(lang, buf)
					local indent_disabled = {
						"html",
						"javascript",
						"typescript",
						"css",
						"rust",
					}
					if lang == vim.tbl_keys(indent_disabled) then
						return true
					end
				end,
				enable = true,
			},

			autotag = {
				enable = true,
			},

			sync_install = true,
			auto_install = true,
			-- textobjects = {
			-- 	select = {
			-- 		enable = true,
			-- 		-- Automatically jump forward to textobj, similar to targets.vim
			-- 		lookahead = true,
			--
			-- 		keymaps = {
			-- 			-- You can use the capture groups defined in textobjects.scm
			-- 			["af"] = { expr = true, query = "@function.outer", desc = "Select around function" },
			-- 			["if"] = { expr = true, query = "@function.inner", desc = "Select inner function" },
			-- 			["ac"] = { expr = true, query = "@class.outer", desc = "Select around function" },
			-- 			-- You can optionally set descriptions to the mappings (used in the desc parameter of
			-- 			-- nvim_buf_set_keymap) which plugins like which-key display
			-- 			["ic"] = { expr = true, query = "@class.inner", desc = "Select inner part of a class region" },
			-- 			-- You can also use captures from other query groups like `locals.scm`
			-- 			["as"] = { expr = true, query = "@scope", query_group = "locals", desc = "Select language scope" },
			-- 		},
			-- 		selection_modes = {
			-- 			["@parameter.outer"] = "v", -- charwise
			-- 			["@function.outer"] = "V", -- linewise
			-- 			["@class.outer"] = "<c-v>", -- blockwise
			-- 		},
			-- 		include_surrounding_whitespace = false,
			-- 	},
			-- 	lsp_interop = {
			-- 		enable = true,
			-- 		border = "single",
			-- 		floating_preview_opts = {},
			-- 		peek_definition_code = {
			-- 			["<leader>lE"] = "@function.outer",
			-- 			["<leader>le"] = "@class.outer",
			-- 		},
			-- 	},
			-- },
			-- opts_comment_string = {
			-- 	enable_auto_comment = true,
			-- },
			-- opts_treesitter_context = {
			-- 	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			-- 	max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			-- 	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			-- 	line_numbers = true,
			-- 	multiline_threshold = 20, -- Maximum number of lines to show for a single context
			-- 	trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			-- 	mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- 	-- Separator between context and content. Should be a single character string, like '-'.
			-- 	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			-- 	separator = nil,
			-- 	zindex = 20, -- The Z-index of the context window
			-- 	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			-- },
		},

		config = function(_, opts)
			-- vim.defer_fn(function()
			-- 	vim.defer_fn(function()
			require("nvim-treesitter.configs").setup(opts)
			-- end, 1)

			-- vim.defer_fn(function()
			require("ts_context_commentstring").setup(opts)
			-- end, 2)

			-- vim.defer_fn(function()
			require("treesitter-context").setup(opts)
			-- 	end, 3)
			-- end, 1000)
		end,

		-- 	require("nvim-treesitter").setup(opts.opts_treesitter)
		--
		-- 	require("ts_context_commentstring").setup(opts.opts_comment_string)
		-- 	--
		-- 	-- M.treesitter_main()
		--
		-- 	-- require("ts_context_commentstring").setup({
		-- 	-- 	enable_auto_comment = true,
		-- 	-- })
		--
		-- 	-- M.treesitter_comment_string()
		--
		-- 	require("treesitter-context").setup({
		-- 		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		-- 		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		-- 		min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		-- 		line_numbers = true,
		-- 		multiline_threshold = 20, -- Maximum number of lines to show for a single context
		-- 		trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		-- 		mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
		-- 		-- Separator between context and content. Should be a single character string, like '-'.
		-- 		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		-- 		separator = nil,
		-- 		zindex = 20, -- The Z-index of the context window
		-- 		on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		-- 	})
		-- end,
	},
	-- {
	-- 	"dariuscorvus/tree-sitter-surrealdb.nvim",
	-- 	lazy = true,
	-- 	ft = "sql",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	config = function()
	-- 		require("tree-sitter-surrealdb").setup()
	-- 	end,
	-- },
}
