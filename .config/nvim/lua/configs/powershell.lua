return {
	"TheLeoP/powershell.nvim",
	ft = { "ps1", "psm1", "psd1" },
	-- lazy = false,
	opts = {
		bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
		capabilities = vim.lsp.protocol.make_client_capabilities(),
		shell = "pwsh",
	},
}
