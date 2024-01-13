--TODO: Completion related tweaks
local M = {
	'hrsh7th/nvim-cmp',
	lazy = false,
	dependencies = {
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-vsnip' },
		{ 'hrsh7th/vim-vsnip' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-calc' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'ray-x/cmp-treesitter' },
		{ 'lukas-reineke/cmp-rg' },
		{ 'quangnguyen30192/cmp-nvim-tags' },
		--[[ { 'zbirenbaum/copilot-cmp' }, ]]
		{ 'rafamadriz/friendly-snippets' },
	},
}



function M.config()
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	local cmp = require('cmp')
	local lspkind = require('lspkind')
	vim.api.nvim_exec(
		[[
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd BufRead,BufNewFile *.md setlocal spell
]],
		true
	)


	local function border(hl_name)
		--[[ { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" }, ]]
		--[[ {"─", "│", "─", "│", "┌", "┐", "┘", "└"}, ]]
		return {
			{ '┌', hl_name },
			{ '─', hl_name },
			{ '┐', hl_name },
			{ '│', hl_name },
			{ '┘', hl_name },
			{ '─', hl_name },
			{ '└', hl_name },
			{ '│', hl_name },
		}
	end

	cmp.setup({
		window = {
			completion = {
				border = border('FloatBorder'),
				winhighlight = 'Normal:NormalFloat,CursorLine:PmenuSel,Search:None',
			},
			documentation = {
				border = border('FloatBorder'),
			},
		},
		snippet = {
			expand = function(args)
				vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` user.
			end,
		},

		mapping = {
			['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			--[[ ['<C-leader>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }), ]]
			['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			['<C-e>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<C-k>'] = cmp.mapping.select_prev_item(),
			['<C-j>'] = cmp.mapping.select_next_item(),
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<C-n>'] = cmp.mapping.select_next_item(),
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = 'symbol_text',
				maxwidth = 50,

				before = function(entry, vim_item)
					return vim_item
				end,
			}),
		},
		sources = cmp.config.sources({
			{ name = 'tsserver' },
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' },
			{ name = 'path' },
			{ name = 'calc' },
			{ name = 'treesitter' },
			{ name = 'tags' },
			{ name = 'rg' },
		}, {
			{ name = 'buffer' },
		}),
	})
	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' },
		}, {
			{ name = 'cmdline' },
		}),
	})

	cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

setmetatable({
	__call = function()
		local setup_fnc = M.setup()
		if setup_fnc == nil then
			setup_fnc = M.setup()
		end
		if setup_fnc ~= nil then
			setup_fnc()
		end
	end,
}, M)

return M
