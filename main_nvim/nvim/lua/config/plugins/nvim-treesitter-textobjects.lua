return {
	'nvim-treesitter/nvim-treesitter-textobjects',
	lazy = true,
	config = function()
		require('nvim-treesitter.configs').setup({
			textobjects = {
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ac'] = '@class.outer',
						['ic'] = '@class.inner',
					},
				},
				swap = {
					enable = true,
					swap_next = {
						['<leader>a'] = '@parameter.inner',
					},
					swap_previous = {
						['<leader>A'] = '@parameter.inner',
					},
				},
				lsp_interop = {
					enable = true,
					peek_definition_code = {
						['df'] = '@function.outer',
						['dF'] = '@class.outer',
					},
				},
			},
		})
	end,
}

--[[ return { ]]
--[[   "machakann/vim-sandwich", ]]
--[[   event = "VeryLazy", ]]
--[[   config = function() ]]
--[[     vim.cmd([[ ]]
--[[       runtime macros/sandwich/keymap/surround.vim ]]
--[[]]
--[[       " Text objects to select ]]
--[[       " the nearest surrounded text automatically ]]
--[[       xmap iss <Plug>(textobj-sandwich-auto-i) ]]
--[[       xmap ass <Plug>(textobj-sandwich-auto-a) ]]
--[[       omap iss <Plug>(textobj-sandwich-auto-i) ]]
--[[       omap ass <Plug>(textobj-sandwich-auto-a) ]]
--[[]]
--[[       " remap to override again ]]
--[[       " xmap S <Plug>Lightspeed_S ]]
--[[       let g:sandwich#recipes += [ ]]
--[[       \   { ]]
--[[       \     'buns':     ['<%= ', ' %>'], ]]
--[[       \     'filetype': ['eruby'], ]]
--[[       \     'input':    ['='], ]]
--[[       \     'nesting':  1 ]]
--[[       \   }, ]]
--[[       \   { ]]
--[[       \     'buns':     ['<% ', ' %>'], ]]
--[[       \     'filetype': ['eruby'], ]]
--[[       \     'input':    ['-'], ]]
--[[       \     'nesting':  1 ]]
--[[       \   }, ]]
--[[       \   { ]]
--[[       \     'buns':     ['<%# ', ' %>'], ]]
--[[       \     'filetype': ['eruby'], ]]
--[[       \     'input':    ['#'], ]]
--[[       \     'nesting':  1 ]]
--[[       \   } ]]
--[[       \ ] ]]
--[[     ]]
--[[   end, ]]
--[[ } ]]
