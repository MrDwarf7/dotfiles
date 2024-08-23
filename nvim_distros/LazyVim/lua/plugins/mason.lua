return {
	{

		"williamboman/mason.nvim",
		keys = {
			{
				"<Leader>pm",
				"<cmd>Mason<CR>",
				mode = "n",
				desc = "Mason",
			},
		},

		-- init = function()
		opts = {
			pip = {
				upgrade_pip = true,
			},

			ui = {
				border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
				-- icons = {
				-- package_pending = " ",
				-- package_installed = "󰄳 ",
				-- package_uninstalled = " 󰚌",
				-- },
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"beautysh",
				"black",
				"clang-format",
				"codelldb",
				"debugpy",
				"delve",
				"fixjson",
				"gopls",
				"isort",
				"jsonlint",
				"mypy",
				"powershell_es",
				"prettier",
				"ruff",
				"shfmt",
				"stylua",
				"ts-standard",
				"vulture",
				"yamlfmt",
				-- "csharpier",
			},
		},
	},
}
