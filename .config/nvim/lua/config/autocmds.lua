local keymaps = require("config.keymaps")

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({ timeout = 55 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitconfig", ".gitconfig" },
	callback = function()
		local comment_str = vim.filetype.get_option("gitconfig", "commentstring")
		if comment_str ~= "#" then
			vim.cmd([[ setlocal commentstring=#\ %s ]])
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { ".gitignore_global", ".gitignore_local", ".gitignore.local", ".gitignore.global" },
	callback = function()
		vim.cmd([[ set ft=gitignore ]])
		-- vim.bo.filetype = "gitignore"
	end,
})

--- Use 'q' to close quickfix, jumplist, and other help buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"neotest",
		"neotest-output",
		"qf",
		"help",
		"checkhealth",
		"jumplist",
		"lspinfo",
	},
	callback = function()
		-- keymaps.map("n", "q", "<CMD>close<CR>")
		vim.keymap.set("n", "q", function()
			vim.api.nvim_buf_delete(0, { force = true })
		end, { silent = true, buffer = true })
		-- "<CMD>bd<CR>", { silent = true, buffer = true })
	end,
})

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
