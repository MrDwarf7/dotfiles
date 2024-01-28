return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					'lua',
					'vim',
					'vimdoc',
					'regex',
					'c',
					'rust',
					'python',
					'typescript',
					'tsx',
					'toml',
					'css',
					'html',
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			})
		end,
	},
}
