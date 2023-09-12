return {
	"mfussenegger/nvim-dap",
	enabled = true,
	dependencies = {
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = { "nvim-dap" },
			enabled = true,
			cmd = { "DapInstall", "DapUninstall" },
			opts = { handlers = {} },
		},
		{
			"rcarriga/nvim-dap-ui",
			enabled = true,
			opts = { floating = { border = "rounded" } },
			config = require("plugins.configs.nvim-dap-ui"),
		},
		{
			"mfussenegger/nvim-dap-python",
			enabled = true,
			-- dependencies = { "mfussenegger/nvim-dap" },
			config = require("plugins.configs.nvim-dap-python"),
		},
		{
			"rcarriga/cmp-dap",
			enabled = true,
			dependencies = { "nvim-cmp" },
			config = require("plugins.configs.cmp-dap"),
		},
	},
	-- event = { "BufNewFile", "BufWritePost" },
}
