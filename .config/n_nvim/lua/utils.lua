local M = {}
local utils = require('lspconfig.util')

M.lazy_load = function(plugin)
	vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
		callback = function()
			local file = vim.fn.expand("%")
			local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

			if condition then
				vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

				-- dont defer for treesitter as it will show slow highlighting
				-- This deferring only happens only when we do "nvim filename"
				if plugin ~= "nvim-treesitter" then
					vim.schedule(function()
						require("lazy").load({ plugins = plugin })

						if plugin == "nvim-lspconfig" then
							vim.cmd("silent! do FileType")
						end
					end, 0)
				else
					require("lazy").load({ plugins = plugin })
				end
			end
		end,
	})
end

M.make_cmd = function(new_config)
	local temp_path = vim.fn.stdpath 'cache'
	if new_config.bundle_path ~= nil then
		local command_fmt =
		[[& '%s/PowerShellEditorServices/Start-EditorServices.ps1' -BundledModulesPath '%s' -LogPath '%s/powershell_es.log' -SessionDetailsPath '%s/powershell_es.session.json' -FeatureFlags @() -AdditionalModules @() -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 -Stdio -LogLevel Normal]]
		local command = command_fmt:format(new_config.bundle_path, new_config.bundle_path, temp_path, temp_path)
		return { new_config.shell, '-NoLogo', '-NoProfile', '-Command', command }
	end
end

M.powershell_es = function()
	return {
		default_config = {
			shell = 'pwsh',
			on_new_config = function(new_config, _)
				-- Don't overwrite cmd if already set
				if not new_config.cmd then
					new_config.cmd = M.make_cmd(new_config)
				end
			end,

			filetypes = { 'ps1' },
			root_dir = utils.find_git_ancestor,
			single_file_support = true,
		}
	}
end


return M
