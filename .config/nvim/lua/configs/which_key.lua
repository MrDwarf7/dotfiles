return {

	"folke/which-key.nvim", -- config call
	event = "VeryLazy",
	opts = {
		register = {
			["<Leader>b"] = { name = "+[B]uffers", _ = "which_key_ignore" },
			["<Leader>d"] = { name = "+[D]ebug", _ = "which_key_ignore" },
			["<Leader>f"] = { name = "+[F]ind", _ = "which_key_ignore" },
			["<Leader>g"] = { name = "+[G]it", _ = "which_key_ignore" },
			["<Leader>H"] = { name = "+[H]arpoon", _ = "which_key_ignore" },
			["<Leader>h"] = { name = "+[H]unk(s)", _ = "which_key_ignore" },
			["<Leader>l"] = { name = "+[L]SP", _ = "which_key_ignore" },
			["<Leader>p"] = { name = "+[P]lugins", _ = "which_key_ignore" },
			["<Leader>w"] = { name = "+[W]inShift", _ = "which_key_ignore" },
			["<Leader>gd"] = { name = "+[D]iffview", _ = "which_key_ignore" },
			["gp"] = { name = "+[P]review", _ = "which_key_ignore" },
		},
	},
}
