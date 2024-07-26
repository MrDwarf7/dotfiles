-- VsCode colors for reference
--
-- -- gray
-- vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
-- -- blue
-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
-- -- light blue
-- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
-- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
-- vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
-- -- pink
-- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
-- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
-- -- front
-- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
-- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
-- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

local M = {}

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

---@param lspkind table
---@return table
M.lspkind_setup = function(lspkind)
	--BUG:
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

---@param cmp table
---@return table
M.cmp_mappings = function(cmp, luasnip)
	return {
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
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),

		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}
end

-----------------------------------------------------------------------------

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "neovim/nvim-lspconfig", lazy = true },
		"L3MON4D3/LuaSnip",

		"zbirenbaum/copilot-cmp",
		"hrsh7th/cmp-nvim-lsp",

		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",

		"saadparwaiz1/cmp_luasnip",
		"saecki/crates.nvim",
		"vrslev/cmp-pypi",
		"onsails/lspkind.nvim",
	},

	opts = function()
		if vim.opt.diff:get() then
			return
		end
		local luasnip = require("luasnip")
		local cmp = require("cmp")

		-- cmp.setup({
		return {
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
			},

			window = {
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
			},

			preselect = cmp.PreselectMode.None,

			formatting = M.lspkind_setup(require("lspkind")),

			mapping = cmp.mapping.preset.insert(M.cmp_mappings(cmp, luasnip)),

			sources = {
				{ name = "nvim_lsp_signature_help", group_index = 2 },
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp", group_index = 2 },
				{ name = "buffer", group_index = 2, max_item_count = 15 },
				{ name = "path", group_index = 2 },
				{ name = "cmp-cmdline" },
				{ name = "nvim_lua", group_index = 2 },

				{ name = "luasnip", group_index = 3 },
				{ name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
				{ name = "crates" },
				{ name = "cmp-pypi" },
				-- { name = "cmp-luasnip-choice" },
			},
			-- })
		}
	end,
}
