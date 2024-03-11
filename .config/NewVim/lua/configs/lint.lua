local nvim_lint = require("lint")
local autocmd = vim.api.nvim_create_autocmd

nvim_lint.linter_by_ft = {
	css = { "stylelint" },
	yaml = { "yamllint" },
	-- docker = { "hadolint" },
	python = { "ruff_lsp", "mypy", "vulture", { "ruff_lsp" } },
	vim = { "vint" },
	sh = { "shellcheck" },
	lua = { "luacheck" },
	javascript = { "biomejs" },
	typescript = { "biomejs" },
	cpp = { "cpplint", "clang-tidy" },
}

autocmd({ "BufWrite" }, {
	callback = function()
		local ft = vim.api.nvim_buf_get_option(0, "filetype")
		if ft == "netrw" or ft == "noname" then
			return false
		end
		if nvim_lint.linter_by_ft[ft] then
			require("lint").try_lint()
			return true
		end
		return false
	end,
})
