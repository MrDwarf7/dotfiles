require("marks").setup({
	default_mappings = true,
})

require("which-key").register({
	["m*"] = { name = "Set [m]ark abc/xyz etc.", _ = "which_key_ignore" },
	["m,"] = { name = "[m]ark - Next avail (abc)", _ = "which_key_ignore" },
	["m;"] = { name = "[m]ark - Next avail (curr. line)", _ = "which_key_ignore" },
	["dm*"] = { name = "[m]ark - delete mark abc/xyz", _ = "which_key_ignore" },

	["dm-"] = { name = "[m]ark - Delete all marks on curr. line", _ = "which_key_ignore" },
	["dm<Leader>"] = { name = "[m]ark - Delete all marks in curr. buff", _ = "which_key_ignore" },

	["m]"] = { name = "Next [m]ark", _ = "which_key_ignore" },
	["m["] = { name = "Prev [m]ark", _ = "which_key_ignore" },

	["m:"] = { name = "Preview mark (prompt via preview)", _ = "which_key_ignore" },

	["m0"] = { name = "[m]ark - group 0", _ = "which_key_ignore" },
	["m1"] = { name = "[m]ark - group 1", _ = "which_key_ignore" },
	["m2"] = { name = "[m]ark - group 2", _ = "which_key_ignore" },
	["m3"] = { name = "[m]ark - group 3", _ = "which_key_ignore" },
	["m4"] = { name = "[m]ark - group 4", _ = "which_key_ignore" },
	["m5"] = { name = "[m]ark - group 5", _ = "which_key_ignore" },
	["m6"] = { name = "[m]ark - group 6", _ = "which_key_ignore" },
	["m7"] = { name = "[m]ark - group 7", _ = "which_key_ignore" },
	["m8"] = { name = "[m]ark - group 8", _ = "which_key_ignore" },
	["m9"] = { name = "[m]ark - group 9", _ = "which_key_ignore" },

	["dm0"] = { name = "[m]ark - delete group 0", _ = "which_key_ignore" },
	["dm1"] = { name = "[m]ark - delete group 1", _ = "which_key_ignore" },
	["dm2"] = { name = "[m]ark - delete group 2", _ = "which_key_ignore" },
	["dm3"] = { name = "[m]ark - delete group 3", _ = "which_key_ignore" },
	["dm4"] = { name = "[m]ark - delete group 4", _ = "which_key_ignore" },
	["dm5"] = { name = "[m]ark - delete group 5", _ = "which_key_ignore" },
	["dm6"] = { name = "[m]ark - delete group 6", _ = "which_key_ignore" },
	["dm7"] = { name = "[m]ark - delete group 7", _ = "which_key_ignore" },
	["dm8"] = { name = "[m]ark - delete group 8", _ = "which_key_ignore" },
	["dm9"] = { name = "[m]ark - delete group 9", _ = "which_key_ignore" },

	["m}"] = { name = "[m]ark - Same type (next)", _ = "which_key_ignore" },
	["m{"] = { name = "[m]ark - Same type (prev)", _ = "which_key_ignore" },

	["dm="] = { name = "[m]ark - Delete bookmark under cursor", _ = "which_key_ignore" },
})
