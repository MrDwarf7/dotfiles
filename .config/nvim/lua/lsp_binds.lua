local K = {}

K.lsp_mappings = function(bufnr)
	local setup = function()
		-- print("LSP Mappings")
		-- require("fidget").setup()
		local opts = { silent = true, nowait = true, buffer = bufnr }

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)

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

		vim.keymap.set({ "n", "v" }, "<Leader>la", function()
			vim.cmd.RustLsp("codeAction")
		end, { silent = true, buffer = bufnr, desc = "[a]ction" })

		vim.keymap.set("n", "<Leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, opts, { desc = "[f]ormat (lsp)" })

		vim.keymap.set("n", "<Leader>lh", function()
			vim.diagnostic.open_float()
		end, opts, { desc = "[h]over" })

		vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })
		-- LSP attach autocmds are called within the autocmds file (group = LspAuGroup)

		vim.keymap.set("n", "<Leader>lc", function()
			vim.cmd.RustLsp("flyCheck")
		end, opts, { desc = "[c]heck" })

		vim.keymap.set("n", "<Leader>d", "+[d]ebugging")

		vim.keymap.set("n", "<Leader>dd", function()
			vim.cmd.RustLsp("debuggables")
		end, opts, { desc = "[d]ebuggables" })

		vim.keymap.set("n", "<Leader>dr", function()
			vim.cmd.RustLsp("runnables")
		end, opts, { desc = "[r]un" })

		vim.keymap.set("n", "<Leader>lh", function()
			vim.cmd.RustLsp("hover")
		end, opts, { desc = "[h]over" })
	end
	return setup()
end

return K
