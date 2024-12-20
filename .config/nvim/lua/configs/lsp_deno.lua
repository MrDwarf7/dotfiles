local capabilities = require("util.lsp_servers").capabilities()

local function fenced()
	vim.g.markdown_fenced_languages = {
		"ts=typescript",
	}
end

return {
	"sigmaSd/deno-nvim",
	lazy = true,

	dependencies = {
		{ "neovim/nvim-lspconfig", lazy = true },
		{ "nvim-treesitter/nvim-treesitter", lazy = true },
	},

	opts = {
		server = {
			on_attach = require("lspconfig.configs.denols").on_attach,
			capabilities = capabilities,
		},
	},

	setup = function(_, opts)
		opts = opts or {}
		require("deno-nvim").setup(opts)
		fenced()
	end,
}
