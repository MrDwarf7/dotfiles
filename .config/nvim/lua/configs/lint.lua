return {
	"mfussenegger/nvim-lint",
	event = "BufReadPost",
	opts = {
		cpp = { "cpplint", "clang-tidy" },
		css = { "stylelint" },
		cmake = { "cmakelint " },
		-- cs = { "omnisharp" },
		docker = { "hadolint" },
		javascript = { "biomejs" },
		javascriptreact = { "biomejs" },
		json = { "jsonlint" },
		lua = { "luacheck" },
		powershell = { "powershell_es" },
		python = { "ruff_lsp", "mypy", "vulture", { "ruff_lsp" } },
		sh = { "shellcheck" },
		sql = { "sqlfluff" },
		typescript = { "biomejs" },
		typescriptreact = { "biomejs" },
		vim = { "vint" },
		yaml = { "yamllint" },
	},

	config = function(_, opts)
		opts = opts or {}
		require("lint").linter_by_ft = opts
		return opts
	end,
}
