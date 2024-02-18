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

-- go to last loc when opening a buffer
-- autocmd('BufReadPost', {
--     callback = function()
--         local mark = vim.api.nvim_buf_get_mark(0, '"')
--         local lcount = vim.api.nvim_buf_line_count(0)
--         if mark[1] > 0 and mark[1] <= lcount then
--             pcall(vim.api.nvim_win_set_cursor, 0, mark)
--         end
--     end,
-- })

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
		require("fidget").setup()

		local opts = { silent = true, nowait = true, buffer = ev.buf }

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)


		vim.keymap.set("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
			-- vim.lsp.buf.definition()
		end, opts, { desc = "[d]efinition" })


		-- vim.keymap.set("n", "gd", function()
		-- 	vim.lsp.buf.definition()
		-- end, opts, { desc = "[d]efinition" })

		vim.keymap.set("n", "gD", function()
			vim.lsp.buf.declaration()
		end, opts, { desc = "[D]eclaration" })

		vim.keymap.set("n", "gr", function()
			require("telescope.builtin").lsp_references()
			-- vim.lsp.buf.references()
		end, opts, { desc = "[r]eferences" })

		-- vim.keymap.set("n", "gr", function()
		-- 	vim.lsp.buf.references()
		-- end, opts, { desc = "[r]eferences" })

		vim.keymap.set("n", "gi", function()
			require("telescope.builtin").lsp_implementations()
			-- vim.lsp.buf.implementation()
		end, opts, { desc = "[i]mplementations" })


		-- vim.keymap.set("n", "gi", function()
		-- 	vim.lsp.buf.implementation()
		-- end, opts, { desc = "[i]mplementations" })


		vim.keymap.set("n", "gt", function()
			require("telescope.builtin").lsp_type_definitions()
			-- vim.lsp.buf.type_definition()
		end, opts, { desc = "[T]ype" })


		-- vim.keymap.set("n", "gt", function()
		-- 	vim.lsp.buf.type_definition()
		-- end, opts, { desc = "[T]ype" })

		vim.keymap.set("n", "<Leader>ls", function() -- new
			require("telescope.builtin").lsp_document_symbols()
		end, opts, { desc = "doc [s]ymbols" })

		vim.keymap.set("n", "<Leader>lS", function() -- new
			require("telescope.builtin").lsp_dynamic_workspace_symbols()
		end, opts, { desc = "[W]orkspace [S]ymbols" })


		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next()
		end, opts, { desc = "[diag] next" })

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev()
		end, opts, { desc = "[diag] prev" })

		vim.keymap.set("n", "gI", function()
			vim.lsp.buf.incoming_calls()
		end, opts, { desc = "[i]ncoming" })

		vim.keymap.set("n", "gO", function()
			vim.lsp.buf.outgoing_calls()
		end, opts, { desc = "[O]utgoing" })

		-- vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" }) -- Prefer <Leader>ft as Find Todos using telescope

		vim.keymap.set("n", "<C-k>", function()
			vim.lsp.buf.signature_help()
		end, opts, { desc = "Signature Help" })

		vim.keymap.set("n", "<Leader>lR", function()
			vim.lsp.buf.rename()
		end, opts, { desc = "[R]ename" })


		-- vim.keymap.set({ "n", "v" }, "<Leader>la", function()
		-- 	vim.lsp.buf.code_action()
		-- end, opts, { desc = "Code [a]ction" })

		vim.keymap.set("n", "<Leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, opts, { desc = "[f]ormat (lsp)" })

		-- vim.keymap.set("n", "<Leader>lh", function() ------ Now handled via lspsaga
		-- 	vim.diagnostic.open_float()
		-- end, opts, { desc = "[h]over" })

		vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })
		-- LSP attach autocmds are called within the autocmds file (group = LspAuGroup)
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

-- Auto resize window splits
autocmd("VimResized", {
	command = "wincmd =",
	group = MainAutoCmdGroup,
})

autocmd("BufEnter", {
	pattern = "gitconfig",
	callback = function()
		vim.opt.filetype = "gitconfig"
	end,
	group = MainAutoCmdGroup,
})

vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Auto select virtualenv Nvim open",
	pattern = "*",
	callback = function()
		local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
		if venv ~= "" then
			require("venv-selector").retrieve_from_cache()
		end
	end,
	once = true,
})
