local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local MainAutoCmdGroup = augroup("MainAutoCmdGroup", { clear = true })
local LspAuGroup = augroup("LspAuGroup ", { clear = true })

autocmd("BufReadPost", {
	callback = function()
		local last_pos = vim.fn.line("'\"")
		if last_pos > 0 and last_pos <= vim.fn.line("$") then
			vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
		end
	end,
})

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 60 })
	end,
})

autocmd("BufWinEnter", {
	desc = "Make q close help, man, quickfix, dap floats", -- Telescope and Mason and various other things
	group = augroup("q_close_windows", { clear = true }),
	callback = function(args)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
		if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) and vim.fn.maparg("q", "n") == "" then
			vim.keymap.set("n", "q", "<cmd>close<cr>", {
				desc = "Close window",
				buffer = args.buf,
				silent = true,
				nowait = true,
			})
		end
	end,
})

autocmd({ "BufWritePre" }, {
	group = MainAutoCmdGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = LspAuGroup,
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }
		local vimlspbuf = vim.lsp.buf

		vim.keymap.set("n", "K", function()
			vimlspbuf.hover()
		end, opts)

		vim.keymap.set("n", "gd", function()
			vimlspbuf.definition()
		end, opts, { desc = "[d]efinition" })

		vim.keymap.set("n", "gD", function()
			vimlspbuf.declaration()
		end, opts, { desc = "[D]eclaration" })

		vim.keymap.set("n", "gr", function()
			vimlspbuf.references()
		end, opts, { desc = "[r]eferences" })

		vim.keymap.set("n", "<C-k>", function()
			vimlspbuf.signature_help()
		end, opts, { desc = "Signature Help" })

		vim.keymap.set("n", "<Leader>lr", function()
			vimlspbuf.rename()
		end, opts, { desc = "[r]ename" })

		vim.keymap.set("n", "<Leader>lR", function()
			vim.lsp.buf.rename()
		end, opts, { desc = "other [R]ename?" })

		vim.keymap.set({ "n", "v" }, "<Leader>la", function()
			vimlspbuf.code_action()
		end, opts, { desc = "Code [a]ction" })

		vim.keymap.set("n", "<Leader>lf", function()
			vimlspbuf.format({ async = true })
		end, opts, { desc = "[f]ormat (lsp)" })

		vim.keymap.set("n", "<Leader>lh", function()
			vim.diagnostic.open_float()
		end, opts, { desc = "[h]over" })
	end,
})

--- regex used for matching a valid URL/URI string
autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
	desc = "URL Highlighting",
	group = augroup("highlighturl", { clear = true }),
	callback = function()
		local url_matcher =
			"\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+"
		--- Delete the syntax matching rules for URLs/URIs if set
		local function delete_url_match()
			for _, match in ipairs(vim.fn.getmatches()) do
				if match.group == "HighlightURL" then
					vim.fn.matchdelete(match.id)
				end
			end
		end
		--- Add syntax matching rules for highlighting URLs/URIs
		local function set_url_match()
			delete_url_match()
			if vim.g.highlighturl_enabled then
				vim.fn.matchadd("HighlightURL", url_matcher, 15)
			end
		end
		set_url_match()
	end,
})
