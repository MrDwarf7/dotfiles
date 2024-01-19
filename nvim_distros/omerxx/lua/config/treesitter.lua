-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	-- parser_install_dir = "$HOME/.xdg/data/tree-sitter/",

	-- IF using the pacman set of ALL the languages, then leave this commented out.
	ensure_installed = {
		-- 	-- one of "all", "maintained" (parsers with maintainers), or a list of languages
		'awk',
		'bash',
		'c',
		'cmake',
		'comment',
		'cpp',
		'css',
		'csv',
		'diff',
		'dockerfile',
		--				'doxygen',
		'git_config',
		'git_rebase',
		'gitattributes',
		'gitcommit',
		'gitignore',
		'go',
		--				'hjson',
		'html',
		--				'htmldjango',
		'http',
		'ini',
		'javascript',
		--				'jq',
		'json',
		--				'jsonc',
		'llvm',
		'lua',
		'luadoc',
		'make',
		--				'markdown',
		--				'markdown_inline',
		--				'ninja',
		--				'nix',
		--				'passwd',
		'python',
		'regex',
		'requirements',
		'rust',
		--				'scss',
		'slint',
		'sql',
		--				'squirrel',
		'ssh_config',
		'terraform',
		'todotxt',
		'toml',
		'tsv',
		'tsx',
		'typescript',
		'unison',
		--				'v',
		'vim',
		'vimdoc',
		--				'vue',
		--				'wgsl',
		--				'wing',
		'xml',
		'yaml',
		--				'yang',
	},

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
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
