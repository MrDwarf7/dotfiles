local autocmd = vim.api.nvim_create_autocmd

require("lint").linter_by_ft = {
	cpp = { "cpplint", "clang-tidy" },
	css = { "stylelint" },
	docker = { "hadolint" },
	javascript = { "biomejs" },
	lua = { "luacheck" },
	python = { "ruff_lsp", "mypy", "vulture", { "ruff_lsp" } },
	sh = { "shellcheck" },
	typescript = { "biomejs" },
	vim = { "vint" },
	yaml = { "yamllint" },
}

autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
