vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"neovim/nvim-lspconfig",
		"L3MON4D3/LuaSnip",

		{ "zbirenbaum/copilot-cmp" }, -- event = "InsertEnter",
		{ "hrsh7th/cmp-nvim-lsp", opts = {} },

		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",

		{ "folke/lazydev.nvim", opts = {} },
		"saadparwaiz1/cmp_luasnip",
		{ "saecki/crates.nvim", ft = { "toml", "rust" }, tag = "stable", opts = {} },
		"vrslev/cmp-pypi",
		"onsails/lspkind.nvim",
	},

	opts = function(_, opts)
		if vim.opt.diff:get() then
			return
		end

		-- local luasnip = require("luasnip")
		local cmp = require("cmp")

		require("lspkind").init({
			mode = "symbol",
			preset = "codicons",
			symbol_map = {
				Class = "󰠱",
				Color = "󰏘",
				Constant = "󰏿",
				Constructor = "",
				Copilot = "",
				Enum = "",
				EnumMember = "",
				Event = "",
				Field = "󰜢",
				File = "󰈙",
				Folder = "󰉋",
				Function = "󰊕",
				Interface = "",
				Keyword = "󰌋",
				Method = "󰆧",
				Module = "",
				Operator = "󰆕",
				Property = "󰜢",
				Reference = "󰈇",
				Snippet = "",
				Struct = "󰙅",
				Text = "󰉿",
				TypeParameter = "",
				Unit = "󰑭",
				Value = "󰎠",
				Variable = "󰀫",
			},
		})

		-- opts.cmp_config =
		return {
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
					-- require("luasnip").lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone,noinsert,preview,popup",
			},

			window = {
				completion = {
					completion = "single",
					-- cmp.config.window.bordered(),
					winhighlight = "Normal:CmpPmenu,CursorLine:Pmenu,Search:None",
					winblend = 8,
					scrollbar = true,
				},

				documentation = {
					border = "single",
					winhighlight = "Normal:CmpPmenu,FloatBorder:Pmenu,Search:None",
					winblend = 0,
					scrollbar = false,
				},
			},

			preselect = cmp.PreselectMode.None,

			formatting = {
				fields = {
					"abbr",
					"kind",
					"menu",
				},
				expandable_indicator = true,
				format = require("lspkind").cmp_format({
					mode = "symbol_text",
					maxwidth = 80,
					ellipsis_char = "...",
					show_labelDetails = false,
					menu = {
						buffer = "[Buf]",
						copilot = "[Cop]",
						crates = "[Crates]",
						luasnip = "[LuaS]",
						nvim_lsp = "[LSP]",
						nvim_lua = "[lua]",
						lazydev = "[LZY]",
						path = "[Path]",
					},
				}),
			},

			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),

				["<C-k>"] = cmp.mapping.select_prev_item(), -- Testing
				["<C-j>"] = cmp.mapping.select_next_item(), -- Testing

				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4), -- Mine

				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),

				["<Tab>"] = cmp.mapping({
					i = function(fallback)
						if
							cmp.visible() -- and cmp.get_active_entry() ---- This was doing the awkward thing where having to C-j-k to get first item
						then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),

				["<C-l>"] = cmp.mapping(function()
					local luasnip = require("luasnip")
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),

				["<C-h>"] = cmp.mapping(function()
					local luasnip = require("luasnip")
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),

			-- print("CMP: ", vim.inspect(opts.sources)),
			-- sources = opts,

			-- priority: higher is LESS important
			sources = {
				{ name = "nvim_lsp", priority_weight = 1, max_item_count = 50 },
				{ name = "nvim_lsp_signature_help", priority_weight = 2 },
				{ name = "nvim_lua", priority_weight = 3, group_index = 2 },
				{ name = "copilot", keyword_length = 1, priority_weight = 2 },
				{ name = "buffer", priority_weight = 1 },
				{ name = "path", priority_weight = 2 },
				{ name = "cmp-cmdline" },

				{ name = "luasnip" },

				{ name = "crates", ft = { "toml" } }, -- TODO:
				{ name = "cmp-pypi", ft = { "py", "python" } }, -- TODO:
				{ name = "cmp-luasnip-choice" },
				{ name = "lazydev", group_index = 0 },
				-- { name = "vim-dadbod-completion", },
			},
		}

		-- opts.lspkind_config = {}
		-- local lspkind_config = {}
	end,
}
