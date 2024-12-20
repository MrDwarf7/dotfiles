local capabilities = require("util.lsp_servers").capabilities()

--- Root pattern to handle Deno
---@return table
local function root_pat()
	return {
		root = { "package.json " },
		exclude = { "deno.json", "deno.jsonc" },
	}
end

--- TSServer capabilities
---@param opts? table
---@return table
local function tsserv_cap(opts)
	opts = opts or {}

	return vim.tbl_deep_extend("force", opts, {
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
	})
end

return {
	"pmizio/typescript-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = function(_, opts)
		opts = opts or {}
		opts = vim.tbl_deep_extend("force", opts, {
			settings = {
				capabilities = capabilities,
				root_dir = root_pat(),
				single_file_support = false,
				tsserver_file_preferences = tsserv_cap(),
				tsserver_plugins = {
					"@types/node",
					"@types/react",
					"@types/react-dom",
				},
			},
		})
		return opts
	end,
	config = function(_, opts)
		opts = opts or {}
		require("typescript-tools").setup(opts)
	end,
}
