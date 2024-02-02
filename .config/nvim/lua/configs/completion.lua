return {
	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		cmd = "Copilot",
		-- event = { "InsertEnter", "BufReadPost" },
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true, -- Temp disabled to test copilot_cmp
					auto_refresh = false, -- This is the default setting
					keymap = {},
				},
				suggestion = {
					enabled = false, -- Temp disabled to test copilot-cmp
					auto_trigger = true,
					keymap = {
						accept = "<C-l>",
						accept_word = "<A-l>",
						next = "<A-]>",
						prev = "<A-[>",
						dismiss = "<C-c>",
					},
				},
				filetypes = { -- Defaults are all false basically
					yaml = true,
					markdown = true,
					help = false,
					gitcommit = true,
					gitrebase = true,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = true,
				},
				copilot_node_command = "node", -- What other ways can it be run??
				server_opts_overrides = {},
			}) -- End of setup fnc

			vim.keymap.set("n", "<Leader>lP", "<cmd>Copilot panel<CR>", { desc = "copilot [P]" })

			-- require("Copilot")
			-- 	require("Copilot").panel()
			-- end, { desc = "copilot [P]anel" })
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		-- lazy = false,
		event = "InsertEnter",
		dependencies = {
			require("configs.completion_sub.cmp_base_deps"),
		},
		-- NOTE: may want to only call a 'deps' file, for the namespaces?
		-- or may keep like this where I call ALL deps, and ALL deps setup funcs in a single call?

		config = function()
			local cmp = require("cmp")
			require("configs.completion_sub.cmp_base_deps")
			local cmp_utils = require("configs.completion_sub.cmp_sub_config")
			local opts = cmp_utils.nvim_cmp_main_opts()

			cmp.setup(opts)
		end,
	},
}
