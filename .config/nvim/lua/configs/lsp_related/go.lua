local go_plugin = require("go")
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

go_plugin.setup()

autocmd({ "BufWritePre", "InsertLeave" }, {
	group = augroup("gofmt", { clear = true }),
	callback = function(bufnr)
		local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
		if filetype == "go" then
			vim.lsp.buf.formatting_sync(nil, 500)
		end
	end,
})
