return {
	"folke/which-key.nvim", -- config call
	event = "VeryLazy",
	opts = {
		sort = { "local", "alphanum", "order", "group", "mod" },
	},

	init = function()
		local wk = require("which-key")
		wk.add({
			{ "<Leader>a", group = "+[A]vante" },
			{ "<Leader>b", group = "+[B]uffers" },
			{ "<Leader>d", group = "+[D]ebug" },
			{ "<Leader>f", group = "+[F]ind" },
			{ "<Leader>g", group = "+[G]it" },
			{ "<Leader>H", group = "+[H]arpoon" },
			{ "<Leader>h", group = "+[H]unk(s)" },
			{ "<Leader>l", group = "+[L]SP" },
			{ "<Leader>p", group = "+[P]lugins" },
			{ "<Leader>w", group = "+[W]inShift" },
			{ "<Leader>t", group = "+[T]oggles" },
			{ "<Leader>y", group = "+[Y]ank" },
			{ "<Leader>gd", group = "+[D]iffview" },
			{ "<Leader>x", group = "+[T]rouble" },
			{ "<Leader>s", group = "+[D]b" },
			{ "<Leader>n", group = "+[N]otificaitons" },
			{ "<Leader>nn", group = "Dismiss" },

			{ "gp", group = "+[P]review" },

			{ "<Leader>d", group = "+[D]BUI" },
			--
			-- --#region GH.nvim // gh.nvim // github-cli // gh-cli
			-- -- stylua: ignore start
			{ "<Leader>gh", group = "+git[H]ub" },
			{ "<Leader>ghc", group = "+[c]ommits" },
			-- { "<Leader>ghcc", "<cmd>GHCloseCommit<cr>", desc = "Close" },
			-- { "<Leader>ghce", "<cmd>GHExpandCommit<cr>", desc = "Expand" },
			-- { "<Leader>ghco", "<cmd>GHOpenToCommit<cr>", desc = "Open To" },
			-- { "<Leader>ghcp", "<cmd>GHPopOutCommit<cr>", desc = "Pop Out" },
			-- { "<Leader>ghcz", "<cmd>GHCollapseCommit<cr>", desc = "Collapse" },
			--
			{ "<Leader>ghi", group = "+[i]ssues" },
			-- { "<Leader>ghip", "<cmd>GHPreviewIssue<cr>", desc = "Preview" },
			--
			{ "<Leader>ghl", group = "+[l]itree" },
			-- { "<Leader>ghlp", "<cmd>LTPanel<cr>", desc = "Toggle Panel" },
			--
			{ "<Leader>ghr", group = "+[R]eview" },
			-- { "<Leader>ghrb", "<cmd>GHStartReview<cr>", desc = "Begin" },
			-- { "<Leader>ghrc", "<cmd>GHCloseReview<cr>", desc = "Close" },
			-- { "<Leader>ghrd", "<cmd>GHDeleteReview<cr>", desc = "Delete" },
			-- { "<Leader>ghre", "<cmd>GHExpandReview<cr>", desc = "Expand" },
			-- { "<Leader>ghrs", "<cmd>GHSubmitReview<cr>", desc = "Submit" },
			-- { "<Leader>ghrz", "<cmd>GHCollapseReview<cr>", desc = "Collapse" },
			--
			{ "<Leader>ghp", group = "+[p]ull requests" },
			-- { "<Leader>ghpc", "<cmd>GHClosePR<cr>", desc = "Close" },
			-- { "<Leader>ghpd", "<cmd>GHPRDetails<cr>", desc = "Details" },
			-- { "<Leader>ghpe", "<cmd>GHExpandPR<cr>", desc = "Expand" },
			-- { "<Leader>ghpo", "<cmd>GHOpenPR<cr>", desc = "Open" },
			-- { "<Leader>ghpp", "<cmd>GHPopOutPR<cr>", desc = "PopOut" },
			-- { "<Leader>ghpr", "<cmd>GHRefreshPR<cr>", desc = "Refresh" },
			-- { "<Leader>ghpt", "<cmd>GHOpenToPR<cr>", desc = "Open To" },
			-- { "<Leader>ghpz", "<cmd>GHCollapsePR<cr>", desc = "Collapse" },
			--
			{ "<Leader>ght", group = "+[t]hreads" },
			-- { "<Leader>ghtc", "<cmd>GHCreateThread<cr>", desc = "Create" },
			-- { "<Leader>ghtn", "<cmd>GHNextThread<cr>", desc = "Next" },
			-- { "<Leader>ghtt", "<cmd>GHToggleThread<cr>", desc = "Toggle" },
			-- -- stylua: ignore end
			-- --#endregion GH.nvim // gh.nvim // github-cli // gh-cli
			--
		})
		--
	end,
}
