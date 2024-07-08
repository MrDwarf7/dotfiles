return {
	"ray-x/go.nvim",
	lazy = false,
	ft = { "go", "gomod" },
	event = { "CmdlineEnter" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	dependencies = { -- optional packages
		{ "ray-x/guihua.lua" },
		{ "neovim/nvim-lspconfig" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	config = function()
		require("go").setup()
	end,
}
