return {
	--[[ COLORSCHEME ]]
	{
		'folke/tokyonight.nvim',
		lazy = false,
		enabled = true,
		priority = 1000,
		config = function()
			require('config.colorschemes.tokyonight')
		end,
	},

	--[[ { ]]
	--[[   "sainnhe/gruvbox-material", ]]
	--[[   lazy = false, ]]
	--[[   enabled = false, ]]
	--[[   priority = 1000, ]]
	--[[    config = function() ]]
	--[[      require('config.colorschemes.gruvbox') ]]
	--[[    end, ]]
	--[[ }, ]]

	{
		'projekt0n/github-nvim-theme',
		enabled = false,
		priority = 1000,
		config = function()
			require('config.colorschemes.github')
		end,
	},
	--[[ END COLORSCHEME ]]
	{
		'MunifTanjim/nui.nvim',
		lazy = false,
	},

	{
		'stevearc/dressing.nvim',
		lazy = false,
	},

	{
		'onsails/lspkind-nvim',
		lazy = false,
	},

	{
		'pmizio/typescript-tools.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'neovim/nvim-lspconfig',
		},
		lazy = false,
	},

	{
		'folke/neodev.nvim',
		event = 'VeryLazy',
		config = function()
			require('neodev')
		end,
	},

	{
		'mfussenegger/nvim-lint',
		event = { 'BufEnter', 'CursorHold' },
	},

	{
		'hrsh7th/nvim-cmp',
		priority = 1000,
		lazy = false,
	},

	{
		'hrsh7th/cmp-buffer',
		lazy = false,
	},

	{
		'hrsh7th/cmp-vsnip',
		lazy = false,
	},

	{
		'hrsh7th/vim-vsnip',
		lazy = false,
	},

	{
		'hrsh7th/cmp-path',
		lazy = false,
	},

	{
		'hrsh7th/cmp-calc',
		lazy = false,
	},

	{
		'hrsh7th/cmp-cmdline',
		lazy = false,
	},

	{
		'ray-x/cmp-treesitter',
		lazy = false,
	},

	{
		'lukas-reineke/cmp-rg',
		lazy = false,
	},

	{
		'quangnguyen30192/cmp-nvim-tags',
		lazy = false,
	},

	{
		'rafamadriz/friendly-snippets',
		lazy = false,
	},

	{
		'zbirenbaum/copilot.lua',
		lazy = false,
	},

	{
		'zbirenbaum/copilot-cmp',
		lazy = true,
		event = "BufEnter"
	},

	{
		'windwp/nvim-ts-autotag',
		lazy = "VeryLazy",
		event = "BufEnter",
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	},

	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
			'nvim-treesitter/nvim-treesitter-refactor',
			'nvim-treesitter/nvim-treesitter-context',
		},
		lazy = false, --can uncomment this, and disable the event below to load treesitter on startup by default instead.
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup({
				--[[ ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages ]]
				refactor = {
					smart_rename = {
						enable = true,
						keymaps = {
							smart_rename = '<leader>lr',
							desc = 'Rename variable under cursor',
						},
					},
					highlight_definitions = {
						enable = true,
						clear_on_cursor_move = true,
					},
				},
				ensure_installed = {
					-- one of "all", "maintained" (parsers with maintainers), or a list of languages
					'bash',
					'c',
					'cmake',
					'comment',
					'cpp',
					'css',
					'csv',
					'diff',
					'dockerfile',
					'doxygen',
					'git_config',
					'git_rebase',
					'gitattributes',
					'gitcommit',
					'gitignore',
					'go',
					'hjson',
					'html',
					'htmldjango',
					'http',
					'ini',
					'javascript',
					'jq',
					'json',
					'jsonc',
					'lua',
					'make',
					'markdown',
					'markdown_inline',
					'ninja',
					'nix',
					'passwd',
					'python',
					'regex',
					'rust',
					'scss',
					'sql',
					'squirrel',
					'ssh_config',
					'terraform',
					'todotxt',
					'toml',
					'tsv',
					'tsx',
					'typescript',
					'unison',
					'v',
					'vim',
					'vue',
					'wgsl',
					'wing',
					'xml',
					'yaml',
					'yang',
				},

				highlight = {
					enable = true,
					--[[ disable = { "embedded_template" } ]]
				},

				indent = {
					enable = true,
				},

				context_commentstring = {
					enable = false,
					enable_autocmd = false,
				},

				matchup = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = '<A-n>',
						nodd_incremental = '<A-n>',
						scope_incremental = false,
						node_decremental = '<A-N>',
					},
				},
			})
		end,
	},

	--[[ { ]]
	--[[ 	"LhKipp/nvim-nu", ]]
	--[[ 	lazy = false, ]]
	--[[ 	config = function() ]]
	--[[ 		require("nu").setup() ]]
	--[[ 	end, ]]
	--[[ 	}, ]]

	{
		'hiphish/rainbow-delimiters.nvim',
		lazy = true,
		event = "BufEnter",
	},

	{
		'luukvbaal/statuscol.nvim',
		lazy = false,
		config = function()
			require('statuscol').setup({
				separator = ' ',
				setopt = true,
			})
		end,
	},

	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		event = 'UIEnter',
		enabled = true,
		opts = {
			exclude = {
				-- stylua: ignore
				filetypes = {
					'dbout', 'neo-tree-popup', 'log', 'gitcommit',
					'txt', 'help', 'NvimTree', 'git', 'flutterToolsOutline',
					'undotree', 'markdown', 'norg', 'org', 'orgagenda', "Diffview", "Neogit",
				},
			},
			indent = {
				char = '│', -- ▏┆ ┊ 
				tab_char = '│',
			},
			scope = {
				char = '▎',
				highlight = {
					'RainbowDelimiterRed',
					'RainbowDelimiterYellow',
					'RainbowDelimiterBlue',
					'RainbowDelimiterOrange',
					'RainbowDelimiterGreen',
					'RainbowDelimiterViolet',
					'RainbowDelimiterCyan',
				},
				show_start = true,
			},
		},
		config = function(_, opts)
			require('ibl').setup(opts)
			local hooks = require('ibl.hooks')
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
		end,
	},

	{
		'shellRaining/hlchunk.nvim',
		event = { 'UIEnter' },
		config = function()
			require('hlchunk').setup({
				chunk = {
					chars = {
						horizontal_line = '━',
						vertical_line = '┃',
						left_top = '┏',
						left_bottom = '┗',
						right_arrow = '━',
					},
				},
				blank = {
					enable = false,
				},
			})
		end,
	},

	{
		'JoosepAlviste/nvim-ts-context-commentstring',
		lazy = false,
	},

	{
		'nvim-treesitter/nvim-treesitter-context',
		lazy = true,
		event = "BufEnter",
	},

	{
		'AckslD/nvim-neoclip.lua',
		config = function()
			require('neoclip').setup()
		end,
	},

	{
		'nacro90/numb.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			require('numb').setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},

	{
		'tpope/vim-rails',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			-- disable autocmd set filetype=eruby.yaml
			vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
				pattern = { '*.yml' },
				callback = function()
					vim.bo.filetype = 'yaml'
				end,
			})
		end,
	},

	{
		'tpope/vim-abolish',
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		'tpope/vim-sleuth',
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		'tpope/vim-bundler',
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		'tpope/vim-capslock',
		lazy = false,
	},

	{
		'tpope/vim-repeat',
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		'tpope/vim-endwise',
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		'tpope/vim-dispatch',
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		'tpope/vim-dadbod',
		lazy = false,
	},

	{
		'christoomey/vim-tmux-navigator',
		lazy = "VeryLazy",
	},

	{
		'ludovicchabant/vim-gutentags',
		lazy = false,
		config = function()
			vim.cmd('set tags+=tags,.git/tags')
			vim.g.gutentags_enabled = 1
			vim.g.gutentags_generate_on_missing = 1
			vim.g.gutentags_generate_on_write = 1
			vim.g.gutentags_resolve_symlinks = 1
			vim.g.gutentags_ctags_tagfile = '.git/tags'
			vim.g.gutentags_project_root = { '.git' }
			vim.g.gutentags_ctags_extra_args = { '--fields=+l' }
			vim.g.gutentags_add_default_project_roots = 0
			--[[ vim.g.gutentags_ctags_executable_ruby = "ripper-tags" ]]
			--[[ vim.g.gutentags_ctags_extra_args_ruby = { "--ignore-unsupported-options", "--recursive" } ]]
			-- vim.g.gutentags_trace = 1
		end,
	},

	{
		'rcarriga/nvim-dap-ui',
		event = 'VeryLazy',
		config = function()
			require('dapui').setup()
		end,
	},

	{
		'theHamsta/nvim-dap-virtual-text',
		event = 'VeryLazy',
		config = function()
			require('nvim-dap-virtual-text').setup()
		end,
	},

	{
		'folke/todo-comments.nvim',
		lazy = false,
		config = function()
			require('todo-comments').setup({})
		end,
	},

	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		config = function()
			require('which-key').setup({
				window = {
					border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
				},
			})
		end,
	},

	{
		'airblade/vim-rooter',
		lazy = false,
		config = function()
			vim.g.rooter_silent_chdir = 1
			vim.g.rooter_cd_cmd = 'lcd'
			vim.g.rooter_resolve_links = 1
			vim.g.rooter_patterns = { '.git', '.git/' }
		end,
	},

	{
		'jeffkreeftmeijer/vim-numbertoggle',
		lazy = false,
	},

	{
		'folke/zen-mode.nvim',
		cmd = 'ZenMode',
		opts = {
			plugins = {
				gitsigns = false,
				tmux = false,
				twilight = true,
			},
		},
	},

	{
		'lambdalisue/suda.vim',
		event = 'VeryLazy',
	},

	{
		'andymass/vim-matchup',
		event = 'BufReadPost',
		enabled = false,
		init = function()
			vim.o.matchpairs = '(:),{:},[:],<:>'
		end,
		config = function()
			vim.g.matchup_matchparen_deferred = 1
			vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
		end,
	},
	{
		'chrisbra/csv.vim',
		event = 'VeryLazy',
	},

	--[[ { ]]
	--[[   "kazhala/close-buffers.nvim", ]]
	--[[   event = "VeryLazy", ]]
	--[[ }, ]]

	{ 'folke/twilight.nvim',                  event = 'VeryLazy' },
	{ 'zdharma-continuum/zinit-vim-syntax',   event = 'VeryLazy' },
	{ 'nvim-tree/nvim-web-devicons',          event = 'VeryLazy' },
	{ 'chaoren/vim-wordmotion',               event = 'VeryLazy' },
	{ 'windwp/nvim-spectre',                  event = 'VeryLazy' },
	{ 'folke/trouble.nvim',                   event = 'VeryLazy' },
	{ 'mrbjarksen/neo-tree-diagnostics.nvim', event = 'VeryLazy' },
	{ 'RRethy/vim-illuminate',                event = 'VeryLazy' },

	{
		'folke/edgy.nvim',
		lazy = false,
		--[[ event = 'VeryLazy', ]]
		opts = {
			options = {
				left = { size = 40 },
				bottom = { size = 10 },
				right = { size = 40 },
				top = { size = 10 },
			},

			bottom = {
				{
					ft = 'toggleterm',
					title = 'TERMINAL',
					size = { height = 0.4 },
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ''
					end,
				},
				{ ft = 'spectre_panel', title = 'SPECTRE', size = { height = 0.4 } },
				{ ft = 'Trouble',       title = 'TROUBLE' },
				{ ft = 'qf',            title = 'QUICKFIX' },
				{
					ft = 'help',
					size = { height = 35 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == 'help'
					end,
				},
			},

			left = {
				{
					title = '  FILE',
					ft = 'neo-tree',
					filter = function(buf)
						return vim.b[buf].neo_tree_source == 'filesystem'
					end,
					size = { height = 0.7 },
				},

				{
					title = '  GIT',
					ft = 'neo-tree',
					filter = function(buf)
						return vim.b[buf].neo_tree_source == 'git_status'
					end,
					pinned = false,
					open = 'Neotree position=right git_status',
				},

				{
					title = '  BUFFERS',
					ft = 'neo-tree',
					filter = function(buf)
						return vim.b[buf].neo_tree_source == 'buffers'
					end,
					pinned = false,
					open = 'Neotree position=top buffers',
				},

				{
					ft = '裂 DIAGNOSTICS',
					filter = function(buf)
						return vim.b[buf].neo_tree_source == 'diagnostics'
					end,
					pinned = false,
					open = 'Neotree position=right diagnostics',
				},

				{
					title = '  OUTLINE',
					ft = 'Outline',
					pinned = false,
					open = 'SymbolsOutline',
				},

				'neo-tree',
			},
		},
	},

	{
		'akinsho/bufferline.nvim',
		event = 'VeryLazy',
		version = '*',
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require('bufferline').setup({
				options = {
					diagnostics = 'nvim_lsp',
					separator_style = 'slant',
					always_show_bufferline = false,
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local icon = level:match('error') and ' ' or ' '
						return ' ' .. icon .. count
					end,
				},
			})
		end,
		opts = function()
			local Offset = require('bufferline.offset')
			if not Offset.edgy then
				local get = Offset.get
				Offset.get = function()
					if package.loaded.edgy then
						local layout = require('edgy.config').layout
						local ret = { left = '', left_size = 0, right = '', right_size = 0 }
						for _, pos in ipairs({ 'left', 'right' }) do
							local sb = layout[pos]
							if sb and #sb.wins > 0 then
								local title = ' SIDEBAR' .. string.rep(' ', sb.bounds.width - 8)
								ret[pos] = '%#EdgyTitle#' .. title .. '%*' .. '%#WinSeparator#│%*'
								ret[pos .. '_size'] = sb.bounds.width
							end
						end
						ret.total_size = ret.left_size + ret.right_size
						if ret.total_size > 0 then
							return ret
						end
					end
					return get()
				end
				Offset.edgy = true
			end
		end,
	},

	{
		'simrat39/symbols-outline.nvim',
		cmd = 'SymbolsOutline',
		keys = { { '<leader>ls', '<cmd>SymbolsOutline<cr>', desc = 'Symbols Outline' } },
		opts = {
			position = 'right',
		},
	},

	{
		'folke/flash.nvim',
		event = 'VeryLazy',
		opts = {},
		keys = {
			{
				'<C-f>',
				mode = { 'n', 'x', 'o' },
				function()
					-- default options: exact mode, multi window, all directions, with a backdrop
					require('flash').jump()
				end,
				desc = 'Flash',
			},

			--[[ { ]]
			--[[ 	"S", ]]
			--[[ 	mode = { "n", "o", "x" }, ]]
			--[[ 	function() ]]
			--[[ 		-- show labeled treesitter nodes around the cursor ]]
			--[[ 		require("flash").treesitter() ]]
			--[[ 	end, ]]
			--[[ 	desc = "Flash Treesitter", ]]
			--[[ }, ]]

			--[[ { ]]
			--[[ 	"r", ]]
			--[[ 	mode = "o", ]]
			--[[ 	function() ]]
			--[[ 		-- jump to a remote location to execute the operator ]]
			--[[ 		require("flash").remote() ]]
			--[[ 	end, ]]
			--[[ 	desc = "Remote Flash", ]]
			--[[ }, ]]

			{
				'R',
				mode = { 'n', 'o', 'x' },
				function()
					-- show labeled treesitter nodes around the search matches
					require('flash').treesitter_search()
				end,
				desc = 'Treesitter Search',
			},
		},
	},

	{
		'smoka7/multicursors.nvim',
		event = 'VeryLazy',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'smoka7/hydra.nvim',
		},
		opts = function()
			local N = require('multicursors.normal_mode')
			local I = require('multicursors.insert_mode')
			return {
				normal_keys = {
					-- to change default lhs of key mapping change the key
					[','] = {
						-- assigning nil to method exits from multi cursor mode
						method = N.clear_others,
						-- you can pass :map-arguments here
						opts = { desc = 'Clear others' },
					},
				},
				insert_keys = {
					-- to change default lhs of key mapping change the key
					['<CR>'] = {
						-- assigning nil to method exits from multi cursor mode
						method = I.Cr_method,
						-- you can pass :map-arguments here
						opts = { desc = 'New line' },
					},
				},
				hint_config = {
					border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
				},
				generate_hints = {
					normal = true,
					insert = true,
					extend = true,
				},
			}
		end,
		cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
		keys = {
			{
				mode = { 'v', 'n' },
				'<leader>c',
				'<cmd>MCstart<cr>',
				desc = 'Cursor mode. Create selection',
			},
		},
	},

	{
		'2kabhishek/co-author.nvim',
		dependencies = { 'stevearc/dressing.nvim' },
		cmd = 'GitCoAuthors',
	},

	{ 'sindrets/diffview.nvim', cmd = { 'DiffviewOpen', 'DiffviewFileHistory' } },

	{
		'linux-cultist/venv-selector.nvim',
		event = 'VeryLazy',
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-telescope/telescope.nvim',
			'mfussenegger/nvim-dap-python',
		},
	},

	{
		'jay-babu/mason-nvim-dap.nvim',
		dependencies = {
			'mfussenegger/nvim-dap-python',
			'rcarriga/nvim-dap-ui',
			'theHamsta/nvim-dap-virtual-text',
			'nvim-telescope/telescope-dap.nvim',
			'williamboman/mason.nvim',
			'mfussenegger/nvim-dap',
		},
	},

	{
		'williamboman/mason.nvim',
		dependencies = {
			'WhoIsSethDaniel/mason-tool-installer.nvim',
		},
		lazy = false,
	},

	{
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		lazy = false,
	},

	--[[ { ]]
	--[[   "weizheheng/ror.nvim", ]]
	--[[ }, ]]

	{ 'echasnovski/mini.nvim',  version = false },
}
