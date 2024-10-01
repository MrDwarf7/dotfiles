---@alias LazySpec table

---@return boolean
local abs_path = function()
	if vim.g.os == "Windows_NT" then
		return true
	else
		return false
	end
end

---@alias Builder string

---@return Builder
local builder = function()
	if vim.g.os == "Windows_NT" then
		return "pwsh -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" ---@type Builder -- for windows
	else
		return "make" ---@type Builder
	end
end

---@return nil
local lib_loader = function()
	if not package.loaded["avante_lib"] then
		---@type fun(): nil
		return require("avante_lib").load()
	end
	---@type fun(): nil
	require("avante_lib").load()
end

---@return LazySpec
return {
	"yetone/avante.nvim",
	enabled = false,
	event = { "VeryLazy", "BufReadPost" },
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
					use_absolute_path = abs_path(),
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			lazy = false,
			ft = { "markdown", "Avante" },
			opts = {
				file_types = { "markdown", "Avante" },
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

	-- init = function()
	-- 	lib_loader()
	-- end,

	opts = function()
		-- require("avante_lib").load()
		-- add any opts here
		-- require("avante_lib").load()
		return {
			provider = "openai",
		}
	end,
	config = function(_, opts)
		-- lib_loader()
		require("avante").setup(opts)
		-- require("avante_lib").load()
		-- add any config here
	end,
	-- },
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
}
