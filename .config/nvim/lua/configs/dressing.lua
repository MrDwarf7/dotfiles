return {
	"stevearc/dressing.nvim",
	event = "BufReadPost",
	opts = {
		input = {
			insert_only = false,
			border = "rounded",
		},
		mappings = {
			n = {
				["q"] = "Close",
			},
		},
	},
	-- require("configs.dressing")
}

-- require("dressing").setup({
-- 	input = {
-- 		insert_only = false,
-- 		border = "rounded",
-- 	},
-- 	mappings = {
-- 		n = {
-- 			["q"] = "Close",
-- 		},
-- 	},
-- })
