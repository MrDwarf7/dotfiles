local M = {}

local utils = require("utils")

M.lspkind_setup = function()
	require("lspkind").init({
		mode = "symbol_text",
		preset = "codicons",
		symbol_map = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "󰜢",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "",
			Copilot = "",
		},
	})
	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

	local lspkind_formatting_style = {
		format = require("lspkind").cmp_format({
			mode = "symbol",
			maxwidth = 80,
			ellipsis_char = "...",
			--show_labelDetails = true,
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[lua]",
				copilot = "[Copilot]",
				path = "[Path]",
				crates = "[Crates]",
			},
		}),
	}
	return lspkind_formatting_style
end

M.luasnip_func = function(opts)
	require("luasnip").config.set_config(opts)

	-- vscode format
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

	-- snipmate format
	require("luasnip.loaders.from_snipmate").load()
	require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

	-- lua format
	require("luasnip.loaders.from_lua").load()
	require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if
				require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
				and not require("luasnip").session.jump_active
			then
				require("luasnip").unlink_current()
			end
		end,
	})
end

M.cmp_boarder = function()
	local hl_name = "CmpDocBorder"
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

M.cmp_mappings = function()
	local cmp = require("cmp")
	return {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),

		["<C-k>"] = cmp.mapping.select_prev_item(), -- Testing
		["<C-j>"] = cmp.mapping.select_next_item(), -- Testing

		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4), -- Mine
		-- ["<C-f>"] = cmp.mapping.scroll_docs(4),

		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
	}
end

M.nvim_cmp_main_opts = function()
	local cmp = require("cmp")

	local lspkind_formatting_style = M.lspkind_setup()
	local border = M.cmp_boarder()
	local mapping = M.cmp_mappings()

	local opts = {
		window = {
			completion = {
				completion = cmp.config.window.bordered(),
				winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
				scrollbar = false,
			},
			documentation = {
				border = border,
				winhighlight = "Normal:CmpDoc",
			},
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		preselect = cmp.PreselectMode.None,

		formatting = lspkind_formatting_style,

		mapping = mapping,

		sources = {
			{ name = "copilot", group_index = 2 },
			{ name = "nvim_lsp", group_index = 2 },
			{ name = "luasnip", group_index = 2 },
			{ name = "buffer", group_index = 2 },
			{ name = "nvim_lua", group_index = 2 },
			{ name = "path", group_index = 2 },
			-- My additions here
			{ name = "nvim_lsp_signature_help", group_index = 3 },
			{ name = "cmp-git" },
			{ name = "cmp-cmdline" },
			{ name = "cmp-luasnip-choice" },

			{ name = "crates" },
			{ name = "cmp-pypi" },
		},
	} -- End of OPTS
	return opts
end

return M
