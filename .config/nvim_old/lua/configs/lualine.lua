return {
	"nvim-lualine/lualine.nvim",
	lazy = true,
	event = "CursorMoved",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},

	opts = function(_, opts)
		if opts == nil then
			opts = {}
		end

		local symbols = require("trouble").statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			hl_group = "lualine_c_normal",
		})

		return table.insert(opts, {
			theme = "tokyonight",
			sections = {
				lualine_c = {
					symbols.get,
					cond = symbols.has,
				},

				lualine_x = {
					{
						"copilot",
						symbols = {
							status = {
								icons = {
									enabled = " ",
									sleep = " ", -- auto-trigger disabled
									disabled = " ",
									warning = " ",
									unknown = " ",
								},
								hl = {
									enabled = "#50FA7B",
									sleep = "#AEB7D0",
									disabled = "#6272A4",
									warning = "#FFB86C",
									unknown = "#FF5555",
								},
							},
							-- spinners = require("copilot-lualine.spinners").dots,
							spinner_color = "#6272A4",
						},
						show_colors = true,
						show_loading = true,
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		})
	end,
}
