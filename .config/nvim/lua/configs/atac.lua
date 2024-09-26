return {
	"NachoNievaG/atac.nvim",
	-- lazy = false,
	event = "VeryLazy",
	dependencies = { "akinsho/toggleterm.nvim" },
	keys = {
		{
			"<Leader>pa",
			function()
				require("atac").open()
			end,
			desc = "Open Atac",
		},
	},
	opts = {
		dir = "~/.local/atac_requests",
	},
}
