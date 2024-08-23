local M = {}
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

---@param lspkind table
---@return table
M.lspkind_setup = function(lspkind)
	lspkind.init({
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

	return {
		--BUG:
		format = lspkind.cmp_format({
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
				path = "[Path]",
			},
		}),
	}
end

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"onsails/lspkind.nvim",
	},
	opts = function(_, opts)
		local cmp = require("cmp")

		opts.window = {
			completion = {
				completion = cmp.config.window.bordered(),
				winhighlight = "Normal:CmpPmenu,CursorLine:Pmenu,Search:None",
				winblend = 8,
				scrollbar = true,
			},

			documentation = {
				border = {
					{ "╭", "cmpDocBorder" },
					{ "─", "cmpDocBorder" },
					{ "╮", "cmpDocBorder" },
					{ "│", "cmpDocBorder" },
					{ "╯", "cmpDocBorder" },
					{ "─", "cmpDocBorder" },
					{ "╰", "cmpDocBorder" },
					{ "│", "cmpDocBorder" },
				},
				winhighlight = "Normal:CmpPmenu,FloatBorder:Pmenu,Search:None",
				winblend = 0,
				scrollbar = false,
			},
		}

		opts.preselect = cmp.PreselectMode.None

		opts.formatting = M.lspkind_setup(require("lspkind"))

		opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
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
		})
	end,
}
