return {
	"pmizio/typescript-tools.nvim",
	lazy = true,
	ft = {
		"css",
		"html",
		"javascript",
		-- "lua",
		"scss",
		"txt",
		"vim",
		"yaml",
		"json",
		"typescript",
		"typescriptreact",
		"javascriptreact",
		-- "norg",
		-- "org",
		"pandoc",
		"markdown",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = {
		settings = {
			tsserver_file_preferences = {
				includeCompletionsForImportStatements = true,
				includeCompletionsWithSnippetText = true,
				useLabelDetailsInCompletionEntries = true,

				-- Params
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,

				-- Functions
				includeInlayFunctionParameterTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				-- Variables
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				-- Properties
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayEnumMemberValueHints = true,

				quotePreference = "double",
			},
			-- tsserver_plugins = {
			-- }
		},
	},
	config = function(_, opts)
		opts = opts or {}
		require("typescript-tools").setup(opts)
	end,
}
