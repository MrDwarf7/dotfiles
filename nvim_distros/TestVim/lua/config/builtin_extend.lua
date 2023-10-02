local M = {}

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local opts_desc = function(desc)
	return {
		noremap = true,
		silent = true,
		desc = desc,
	}
end

M.magic_prefix = ""
M.emmykeymap = function(mode, lhs, rhs)
	lhs = M.magic_prefix .. lhs
	keymap(mode, lhs, rhs, {
		silent = true,
	})
end

keymap("", [[\]], [[<localleader>]], {})

keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("i", "<C-j>", "<Down>", opts)

keymap("i", "<C-i>", "<home>", opts) -- Ctrl i normally goes to top of current function area.
keymap("i", "<C-a>", "<end>", opts)
-- keymap('i', '<C-h>', '<BS>', opts) -- Can map this to Ctrl + Backspace for chunking words somehow...
keymap("i", "<C-d>", "<Del>", opts)
-- keymap('i', '<C-k>', '<C-o>D', opts)

-- Better Movements
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("x", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("x", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Exit insert mode using j-j
keymap("i", "jj", "<Esc>", opts)

-- Centering the screen
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Command Mode - Leave off for now
-- -- cannot use { silent = true } here, the reason is unknown.
-- keymap('c', '<C-b>', '<Left>', { noremap = true })
-- keymap('c', '<C-p>', '<Up>', { noremap = true })
-- keymap('c', '<C-f>', '<Right>', { noremap = true })
-- keymap('c', '<C-n>', '<Down>', { noremap = true })
-- keymap('c', '<C-a>', '<home>', { noremap = true })
-- keymap('c', '<C-e>', '<end>', { noremap = true })
-- keymap('c', '<C-h>', '<BS>', { noremap = true })
-- keymap('c', '<C-d>', '<Del>', { noremap = true })
-- keymap('c', '<C-k>', [[<C-\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<CR>]], { noremap = true })
-- -- do the same as <C-k> in insert mode is a bit complex in cmdline mode.
-- keymap('c', '<A-b>', '<S-Left>', { noremap = true })
-- keymap('c', '<A-f>', '<S-Right>', { noremap = true })

-- keymap('n', '<Leader>mdc', [[:cd %:h|pwd<cr>]], opts)
-- keymap('n', '<Leader>mdu', [[:cd ..|pwd<cr>]], opts)
--
-- keymap('n', '<C-g>', '<ESC>', {})

-- Buffers
-- keymap("n", "<Tab>", "<cmd>bnext<cr>", opts_desc("Buffer Previous"))
-- keymap("n", "<S-Tab>", "<cmd>bprevious<cr>", opts_desc("Buffer Previous"))
-- keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
-- keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
-- keymap("n", "<Tab>", "<cmd>bnext<cr>", opts_desc("Buffer Next"))
-- keymap("n", "<S-Tab>", "<cmd>bprevious<cr>", opts_desc("Buffer Previous"))
--
-- keymap("n", "<leader>`", "<cmd>e #<cr>", opts_desc("Switch to Other Buffer"))
--
-- keymap("n", "<Leader>x", [[:bd!<CR>]], opts_desc("Quick Buffer delete"))
-- keymap("n", "<Leader>bd", [[:bd!<CR>]], opts_desc("buffer delete current one"))
-- keymap("n", "<Leader>bw", [[:bw!<CR>]], opts_desc("buffer wipeout current one"))
-- keymap("n", "<Leader>bn", [[:bprevious<CR>]], opts_desc("buffer next")) -- Swapped these around?
-- keymap("n", "<Leader>bp", [[:bnext<CR>]], opts_desc("buffer previous"))

-- UI / Toggling
keymap("n", "<Leader>uh", "<cmd>nohlsearch<CR>", opts_desc("toggle hlsearch"))
keymap("n", "<Leader>uw", "<cmd>lua vim.wo.wrap = not vim.wo.wrap<CR>", opts_desc("toggle wrap"))
keymap(
	"n",
	"<Leader>uc",
	"<cmd>lua vim.wo.conceallevel = vim.wo.conceallevel == 2 and 0 or 2<CR>",
	opts_desc("toggle conceal")
)

keymap(
	"n",
	"<Leader>tH",
	"<cmd>lua vim.o.cmdheight = vim.o.cmdheight == 0 and 1 or 0<CR>",
	opts_desc("toggle cmdheight")
)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

M.my_augroup = augroup("MyAugroup", {})

autocmd("TextYankPost", {
	group = M.my_augroup,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 80 })
	end,
	desc = "highlight yanked text",
})

function M.ping_cursor()
	vim.o.cursorline = true
	vim.o.cursorcolumn = false

	vim.cmd.redraw()
	vim.cmd.sleep({ "m", count = 1000 })

	vim.o.cursorline = false
	vim.o.cursorcolumn = false
end

command("PingCursor", 'lua require("conf.builtin_extend").ping_cursor()', {})

-- There is 10000000% a plugin that does this, and likely does it better
--
function M.open_URI_under_cursor(use_w3m)
	local function open_uri(uri)
		if type(uri) ~= "nil" then
			uri = string.gsub(uri, "#", "\\#") --double escapes any # signs
			uri = '"' .. uri .. '"'

			if use_w3m then
				vim.cmd.terminal({ "w3m", uri })
				return true
			end

			vim.cmd["!"]({ "open", uri })
			vim.cmd.redraw()
			return true
		else
			return false
		end
	end

	local word_under_cursor = vim.fn.expand("<cWORD>")
	-- any uri with a protocol segment
	local regex_protocol_uri = "%a*:%/%/[%a%d%#%[%]%-%%+:;!$@/?&=_.,~*()]*[^%)]"
	if open_uri(string.match(word_under_cursor, regex_protocol_uri)) then
		return
	end
	-- consider anything that looks like string/string a github link
	local regex_plugin_url = "[%a%d%-%.%_]*%/[%a%d%-%.%_]*"
	if open_uri("https://github.com/" .. string.match(word_under_cursor, regex_plugin_url)) then
		return
	end
end

command("OpenURIUnderCursor", M.open_URI_under_cursor, {})
command("OpenURIUnderCursorWithW3m", function()
	M.open_URI_under_cursor(true)
end, {})

keymap("n", "<Leader>olx", "", {
	callback = M.open_URI_under_cursor,
	noremap = true,
	desc = "open URI under the cursor with xdg-open",
})

keymap("n", "<Leader>olw", "", {
	callback = function()
		M.open_URI_under_cursor(true)
	end,
	noremap = true,
	desc = "open URI under the cursor with w3m",
})

return M
