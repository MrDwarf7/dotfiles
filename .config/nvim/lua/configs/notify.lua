return {
	"rcarriga/nvim-notify",
	lazy = false,
	keys = {
		{
			"<Leader>nn",
			function()
				require("notify").dismiss({ pending = true, silent = true })
			end,
		},
	},
	opts = function()
		vim.notify = require("notify")
		return {
			level = "warn",
			timeout = 2000,
			background_color = "#00000000",
			render = "compact",
			on_open = function(_notify_bufnr, _message_opts)
				-- Check if the current buffer is a TSX file
				-- If so, dismiss the notification/basically turns off the plugin
				if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype") == "typescriptreact" then
					require("notify").dismiss({ pending = true, silent = true })
				end
			end,
		}
	end,
	config = function(_, opts)
		require("notify").setup(opts)
	end,
}
