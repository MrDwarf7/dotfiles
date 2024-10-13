local ssh_folder = function()
	if vim.fn.has("win32") == 1 then
		return vim.fn.expand("$USERPROFILE") .. "/.ssh"
	else
		return vim.fn.expand("$HOME") .. "/.ssh"
	end
end

return {
	"amitds1997/remote-nvim.nvim",
	version = "*", -- Pin to GitHub releases
	dependencies = {
		"nvim-lua/plenary.nvim", -- For standard functions
		"MunifTanjim/nui.nvim", -- To build the plugin UI
		"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
	},
	config = true,
}
