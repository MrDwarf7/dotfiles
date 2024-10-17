local utils = require("remote-nvim.utils")

local ssh_folder = function()
	if vim.g.os == "Windows_NT" then
		local path = vim.fn.expand("$USERPROFILE") .. "\\.ssh"
		-- Fix slashs
		-- path = string.gsub(path, "\\", "/")
		return path
		-- else
		-- 	return vim.fn.expand("$HOME") .. "/.ssh"
	end
end

return {
	"amitds1997/remote-nvim.nvim",
	lazy = false,
	version = "*", -- Pin to GitHub releases
	dependencies = {
		"nvim-lua/plenary.nvim", -- For standard functions
		"MunifTanjim/nui.nvim", -- To build the plugin UI
		"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
	},
	opts = {
		ssh_config = {

			-- ssh_config = true,
			ssh_config_file_paths = { utils.path_join(true, ssh_folder(), "config") },
		},
		-- offline_mode = {
		-- 	enabled = true,
		-- },
	},
	config = function(o, opts)
		local rem = require("remote-nvim")
		-- Testing if I can force via deep/or access certain nested(s)

		opts = vim.tbl_deep_extend("force", o, opts)

		rem.setup({
			host = "Windows",
			neovim_user_config_path = vim.fn.stdpath("config"),
			ssh_config = {
				ssh_config_file_paths = { utils.path_join(true, ssh_folder(), "config") },
				ssh_binary = "ssh",
				scp_binary = "scp",
			},
		})
		-- rem.setup({
		-- 	neovim_user_config_path = vim.fn.stdpath("config"),
		-- ssh_config = {
		--
		-- 	-- ssh_config = true,
		-- 	ssh_config_file_paths = { utils.path_join(true, ssh_folder(), "config") },
		-- },
		-- })
	end,
}
