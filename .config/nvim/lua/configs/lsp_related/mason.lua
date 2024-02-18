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
		"biome",
		-- "eslint",
		"mypy",
		"ruff",
		-- "ruff_lsp",
		"pyright",
		"shellcheck",
		"ts-standard",
		"vulture",
		"beautysh",
		"biome",
		"black",
		"blackd-client",
		"isort",
		"prettier",
		"prettierd",
		"rustywind",
		"shfmt",
		"ts-standard",
	},
})
