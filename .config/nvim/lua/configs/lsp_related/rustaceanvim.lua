local M = {}

require("rustaceanvim")

-- local on_attach = autocmd('LspAttach', {
-- 	callback = function(ev, bufnr)
-- 		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
-- 		vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
-- 	end,
-- 	group = augroup("UserLspConfig", { clear = true }),
-- })


require("lsp-inlayhints")

print("THIS IS THE RUST FILEEEEEEE")

M.default_capabilities = function()
	return {
		textDocument = {
			completion = {
				dynamicRegistration = false,
				completionItem = {
					snippetSupport = true,
					commitCharactersSupport = true,
					deprecatedSupport = true,
					preselectSupport = true,
					tagSupport = {
						valueSet = {
							1, -- Deprecated
						},
					},
					insertReplaceSupport = true,
					resolveSupport = {
						properties = {
							"documentation",
							"detail",
							"additionalTextEdits",
							"sortText",
							"filterText",
							"insertText",
							"textEdit",
							"insertTextFormat",
							"insertTextMode",
						},
					},
					insertTextModeSupport = {
						valueSet = {
							1, -- asIs
							2, -- adjustIndentation
						},
					},
					labelDetailsSupport = true,
				},
				contextSupport = true,
				insertTextMode = 1,
				completionList = {
					itemDefaults = {
						"commitCharacters",
						"editRange",
						"insertTextFormat",
						"insertTextMode",
						"data",
					},
				},
			},
		},
		-- Disable client-side watch-files for now, it is slow (see Neovim #23291).
		-- Remove this workaround when #23291 is resolved.
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = false,
			},
		},
	}
end


M.rustaceanvim_setup = function()
	local default_capabilities = require("configs.lsp_related.rustaceanvim").default_capabilities()
	local bufnr = vim.api.nvim_get_current_buf()
	local opts = { silent = true, nowait = true, buffer = bufnr }
	vim.g.rustaceanvim = {
		tools = {
			hover_actions = {
				auto_focus = true,
			},
			inlay_hints = {
				highlight = "NonText",
				autoSetHints = true,
				auto = true,
			},
		},

		server = {
			on_attach = function(client, bufnr)
				require("lsp-inlayhints").on_attach(client, bufnr)
				require("lsp-inlayhints").show()
				pcall(require, "dap-ui")


				vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts, {})

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts, { desc = "[d]efinition" })

				vim.keymap.set("n", "gD", function()
					vim.lsp.buf.declaration()
				end, opts, { desc = "[D]eclaration" })

				vim.keymap.set("n", "gr", function()
					vim.lsp.buf.references()
				end, opts, { desc = "[r]eferences" })

				vim.keymap.set("n", "gI", function()
					vim.lsp.buf.implementation()
				end, opts, { desc = "[i]mplementations" })

				vim.keymap.set("n", "gi", function()
					vim.lsp.buf.incoming_calls()
				end, opts, { desc = "[i]ncoming" })

				vim.keymap.set("n", "gt", function()
					vim.lsp.buf.type_definition()
				end, opts, { desc = "[T]ype" })

				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_next()
				end, opts, { desc = "[diag] next" })

				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_prev()
				end, opts, { desc = "[diag] prev" })

				vim.keymap.set("n", "gO", function()
					vim.lsp.buf.outgoing_calls()
				end, opts, { desc = "[O]utgoing" })

				vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })

				vim.keymap.set("n", "<C-k>", function()
					vim.lsp.buf.signature_help()
				end, opts, { desc = "Signature Help" })

				vim.keymap.set("n", "<Leader>lr", function()
					vim.lsp.buf.rename()
				end, opts, { desc = "[r]ename" })

				-- vim.keymap.set({ "n", "v" }, "<Leader>la", function()
				-- 	vim.cmd.RustLsp("codeAction")
				-- end, { silent = true, buffer = bufnr, desc = "[a]ction" })
				--
				vim.keymap.set("n", "<Leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, opts, { desc = "[f]ormat (lsp)" })

				vim.keymap.set("n", "<Leader>lh", function()
					vim.diagnostic.open_float()
				end, opts, { desc = "[h]over" })

				vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })
				-- LSP attach autocmds are called within the autocmds file (group = LspAuGroup)

				-- vim.keymap.set("n", "<Leader>lc", rst.flyCheck, opts, { desc = "[c]heck" })
				-- vim.keymap.set("n", "<Leader>dd", rst.debuggables, opts, { desc = "[d]ebuggables" })
				-- vim.keymap.set("n", "<Leader>dr", rst.runnables, opts, { desc = "[r]unnables" })
				-- vim.keymap.set("n", "<Leader>lh", rst.hover, opts, { desc = "[r]unnables" })

				-- vim.keymap.set("n", "<Leader>lc", function()
				-- 	vim.cmd.RustLsp("flyCheck")
				-- end, opts, { desc = "[c]heck" })
				--
				-- vim.keymap.set("n", "<Leader>d", "+[d]ebugging")
				--
				-- vim.keymap.set("n", "<Leader>dd", function()
				-- 	vim.cmd.RustLsp("debuggables")
				-- end, opts, { desc = "[d]ebuggables" })
				--
				-- vim.keymap.set("n", "<Leader>dr", function()
				-- 	vim.cmd.RustLsp("runnables")
				-- end, opts, { desc = "[r]un" })
				--
				-- vim.keymap.set("n", "<Leader>lh", function()
				-- 	vim.cmd.RustLsp("hover")
				-- end, opts, { desc = "[h]over" })

				if client.resolved_capabilities.document_formatting then
					vim.keymap.set("n", "<Leader>lf", function() vim.cmd.RustLsp("format") end, opts, { desc = "[f]ormat" })
				end

				if client.resolved_capabilities.document_range_formatting then
					vim.keymap.set("x", "<Leader>lf", function() vim.cmd.RustLsp("format") end, opts, { desc = "[f]ormat" })
				end
			end,
			capatibilities = default_capabilities,
			default_settings = {
				['rust-analyzer'] = {
					inlay_hints = {
						typeHints = true,
						parameterHints = true,
						chainingHints = true,
						maxLength = 120,
						align = true,
						prefix = " » ",
						highlight = "Comment",
					},
				},
			},
		}
	}
end

local opts = { buffer = vim.api.nvim_get_current_buf() }
vim.keymap.set("n", "<Leader>lc", function() vim.cmd.RustLsp("flyCheck") end, opts, { desc = "[c]heck" })
vim.keymap.set("n", "<Leader>dd", function() vim.cmd.RustLsp("debuggables") end, opts, { desc = "[d]ebuggables" })
vim.keymap.set("n", "<Leader>dr", function() vim.cmd.RustLsp("runnables") end, opts, { desc = "[r]un" })
vim.keymap.set("n", "<Leader>lh", function() vim.cmd.RustLsp("hover") end, opts, { desc = "[h]over" })

return M
