-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		"go",
		"lua",
		"python",
		"rust",
		"typescript",
		"javascript",
		"regex",
		"bash",
		"markdown",
		"markdown_inline",
		"kdl",
		"sql",
		"comment",
		--
		"git_config",
		"git_rebase",
		"gitcommit",
		"gitignore",
		"gitattributes",

	},

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Space>",
			node_incremental = "<C-Space>",
			scope_incremental = "<C-s>",
			node_decremental = "<C-Backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ii"] = "@conditional.inner",
				["ai"] = "@conditional.outer",
				["il"] = "@loop.inner",
				["al"] = "@loop.outer",
				["at"] = "@comment.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
			-- goto_next = {
			--   [']i'] = "@conditional.inner",
			-- },
			-- goto_previous = {
			--   ['[i'] = "@conditional.inner",
			-- }
		},
		swap = {
			enable = true,
			swap_previous = {
				["<leader>s"] = "@parameter.inner",
			},
			swap_next = {
				["<leader>S"] = "@parameter.inner",
			},
		},
	},
})
