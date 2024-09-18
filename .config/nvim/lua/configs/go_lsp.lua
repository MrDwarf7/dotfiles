return {
	"ray-x/go.nvim",
	lazy = true,
	ft = { "go", "gomod" },
	event = { "CmdlineEnter" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	dependencies = { -- optional packages
		{ "ray-x/guihua.lua" },
		{ "neovim/nvim-lspconfig", lazy = true },
		{ "nvim-treesitter/nvim-treesitter", lazy = true },
	},
	config = function()
		return require("go").setup()
	end,
}
