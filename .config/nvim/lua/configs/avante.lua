---@alias LazySpec table
---@alias Builder string

local arch = require("util.architecture")

---@return Builder
local builder = function()
	if vim.g.os == "Windows_NT" then
		return "pwsh -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" ---@type Builder -- for windows
	else
		return "make" ---@type Builder
	end
end

-----@return nil
-- local lib_loader = function()
-- 	if not package.loaded["avante_lib"] then
-- 		---@type fun(): nil
-- 		return require("avante_lib").load()
-- 	end
-- 	---@type fun(): nil
-- 	require("avante_lib").load()
-- end

-- local is_home = os.environ.getenv("HOME_PROFILE") == tostring(true)

-- --- Convert any value to a string and lower case
-- ---@param str any
-- ---@return string
-- local lower_str = function(str)
-- 	return string.format("%s", str):lower()
-- end
--
-- --- Check if the HOME_PROFILE environment variable is set to true
-- ---@return boolean
-- local home_check = function()
-- 	local h = lower_str(lower_str(os.getenv("HOME_PROFILE"))) -- is true if the env variable HOME_PROFILE is set as true, everything else is automatically false
-- 	print("value of h: " .. h)
-- 	if not h then
-- 		return false
-- 	else
-- 		return true
-- 	end
-- end

if arch.should_load() then
	return {
		"yetone/avante.nvim",
		enabled = true,
		event = "InsertEnter",
		lazy = true,
		version = false, -- set this if you want to always pull the latest change
		build = builder(),
		-- build = "make",
		-- build = "pwsh -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = arch.is_windows(),
					},
				},
			},
		},
		keys = {
			{
				"<Leader>ta",
				function()
					return require("avante").toggle()
				end,
				desc = "Toggle Avante",
			},
			{
				"<Leader>tA",
				"<cmd>AvanteClear<CR>",
				desc = "Clear Avante",
			},
		},

		opts = function()
			return {
				provider = "openai",
			}
		end,
		config = function(_, opts)
			require("avante").setup(opts)
		end,
	}
else -- we're on linux lol, return an empty table (This is mostly because Avante early loads avante_lib)
	return {}
end
