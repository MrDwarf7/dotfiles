return {
	"nvim-telescope/telescope.nvim",

	keys = function()
		return {
			{
				"<Leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "[f]iles",
			},

			{
				"<Leader>fw",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "[w]ord",
			},

			{
				"<Leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "[b]uffers",
			},

			{
				"<Leader>fr",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "[r]ecents",
			},

			{
				"<Leader>fl",
				function()
					require("telescope.builtin").resume()
				end,
				desc = "[l]ast search",
			},

			{
				"<Leader>fj",
				function()
					require("telescope.builtin").jumplist()
				end,
				desc = "[j]ump list",
			},

			{
				"<Leader>fV",
				function()
					require("telescope.builtin").vim_options()
				end,
				desc = "[v]im options browser",
			},

			{
				"<Leader>fg",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "[g]it files",
			},

			{
				"<Leader>fm",
				function()
					require("telescope.builtin").marks()
				end,
				desc = "[m]arks",
			},

			{
				"<Leader>fp",
				function()
					require("trouble").toggle()
				end,
				desc = "[p]roblems - trouble",
			},

			{
				"<Leader>fd",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "[d]iagnostics (same as ld)",
			},

			{
				"<Leader>pr",
				function()
					require("telescope.builtin").reloader()
				end,
				desc = "[r]eloader",
			},

			{ "<Leader>ft", ":TodoTelescope<CR>", desc = "[t]odo's" },

			{
				"<leader>/",
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "[/] Fuzzily search in current buffer]",
			},

			{ '<Leader>f"', ":Telescope neoclip<CR>", noremap = true, silent = true, desc = "Clipboard/Registers" },

			{
				"<Leader>fs",
				function()
					local word = vim.fn.expand("<cword>")
					require("telescope.builtin").grep_string({ search = word })
				end,
				desc = "[s]earch [w]ord",
				mode = { "n", "v" },
			},

			{
				"<Leader>fS",
				function()
					local word = vim.fn.expand("<cWORD>")
					require("telescope.builtin").grep_string({ search = word })
				end,
				desc = "[S]earch [W]ORD",
				mode = { "n", "v" },
			},
		}
	end,
}
