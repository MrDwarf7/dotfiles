return {
	"ThePrimeagen/harpoon",
	lazy = true,
	branch = "harpoon2",
	event = "BufWinEnter",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	opts = {},
	keys = function()
		local keys = {
			{
				"<Leader>i",
				function()
					return require("harpoon"):list():add()
				end,
				desc = "harpoon [i]t",
			},
			{
				"<Leader>fh",
				function()
					return require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
				desc = "[h]arpoon menu",
			},
			{
				"<C-z>",
				function()
					return require("harpoon"):list():prev()
				end,
				desc = "harpoon [p]rev",
			},
			{
				"<C-x>",
				function()
					return require("harpoon"):list():next()
				end,
				desc = "harpoon [n]ext",
			},
			{
				"[i",
				function()
					return require("harpoon"):list():prev()
				end,
				desc = "harpoon [p]rev",
			},
			{
				"]i",
				function()
					return require("harpoon"):list():next()
				end,
				desc = "harpoon [n]ext",
			},
		}

		for i = 1, 5 do
			table.insert(keys, {
				"<Leader>" .. i,
				function()
					require("harpoon"):list():select(i)
				end,
				desc = "Harpoon to " .. i,
			})
		end

		return keys
	end,

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
			return toggle_telescope(require("harpoon"):list())
		end, { desc = "Open Harpoon" })
	end,
}
