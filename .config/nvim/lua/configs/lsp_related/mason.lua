local mason = require("mason")

mason.setup({
	ui = {
		border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = " 󰚌",
		},
	},

	ensure_installed = {
		"beautysh",
		"biome",
		"biome",
		"black",
		"blackd-client",
		-- "eslint",
		"isort",
		"jsonlint",
		"mypy",
		"prettier",
		"prettierd",
		"pyright",
		"ruff",
		-- "ruff_lsp",
		"rustywind",
		"shellcheck",
		"shfmt",
		"ts-standard",
		"ts-standard",
		"vulture",
	},
})
