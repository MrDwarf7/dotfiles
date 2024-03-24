local M = {}

M.lspkind_setup = function()
	require("lspkind").init({
		mode = "symbol_text",
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
	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

	return {
		format = require("lspkind").cmp_format({
			mode = "symbol",
			maxwidth = 80,
			ellipsis_char = "...",
			-- show_labelDetails = true,
			menu = {
				buffer = "[Buffer]",
				copilot = "[Copilot]",
				crates = "[Crates]",
				luasnip = "[LuaSnip]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[lua]",
				path = "[Path]",
			},
		}),
	}
end

M.cmp_mappings = function(cmp)
	return {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),

		["<C-k>"] = cmp.mapping.select_prev_item(), -- Testing
		["<C-j>"] = cmp.mapping.select_next_item(), -- Testing

		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4), -- Mine

		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),

		["<Tab>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = false,
		}),

		["<C-l>"] = cmp.mapping(function()
			if require("luasnip").expand_or_locally_jumpable() then
				require("luasnip").expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if require("luasnip").locally_jumpable(-1) then
				require("luasnip").jump(-1)
			end
		end, { "i", "s" }),

		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif require("luasnip").expand_or_jumpable() then
		-- 		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		--
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif require("luasnip").jumpable(-1) then
		-- 		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
	}
end

-----------------------------------------------------------------------------

M.cmp_full_setup = function()
	if vim.opt.diff:get() then
		return
	end

	require("cmp").setup({
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
				completion = require("cmp").config.window.bordered(),
				winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
				scrollbar = false,
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
				winhighlight = "Normal:CmpDoc",
			},
		},

		preselect = require("cmp").PreselectMode.None,

		formatting = M.lspkind_setup(),
		mapping = require("cmp").mapping.preset.insert(M.cmp_mappings(require("cmp"))),

		sources = {
			{ name = "copilot", group_index = 2 },
			{ name = "nvim_lsp", group_index = 2 },
			{ name = "luasnip", group_index = 2 },
			{ name = "buffer", group_index = 2, max_item_count = 15 },
			{ name = "nvim_lua", group_index = 2 },
			{ name = "path", group_index = 2 },
			-- My additions here
			-- { name = "nvim_lsp_signature_help", group_index = 3 },
			{ name = "cmp-git" },
			{ name = "cmp-cmdline" },
			{ name = "cmp-luasnip-choice" },

			{ name = "crates" },
			{ name = "cmp-pypi" },
		},
	})
end

return M
