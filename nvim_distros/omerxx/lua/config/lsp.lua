-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.

local on_attach = function(_, bufnr)
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		if vim.lsp.buf.format then
			vim.lsp.buf.format()
		elseif vim.lsp.buf.formatting then
			vim.lsp.buf.formatting()
		end
	end, { desc = "Format current buffer with LSP" }
	)
	return require("lsp-status").on_attach(_, bufnr)
end

local mason_tool_installer = require("mason-tool-installer")
mason_tool_installer.setup({
	ensure_installed = {
		"prettier",
		-- "prettierd",
		"biome",
		"tsserver",
		"tailwindcss",
		"black",
		"isort",
		"stylelint",
		"yamllint",
		"hadolint",
		"ruff",
		"vulture",
		"vint",
		"shellcheck",
		"powershell_es",
		"lua_ls",
		"vimls",
		"rust_analyzer",
		"ruff_lsp",
		"slint_lsp",
		-- 'selene',
		-- 'eslint_d',
		--- 'yamlls',
		-- 'debugpy',
		-- 'pyright',
		-- 'bashls',
		--
	},
})

-- Setup mason so it can manage external tooling
require("mason").setup()
local servers = {
	"biome",
	"clangd",
	"gopls",
	"html",
	"tsserver",
	"tailwindcss",
	"cssls",
	"dockerls",
	"jsonls",
	"vimls",
	"powershell_es",
	"lua_ls",
	--[[ 'yamlls', ]]
	"vimls",
	"rust_analyzer",
	--[[ 'debugpy', ]]
	--[[ 'pyright', ]]
	"ruff_lsp",
	"bashls",
	"slint_lsp",
}

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

-- Turn on lsp status information

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").luau_lsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
		},
	},
})

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		hostInfo = "neovim",
		-- 4GB memory limit, test it I guess
		maxTsServerMemory = 4096,
		tsserver = { useSyntaxServer = "never" },
	},
})



-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local handlers = require('nvim-autopairs.completion.handlers')


cmp.setup({
	view = {
		entries = "native",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-leader>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "tsserver" },
		{ name = "tailwindcss" },
		{ name = "powershell_es" },
	},
	cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
})

local conform = require("conform")
conform.setup({
	event = { "BufWritePre", "BufNewFile" },
	formatters_by_ft = {
		javascript = { "biome" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		javascriptreact = { "biome" },
		json = { "biome" },
		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		yaml = { "prettier" },
		toml = { "prettier" },
		markdown = { "prettier" },
		lua = { "stylua" },
		python = { { "ruff_lsp", "ruff_format", "black", "isort" }, },

	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1500, -- Default is 1000, disregarded if async = true
	},
	format_after_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1500, -- Default is 1000, disregarded if async = true
	},

	vim.keymap.set({ "n", "v" }, "<leader>lf", function()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 2500, -- Default is 1000, disregarded if async = true
		})
	end, { desc = "Format or format range if visual" }),
})

local typescript_tools = require("typescript-tools")
typescript_tools.setup({
	settings = {
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "all",
			includeCompletionsForModuleExports = true,
			quotePreference = "auto",
		},
		tsserver_format_options = {
			allowIncompleteCompletions = false,
			allowRenameOfImportPath = false,
		},
	},
})



local copilot = require('copilot')
copilot.setup({
	panel = {
		enabled = true, -- TOGGLE
		auto_refresh = true,
		keymap = {
			jump_next = '<A-]>',
			jump_prev = '<A-[>',
			accept = '<CR>',
			refresh = 'gr', -- Consider <leader>cn ("Co-pilot New" ?)
			open = '<A-CR>',
		},
		layout = {
			position = 'bottom',
			ratio = 0.4,
		},
	},
	suggestion = {
		enabled = true,
		auto_trigger = true, --DEFAULT FOR NOW
		debounce = 75,     --No idea lol
		keymap = {
			accept = '<C-l>',
			accept_word = false,
			accept_line = false,
			next = '<A-]>',
			prev = '<A-[>',
			dismiss = '<A-c>',
		},
	},
})


local copilot_cmp = require('copilot_cmp')
copilot_cmp.setup({})



vim.api.nvim_create_autocmd("FileType", {
	pattern = "sh",
	callback = function()
		vim.lsp.start({
			name = "bash-language-server",
			cmd = { "bash-language-server", "start" },
		})
	end,
})

local nmap = function(keys, func, desc)
	if desc then
		desc = "LSP: " .. desc
	end

	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
end



-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>lh", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>j", vim.diagnostic.setloclist)

nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

nmap("<leader>lr", vim.lsp.buf.rename, "[L]sp Rename")
nmap("<leader>la", vim.lsp.buf.code_action, "[L]sp [A]ction")
nmap("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
nmap("<leader>lD", vim.lsp.buf.type_definition, "Type [D]efinition")
nmap("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

-- See `:help K` for why this keymap
nmap("K", vim.lsp.buf.hover, "Hover Documentation")
nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

-- Lesser used LSP functionality
nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
nmap("<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, "[W]orkspace [L]ist Folders")

vim.keymap.set({ "n", "v" }, "<leader>lf", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 2500, -- Default is 1000, disregarded if async = true
	})
end, { desc = "Format or format range if visual" })
