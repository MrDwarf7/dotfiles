return {
	"williamboman/mason.nvim",
	-- lazy = false,
	event = "UIEnter",
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
			icons = {
				package_pending = " ",
				package_installed = "󰄳 ",
				package_uninstalled = " 󰚌",
			},
		},
	},
}
