-- vim.lsp.config("lua_ls", {
-- 	on_init = function(client)
-- 		if client.workspace_folders then
-- 			local path = client.workspace_folders[1].name
-- 			if
-- 					path ~= vim.fn.stdpath("config")
-- 					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
-- 			then
-- 				return
-- 			end
-- 		end
--
-- 		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using (most
-- 				-- likely LuaJIT in the case of Neovim)
-- 				version = "LuaJIT",
-- 				-- Tell the language server how to find Lua modules same way as Neovim
-- 				-- (see `:h lua-module-load`)
-- 				path = {
-- 					"lua/?.lua",
-- 					"lua/?/init.lua",
-- 				},
-- 			},
-- 			-- Make the server aware of Neovim runtime files
-- 			workspace = {
-- 				checkThirdParty = false,
-- 				library = {
-- 					vim.env.VIMRUNTIME,
-- 					-- Depending on the usage, you might want to add additional paths
-- 					-- here.
-- 					-- '${3rd}/luv/library'
-- 					-- '${3rd}/busted/library'
-- 				},
-- 				-- Or pull in all of 'runtimepath'.
-- 				-- NOTE: this is a lot slower and will cause issues when working on
-- 				-- your own configuration.
-- 				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
-- 				-- library = {
-- 				--   vim.api.nvim_get_runtime_file('', true),
-- 				-- }
-- 			},
-- 		})
-- 	end,
-- 	settings = {
-- 		Lua = {},
-- 	},
-- })

---@type vim.lsp.config
return {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = true,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,

	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},

	settings = {
		Lua = {
			runtime = {
				version = "luaJIT",
				path = vim.split(package.path, ";"),
			},
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				disable = { "missing-fields" },
				globals = { "vim", "require" },
			},
			workspace = {

				checkThirdParty = true,
				library = {
					vim.env.VIMRUNTIME,
					vim.api.nvim_get_runtime_file("", true),
					"$VIMRUNTIME",
					"$VIMRUNTIME/lua",
					"${3rd}/luv/library",
					"${3rd]/busted/library",
					"${3rd]/luaassert/library",
					"lua",
				},
			},
			codeLens = {
				enable = true,
				completion = {
					callSnippet = "Replace",
				},
				doc = {
					privateName = { "^_" },
				},
				hint = {
					enable = true,
					setType = false,
					paramType = true,
					paramName = "Disable",
					semicolon = "Disable",
					arrayIndex = "Disable",
				},
				library = {
					vim.env.VIMRUNTIME,
					vim.api.nvim_get_runtime_file("", true),
					"$VIMRUNTIME",
					"$VIMRUNTIME/lua",
					"${3rd}/luv/library",
					"${3rd]/busted/library",
					"${3rd]/luaassert/library",
					"lua",
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
