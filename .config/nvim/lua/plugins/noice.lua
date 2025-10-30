---@type LazyPluginBase
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	---@type LazyKeys
	keys = {
    -- stylua: ignore start
    { "<Leader>na", function() vim.cmd("NoiceAll") end,     desc = "Noice [a]ll" },
    { "<Leader>nl", function() vim.cmd("NoiceLast") end,    desc = "Noice [l]ast" },
    { "<Leader>nh", function() vim.cmd("NoiceHistory") end, desc = "Noice [h]istory" },
    { "<Leader>ns", function() vim.cmd("NoiceSuspend") end, desc = "Noice [s]uspend" },
    { "<Leader>nn", function() vim.cmd("NoiceDismiss") end, desc = "Noice [n]o/dismiss" },
		-- stylua: ignore end
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				-- ["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
	},
}
