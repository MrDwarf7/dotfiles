return {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
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
			}
		})
	end,
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
				globals = { "vim", "require" }
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
