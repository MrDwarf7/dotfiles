local harpoon_main = require("harpoon")
local telescope_conf = require("telescope.config").values

local map = vim.keymap.set

harpoon_main.setup()

map("n", "<Leader>i", function()
	harpoon_main:list():append()
end, { desc = "harpoon [i]t" })

map("n", "<Leader>Hh", function()
	harpoon_main.ui:toggle_quick_menu(harpoon_main:list())
end, { desc = "[h]arpoon menu" })

map("n", "<Leader>H1", function()
	harpoon_main:list():select(1)
end, { desc = "harpoon [1]" })

map("n", "<Leader>H2", function()
	harpoon_main:list():select(2)
end, { desc = "harpoon [2]" })

map("n", "<Leader>H3", function()
	harpoon_main:list():select(3)
end, { desc = "harpoon [3]" })

map("n", "<Leader>H4", function()
	harpoon_main:list():select(4)
end, { desc = "harpoon [4]" })

map("n", "<Leader>H5", function()
	harpoon_main:list():select(5)
end, { desc = "harpoon [5]" })

map("n", "<Leader>[", function()
	harpoon_main:list():prev()
end, { desc = "harpoon [p]rev" })

map("n", "<Leader>]", function()
	harpoon_main:list():next()
end, { desc = "harpoon [n]ext" })

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
			previewer = telescope_conf.file_previewer({}),
			sorter = telescope_conf.generic_sorter({}),
		})
		:find()
end

map("n", "<Leader>fi", function()
	toggle_telescope(harpoon_main:list())
end, { desc = "Open Harpoon" })
