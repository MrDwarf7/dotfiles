local map = vim.keymap.set

require("harpoon").setup()

map("n", "<Leader>i", function()
	require("harpoon"):list():append()
end, { desc = "harpoon [i]t" })

map("n", "<Leader>I", function()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, { desc = "[h]arpoon menu" })

map("n", "<Leader>H1", function()
	require("harpoon"):list():select(1)
end, { desc = "harpoon [1]" })

map("n", "<Leader>H2", function()
	require("harpoon"):list():select(2)
end, { desc = "harpoon [2]" })

map("n", "<Leader>H3", function()
	require("harpoon"):list():select(3)
end, { desc = "harpoon [3]" })

map("n", "<Leader>H4", function()
	require("harpoon"):list():select(4)
end, { desc = "harpoon [4]" })

map("n", "<Leader>H5", function()
	require("harpoon"):list():select(5)
end, { desc = "harpoon [5]" })

map("n", "<Leader>[", function()
	require("harpoon"):list():prev()
end, { desc = "harpoon [p]rev" })

map("n", "<Leader>]", function()
	require("harpoon"):list():next()
end, { desc = "harpoon [n]ext" })

-- Not entirely required, but can keep or remove idk
map("n", "[i", function()
	require("harpoon"):list():prev()
end, { desc = "harpoon [p]rev" })

map("n", "]i", function()
	require("harpoon"):list():next()
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
			previewer = require("telescope.config").values.file_previewer({}),
			sorter = require("telescope.config").values.generic_sorter({}),
		})
		:find()
end

map("n", "<Leader>fi", function()
	toggle_telescope(require("harpoon"):list())
end, { desc = "Open Harpoon" })
