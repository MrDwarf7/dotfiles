return {
	-- { "AndreM222/copilot-lualine" },
	{
		"nvim-lualine/lualine.nvim",
		-- enabled = false,
		lazy = true,
		event = "CursorMoved",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			-- { "AndreM222/copilot-lualine" },
		},

		opts = function(_, opts)
			local symbols = require("trouble").statusline({
				mode = "lsp_document_symbols",
				groups = {},
				title = false,
				filter = { range = true },
				format = "{kind_icon}{symbol.name:Normal}",
				hl_group = "lualine_c_normal",
			})

			return vim.tbl_deep_extend(
				"force",
				{},
				-- opts or {},
				{
					theme = "tokyonight",
					sections = {
						lualine_c = {
							-- 1 is only the current file, 2 expands EVERYTHING, 3 expands but maintains things like `~`,
							{ "filename", file_status = true, path = 3 },
							{ symbols.get, cond = symbols.has }, -- struture symbols/tree
						},
						lualine_x = {
							-- { symbols.get, cond = symbols.has },
							-- { "filename", file_status = true, path = 3 },
							"encoding",
							"fileformat",
							"filetype",
						},
					},
				}
			)
		end,
	},
}
