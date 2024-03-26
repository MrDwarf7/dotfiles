local map = vim.keymap.set
local gs = require("gitsigns")
-- No need to ensure_installed the following parsers.
--
-- Neovim 0.9 ships: c, lua, vim & vimdoc parsers
-- Neovim 0.10 ships: bash, c, lua, markdown, markdown_inline, python, vim &
--                    vimdoc parsers

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"c_sharp",
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
		"json",
		"lua",
		"markdown",
		"markdown_inline",
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
		disable = function(_, buf)
			if require("util.buffer").is_large(buf) then
				return true
			end
		end,
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

	sync_install = false,
	auto_install = true,
})

require("ts_context_commentstring").setup({
	enable_auto_comment = true,
})

require("treesitter-context").setup({
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
})

map("n", "[C", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

require("nvim-treesitter.configs").setup({
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = { query = "@function.outer", desc = "Select around function" },
				["if"] = { query = "@function.inner", desc = "Select inner function" },
				["ac"] = { query = "@class.outer", desc = "Select around function" },
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				-- You can also use captures from other query groups like `locals.scm`
				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
			},
			-- You can choose the select mode (default is charwise 'v')
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * method: eg 'v' or 'o'
			-- and should return the mode ('v', 'V', or '<c-v>') or a table
			-- mapping query_strings to modes.
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding or succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * selection_mode: eg 'v'
			-- and should return true or false
			include_surrounding_whitespace = false,
		},
		lsp_interop = {
			enable = true,
			border = "single",
			floating_preview_opts = {},
			peek_definition_code = {
				["<leader>lE"] = "@function.outer",
				["<leader>le"] = "@class.outer",
			},
		},
	},
})

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
-- map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- NOTE: I honestly don't see a proper difference between these two
--
-- vim way: ; goes to the direction you were moving.
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

-- make sure forward function comes first
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
-- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

map({ "n", "x", "o" }, "]h", next_hunk_repeat)
map({ "n", "x", "o" }, "[h", prev_hunk_repeat)
