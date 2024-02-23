local mason_lsp = require("mason-lspconfig")
-- local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup

local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not has_cmp then
	return
end

local clangd_capabilities = vim.tbl_deep_extend(
	"force",
	{},
	vim.lsp.protocol.make_client_capabilities(),
	has_cmp and cmp_nvim_lsp.default_capabilities() or {},
	{
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				},
			},
		},
	}
)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

mason_lsp.setup({
	ensure_installed = {
		"lua_ls",
		-- "tsserver",
		"biome",
		--"awk_ls", -- Un-updated (requires running LTS version of node via NVM)
		"azure_pipelines_ls",
		"bashls",
		"clangd",
		"cmake",
		"cssls",
		"docker_compose_language_service",
		"dockerls",
		-- "eslint",
		"html",
		"taplo",
		"marksman",
		"powershell_es",
		"prismals",
		"tailwindcss",
		"ruff_lsp",
		"pyright",
		"rust_analyzer", -- Since using Rustaceanvim, DO NOT SETUP via lspconfig call
		"slint_lsp",
		"vimls",
		"yamlls",
		"zls",
	},
	automatic_installation = {
		exclude = { "rust_analyzer", "pyright", "clangd", "ruff_lsp" },
	},

	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				on_attach = function(client, bufnr) end,
				capabilities = capabilities,
			})
		end,
	},
})
