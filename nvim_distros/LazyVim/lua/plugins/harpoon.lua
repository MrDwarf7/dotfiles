return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",

	keys = {
		{
			"<Leader>i",
			function()
				require("harpoon"):list():add()
			end,
			desc = "harpoon [i]t",
		},
		{
			"<Leader>H",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			desc = "[H]arpoon menu",
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

	opts = function()
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
