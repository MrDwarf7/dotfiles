return {
	{
		"MunifTanjim/nui.nvim",
		event = { "VeryLazy", "BufEnter" },
		-- lazy = false,
	},

	{
		"rcarriga/nvim-notify",
		-- lazy = false,
		event = { "VeryLazy" },
		config = function()
			vim.notify = require("notify")
		end,
	},

	{
		"stevearc/dressing.nvim",
		event = { "VeryLazy", "BufEnter" },
		-- lazy = false,
		opts = {},
	},

	{
		"j-hui/fidget.nvim",
		lazy = false,
		opts = {},
	},

	{
		"folke/noice.nvim",
		--event = "VeryLazy",
		lazy = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					progress = {
						enabled = true,
						format = "lsp_progress",
						format_done = "lsp_progress_done",
					},
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					}, -- END override
					hover = {
						enabled = true,
						silent = true,
						opts = {},
					},
					signature = {
						enabled = true,
						auto_open = {
							enabled = true,
							trigger = true,
							luasnip = true,
							throttle_time = 80, -- Default val is 50
						},
					},
				},

				presets = {
					--bottom_search = false, -- use a classic bottom cmdline for search
					--command_palette = false, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},

				routes = { {
					view = "notify",
					filter = { event = "msg_showmode" },
				} },

				views = {
					cmdline_popup = {
						position = {
							row = 30,
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
						},
					},
					popupmenu = {
						relative = "editor",
						position = {
							row = 33,
							col = "50%",
						},
						size = {
							width = 60,
							height = 10,
						},
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
						win_options = {
							winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
						},
					},
				}, -- END of VIEWS

				cmdline = {
					format = {
						conceal = false,
						lua = false,
						-- Other options that automaticall colapse into the cmdline popup here :::
						-- cmdline = false,
						-- filter = false,
						help = false,
					}, -- END format
				}, -- END cmdline
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "CursorMoved", "BufWritePost" },
		enabled = true,
		opts = {
			exclude = {
				filetypes = {
					"dbout",
					"neo-tree-popup",
					"log",
					"gitcommit",
					"txt",
					"help",
					"NvimTree",
					"git",
					"flutterToolsOutline",
					"undotree",
					"markdown",
					"norg",
					"org",
					"orgagenda",
					"Diffview",
					"Neogit",
				},
			},
			indent = {
				char = "│", -- ▏┆ ┊ 
				tab_char = "│",
			},
			scope = {
				char = "▎",
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
				show_start = true,
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
		end,
	},
}
