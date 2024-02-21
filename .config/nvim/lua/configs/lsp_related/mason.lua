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
})
