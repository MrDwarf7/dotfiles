-- Inspired by - "swaits/lazyjj.nvim" and the lazygit.nvim plugin
return {
	-- -- from production branch --
	-- "mrdwarf7/lazyjui.nvim",
	-- dev = false,

	-- -- from local FS / Dev --
	"lazyjui.nvim",
	dev = true,

	lazy = true,
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
    -- stylua: ignore start
    { "<Leader>aa", function() require("lazyjui").open() end, desc = "LazyJui [a]ll" },
		-- stylua: ignore end
	},
	---@type lazyjui.Opts
	opts = {
		cmd = { "jjui", "-r", "all()" },
		winblend = 0,
	},
	-- config = function(_, opts)
	--   require("lazyjui").setup({
	--     cmd = { "jjui", "-r", "all()" },
	--     winblend = 20,
	--   })
	-- end,
}
