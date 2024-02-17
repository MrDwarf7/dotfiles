local bufnr = vim.api.nvim_get_current_buf()


return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "BufEnter",
		require("mason-nvim-dap").setup({
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
			require("lsp_binds").lsp_mappings(bufnr)
		})
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})
		end,
	},
}
