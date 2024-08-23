return {
	"mfussenegger/nvim-lint",

	opts = {
		linters_by_ft = {
			cpp = { "cpplint", "clang-tidy" },
			css = { "stylelint" },
			-- cs = { "omnisharp" },
			docker = { "hadolint" },
			javascript = { "biomejs" },
			javascriptreact = { "biomejs" },
			json = { "jsonlint" },
			lua = { "luacheck" },
			powershell = { "powershell_es" },
			python = { "ruff_lsp", "mypy", "vulture", { "ruff_lsp" } },
			sh = { "shellcheck" },
			typescript = { "biomejs" },
			typescriptreact = { "biomejs" },
			vim = { "vint" },
			yaml = { "yamllint" },
		},
	},
}
