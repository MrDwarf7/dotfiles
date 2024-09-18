return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = function()
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

		return {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		}
	end,

	config = function(_, opts)
		return require("nvim-autopairs").setup(opts)
	end,
}
