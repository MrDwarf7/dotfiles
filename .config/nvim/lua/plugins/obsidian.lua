return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	-- 	-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	-- 	-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	-- 	-- refer to `:h file-pattern` for more examples
	-- 	"BufReadPre E:/Obsidian/StoneVault/*.md",
	-- 	"BufNewFile E:/Obsidian/StoneVault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "StoneVault",
				path = "~/Documents/vaults/StoneVault",
			},
		},

		notes_subdir = "1. Daily Notes",

		daily_notes = {
			folder = "1. Daily Notes",
		},

		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<Leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<CR>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},

		picker = {
			name = "fzf-lua",
		},

		callbacks = {
			post_setup = function()
				vim.opt.conceallevel = 1

				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(event)
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						local buf_name = vim.api.nvim_buf_get_name(0)
						if string.find(buf_name, ".obsidian.vimrc") then
							vim.api.nvim_buf_set_option(0, "filetype", "vim")
							return
						end
						if client and client.server_capabilities.documentHighlightProvider then
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								callback = vim.lsp.buf.document_highlight,
							})

							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								callback = vim.lsp.buf.clear_references,
							})
						end
					end,
				})
			end,
		},
	},
}
