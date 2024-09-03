return {
	"TheLeoP/powershell.nvim",
	lazy = false,
	opts = {
		bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
		capabilities = vim.lsp.protocol.make_client_capabilities(),
		shell = "pwsh",
	},
}
