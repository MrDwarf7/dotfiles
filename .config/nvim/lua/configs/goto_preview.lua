return {
	"rmagatti/goto-preview",
	-- lazy = false,
	opts = {
		default_mappings = false,
	},
	keys = {
		{
			"gpd",
			function()
				return require("goto-preview").goto_preview_definition()
			end,
			desc = "[d]efinition",
		},

		{

			"gpD",
			function()
				return require("goto-preview").goto_preview_declaration()
			end,
			desc = "[D]eclaration",
		},

		{

			"gpr",
			function()
				return require("goto-preview").goto_preview_references()
			end,
			desc = "[r]eferences",
		},

		{
			"gpi",
			function()
				return require("goto-preview").goto_preview_implementation()
			end,
			desc = "[i]mpl",
		},

		{
			"gpt",
			function()
				return require("goto-preview").goto_preview_type_definition()
			end,
			desc = "[t]ype",
		},

		{
			"gP",
			function()
				return require("goto-preview").close_all_win()
			end,
			desc = "close all",
		},
	},
}
