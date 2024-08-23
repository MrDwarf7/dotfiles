return {
	"folke/which-key.nvim", -- config call

	opts = {
		defaults = {},
		spec = {
			{
				mode = { "n", "v" },
				{ "<Leader>b", group = "+[B]uffers" },
				{ "<Leader>p", group = "+[P]lugins" },
				{ "<Leader>f", group = "+[F]ind" },
				{ "<Leader>l", group = "+[L]SP" },
				{ "<Leader>g", group = "+[G]it" },
				{ "<Leader>gd", group = "+[D]iffview" },
				{ "<Leader>h", group = "+[H]unk(s)" },
				{ "<Leader>d", group = "+[D]ebug" },
				{ "<Leader>H", group = "+[H]arpoon" },
				{ "<Leader>w", group = "+[W]inShift" },
				{ "<Leader>t", group = "+[t]oggles" },
			},
		},
	},
}
