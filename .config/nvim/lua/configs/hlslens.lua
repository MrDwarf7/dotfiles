local hlk_opts = { noremap = true, silent = true }

return {
	"kevinhwang91/nvim-hlslens",
	event = "VeryLazy",
	config = function()
		require("hlslens").setup({
			override_lens = function(render, posList, nearest, idx, relIdx)
				local srchf = vim.v.searchforward == 1
				local indicator, text, chunks
				local absRelIdx = math.abs(relIdx)
				if absRelIdx > 1 then
					indicator = ("%d%s"):format(absRelIdx, srchf ~= (relIdx > 1) and "▲" or "▼")
				elseif absRelIdx == 1 then
					indicator = srchf ~= (relIdx == 1) and "▲" or "▼"
				else
					indicator = ""
				end

				local lnum, col = unpack(posList[idx])
				if nearest then
					local count = #posList
					if indicator ~= "" then
						text = ("[%s %d/%d]"):format(indicator, idx, count)
					else
						text = ("[%d/%d]"):format(idx, count)
					end
					chunks = { { " " }, { text, "HlSearchLensNear" } }
				else
					text = ("[%s %d]"):format(indicator, idx)
					chunks = { { " " }, { text, "HlSearchLens" } }
				end
				render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
			end,
		})

		vim.api.nvim_set_keymap(
			"n",
			"n",
			[[<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
			hlk_opts
		)
		vim.api.nvim_set_keymap(
			"n",
			"N",
			[[<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
			hlk_opts
		)
		vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], hlk_opts)
		vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], hlk_opts)
		vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], hlk_opts)
		vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], hlk_opts)

		local function nN(char)
			local ok, winid = require("hlslens").nNPeekWithUFO(char)
			if ok and winid then
				vim.keymap.set("n", "<CR>", function()
					return "<Tab><CR>"
				end, { buffer = true, remap = true, expr = true })
			end
		end

		vim.keymap.set({ "n", "x" }, "n", function()
			nN("n")
		end)

		vim.keymap.set({ "n", "x" }, "N", function()
			nN("N")
		end)
	end,
}
