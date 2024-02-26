local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")
local capabilities = require("util.lsp-capabilities")
local nvim_lsp_config_file = require("configs.lsp_related.nvim-lspconfig")
local lsp_mappings = require("util.lsp-mappings")
local nvim_lsp_servers_list = require("configs.lsp_related.nvim-lsp-servers")

local ensure_installed_table = {}

if vim.g.os == "unix" then
	ensure_installed_table = {
		--"awk_ls", -- Un-updated (requires running LTS version of node via NVM)
		"azure_pipelines_ls",
		"bashls",
		"biome",
		"clangd",
		"cmake",
		"cssls",
		"docker_compose_language_service",
		"dockerls",
		"eslint",
		"gopls",
		"html",
		"lua_ls",
		"marksman",
		-- "powershell_es",
		"prismals",
		"pyright",
		"ruff_lsp",
		-- "rust_analyzer", -- Since using Rustaceanvim, DO NOT SETUP via lspconfig call
		"slint_lsp",
		"tailwindcss",
		"taplo",
		-- "tsserver",
		"vimls",
		"yamlls",
		"zls",
	}
elseif vim.g.os == "win32" then
	ensure_installed_table = {
		--"awk_ls", -- Un-updated (requires running LTS version of node via NVM)
		"azure_pipelines_ls",
		-- "bashls",
		"biome",
		"clangd",
		"cmake",
		"cssls",
		"docker_compose_language_service",
		"dockerls",
		"eslint",
		"gopls",
		"html",
		"lua_ls",
		"marksman",
		"powershell_es",
		"prismals",
		"pyright",
		"ruff_lsp",
		-- "rust_analyzer", -- Since using Rustaceanvim, DO NOT SETUP via lspconfig call
		"slint_lsp",
		"tailwindcss",
		"taplo",
		-- "tsserver",
		"vimls",
		"yamlls",
		"zls",
	}
end

mason_lspconfig.setup({
	ensure_installed = ensure_installed_table,
	automatic_installation = {
		exclude = { "rust_analyzer", "pyright", "clangd", "ruff_lsp", "tsserver" },
	},

	handlers = {
		function(server_name)
			if server_name == "clangd" then
				return
			end
			if server_name == "rust_analyzer" then
				return
			end
			-- mason_lspconfig.clangd = function()
			--     nvim_lsp_servers_list.clangd.setup()
			--     nvim_lsp_config_file.lsp_on_attach()
			--     capabilities = nvim_lsp_servers_list[nvim_lsp.clangd.setup(capabilities)]
			-- end

			nvim_lsp[server_name].setup({
				on_attach = function()
					nvim_lsp_config_file.lsp_on_attach()
					-- inlay_hints_attach()
				end,
				capabilities = capabilities.default_capabilities(),
			})
		end,
	},
})
