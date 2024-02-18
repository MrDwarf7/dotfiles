local mason_nvim_dap = require("mason-nvim-dap")
local dap_virtual_text = require("nvim-dap-virtual-text")

mason_nvim_dap.setup({
	ensure_installed = {
		"bash-debug-adapter",
		"chrome-debug-adapter",
		"codelldb",
		"cpptools",
		"debugpy",
		"firefox-debug-adapter",
	},
	handler = {},
	on_attach = on_attach,
})


dap_virtual_text.setup({
	commented = true,
})
