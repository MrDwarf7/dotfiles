local wk = require("which-key")

wk.setup()
require("which-key").register({
	["<leader>d"] = { name = "+[D]ebug", _ = "which_key_ignore" },
	["<leader>f"] = { name = "+[F]ind", _ = "which_key_ignore" },
	["<leader>g"] = { name = "+[G]it", _ = "which_key_ignore" },
	["<leader>H"] = { name = "+[H]arpoon", _ = "which_key_ignore" },
	["<leader>p"] = { name = "+[P]lugins", _ = "which_key_ignore" },
	["<leader>w"] = { name = "+[W]inShift", _ = "which_key_ignore" },
	["<leader>h"] = { name = "+[H]unk(s)", _ = "which_key_ignore" },
	["<leader>l"] = { name = "+[L]SP", _ = "which_key_ignore" },
	["<leader>b"] = { name = "+[B]uffers", _ = "which_key_ignore" },
})
