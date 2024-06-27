return {
	"ThePrimeagen/harpoon",
	lazy = true,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {},

	keys = {
		{
			"<Leader>i",
			function()
				require("harpoon"):list():add()
			end,
			desc = "harpoon [i]t",
		},
		{
			"<Leader>I",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			desc = "[h]arpoon menu",
		},
		{
			"<Leader>H1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "harpoon [1]",
		},
		{
			"<Leader>H2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "harpoon [2]",
		},
		{
			"<Leader>H3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "harpoon [3]",
		},
		{
			"<Leader>H4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "harpoon [4]",
		},
		{
			"<Leader>H5",
			function()
				require("harpoon"):list():select(5)
			end,
			desc = "harpoon [5]",
		},
		{
			"<Leader>[",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "harpoon [p]rev",
		},
		{
			"<Leader>]",
			function()
				require("harpoon"):list():next()
			end,
			desc = "harpoon [n]ext",
		},
		{
			"[i",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "harpoon [p]rev",
		},
		{
			"]i",
			function()
				require("harpoon"):list():next()
			end,
			desc = "harpoon [n]ext",
		},
	},
	config = function(_, opts)
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end
			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = require("telescope.config").values.file_previewer({}),
					sorter = require("telescope.config").values.generic_sorter({}),
				})
				:find()
		end
		local map = vim.keymap.set

		map("n", "<Leader>fi", function()
			toggle_telescope(require("harpoon"):list())
		end, { desc = "Open Harpoon" })
	end,
}
