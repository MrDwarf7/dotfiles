-- TODO: SmartSplits over default window resizing?
-- TODO: keep selection when moving between open buffers
-- TODO: Consider other plugins to handle some of the weird things that are scattered in singles (IE: the mini library has several things, buf remove etc etc. + surround)

vim.keymap.set('n', '<Esc>', ':nohl<CR>', { noremap = false, silent = true })
vim.keymap.set('v', '<Esc>', '<Esc>:nohl<CR>', { noremap = false, silent = true })
-- <F1> help
vim.keymap.set('n', '<F3>', ':set nu! rnu!<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F4>', ':set list! list?<CR>', { noremap = false, silent = true })

vim.keymap.set('c', 'Qa', ':qa!<CR>', { noremap = false, silent = true })

-- Universal / Comon sense bindings
vim.keymap.set('i', '<C-BS>', '<C-W>', { noremap = false, silent = true })  -- trying to get Ctrl + Backspace to work
vim.keymap.set('i', 'jj', '<Esc>', { noremap = false, silent = true })      -- j j to exit insert mode
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = false, silent = true })  -- Ctrl + S to save document

vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = false, silent = true }) -- Center viewport on page up / down
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = false, silent = true })

vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set('x', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('x', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Paste over currently selected text without yanking it
vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true })


vim.api.nvim_set_keymap("n", "<leader>nn", ":NoiceDismiss<CR>", { noremap = true })

-- Move lines in normal mode
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<CR>==', { noremap = true, silent = true })
-- Move lines - Insert mode
vim.keymap.set('i', '<A-j>', '<Esc><cmd>m .+1<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('i', '<A-k>', '<Esc><cmd>m .-2<CR>==gi', { noremap = true, silent = true })
-- Move selected line / block of text in visual mode
--[[ vim.keymap.set("v", "<A-j>", "<cmd>m '>+1<CR>gv-gv", { noremap = true, silent = true }) ]]
--[[ vim.keymap.set("v", "<A-k>", "<cmd>m '<-2<CR>gv-gv", { noremap = true, silent = true }) ]]

vim.keymap.set('n', '<Up>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>', { noremap = true, silent = true })

-- Macroing easier use of h/H and l/L to home/end keys
vim.keymap.set('n', 'H', '^', { noremap = false, silent = true })      -- Shift + h (Or just H) to jump to start of line
vim.keymap.set('n', 'L', '$', { noremap = false, silent = true })      -- Shift + l (Or just L) to jump to end of line

vim.keymap.set('v', 'H', '^', { noremap = false, silent = true })      -- Shift + h (Or just H) to jump to start of line
vim.keymap.set('v', 'L', '$', { noremap = false, silent = true })      -- Shift + l (Or just L) to jump to end of line

vim.keymap.set('n', 'y<S-h>', 'y^', { noremap = true, silent = true }) -- Same as above for yanking
vim.keymap.set('n', 'y<S-l>', 'y$', { noremap = true, silent = true }) -- Same as above for yanking

vim.keymap.set('n', 'd<S-h>', 'd^', { noremap = true, silent = true }) -- Same as above for yanking
vim.keymap.set('n', 'd<S-l>', 'd$', { noremap = true, silent = true }) -- Same as above for yanking

--[[ vim.keymap.set('i', '<A-h>', '<Esc>^i', {noremap = false, silent = true }) -- Shift + h (Or just H) to jump to start of line ]]
--[[ vim.keymap.set('i', '<A-l>', '<Esc>$a', {noremap = false, silent = true }) -- Shift + l (Or just L) to jump to end of line ]]

vim.keymap.set(
	'n',
	'<leader>e',
	':Neotree filesystem reveal left toggle<CR>',
	{ noremap = false, silent = true, desc = 'Toggle Explorer' }
) -- File Explorer lol
vim.keymap.set('n', '<leader>~', ':Alpha<CR>', { noremap = false, silent = true, desc = '~Home~' })
-- <F5> Ranger from toggleterm
--[[ vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal left toggle<CR>', {noremap = false, silent = true }) ]]
vim.keymap.set('n', '<F8>', ':ZenMode<CR>', { noremap = false, silent = true, desc = 'ZenMode Toggle' })
--[[ vim.keymap.set('n', '<leader>nm', ':Dispatch npm start<CR>', {noremap = false, silent = true }) ]]
-- Buffers
vim.keymap.set('n', '<leader>b', 'Buffers', { noremap = true, silent = true, desc = '+buffers' })
vim.keymap.set(
	'n',
	'<leader>bd',
	":lua require('mini.bufremove').delete()<CR>",
	{ noremap = true, silent = true, desc = 'Delete Current' }
) -- Close current buffer, needs something tweaked to fix the error when too quick
vim.keymap.set(
	'n',
	'<leader>bw',
	":lua require('mini.bufremove').wipeout()<CR>",
	{ noremap = true, silent = true, desc = 'Wipe All' }
)
--[[ vim.keymap.set('n', '<leader>bdh', ':BDelete! hidden<CR>', {noremap = false, silent = true }) ]]
vim.keymap.set(
	'n',
	'<leader>bl',
	':BufferLineCycleNext<CR>',
	{ noremap = false, silent = true, desc = 'Next (same as Tab)' }
)
vim.keymap.set(
	'n',
	'<leader>bh',
	':BufferLineCyclePrev<CR>',
	{ noremap = false, silent = true, desc = 'Prev (same as S-Tab)' }
)

vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = false, silent = true })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = false, silent = true })

vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { noremap = false, silent = true, desc = 'Pick (move to)' })
vim.keymap.set(
	'n',
	'<leader>bC',
	':BufferLinePickClose<CR>',
	{ noremap = false, silent = true, desc = 'Close with Pick' }
)

vim.keymap.set(
	'n',
	'<leader>x',
	":lua require('mini.bufremove').delete()<CR>",
	{ silent = true, noremap = false, desc = 'Buffer Delete' }
) -- Close current buffer, needs something tweaked to fix the error when too quick

--[[ vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', {noremap = false, silent = true }) ]]
--[[ vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', {noremap = false, silent = true }) ]]

-- General plugin page
vim.keymap.set('n', '<leader>p', 'Plugins/Packages', { noremap = true, silent = true, desc = 'Plugins' })
vim.keymap.set('n', '<leader>pl', ':Lazy<CR>', { noremap = false, silent = true, desc = 'Lazy Plugins' })
vim.keymap.set('n', '<leader>pm', ':Mason<CR>', { noremap = false, silent = true, desc = 'Mason Manager' })

vim.keymap.set(
	'n',
	'<leader>pU',
	":lua require('lazy').update()<CR>",
	{ noremap = true, silent = true, desc = 'Lazy Update' }
)
vim.keymap.set(
	'n',
	'<leader>pS',
	":lua require('lazy').sync()<CR>",
	{ noremap = true, silent = true, desc = 'Lazy Update' }
)

-- Git (Fugitive and Lazygit)
--[[ vim.keymap.set('n', '<leader>gf', ':20G<CR>', {noremap = false, silent = true }) ]]
-- Spectre
vim.keymap.set('n', '<leader>s', 'Spectre', { noremap = true, silent = true, desc = '+Spectre' })
vim.keymap.set(
	'n',
	'<leader>so',
	":lua require('spectre').open()<CR>",
	{ noremap = true, silent = true, desc = 'Spectre Open' }
)
vim.keymap.set(
	'v',
	'<leader>sp',
	":lua require('spectre').open_visual()<CR>",
	{ noremap = true, silent = true, desc = 'Spectre Visual' }
)
vim.keymap.set(
	'n',
	'<leader>sf',
	"viw:lua require('spectre').open_file_search()<CR>",
	{ noremap = true, silent = true, desc = 'Spectre Files' }
)

-- Telescope
vim.keymap.set('n', '<leader>f', 'Find (telescope)', { desc = '+Find (telescope)' })
vim.keymap.set(
	'n',
	'<leader>fb',
	":lua require('config.plugins.telescope').my_buffers()<CR>",
	{ noremap = true, silent = true, desc = 'Find Buffers' }
)
vim.keymap.set(
	'n',
	'<leader>fr',
	":lua require('config.plugins.telescope').my_recents()<CR>",
	{ noremap = true, silent = true, desc = 'Find Recent Files' }
)
vim.keymap.set(
	'n',
	'<leader>fo',
	'<cmd>Telescope oldfiles<CR>',
	{ noremap = true, silent = true, desc = 'Find Old Files (telescope)' }
)

vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[H]elp" })
vim.keymap.set("n", "<leader>fl", require("telescope.builtin").resume, { desc = "[L]ast search" })

vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })


vim.keymap.set(
	'n',
	'<leader>fw',
	":lua require'telescope'.extensions.live_grep_args.live_grep_args()<CR>",
	{ noremap = true, silent = true, desc = 'Find Word' }
)
vim.keymap.set(
	'n',
	'<leader>fs',
	":lua require('telescope.builtin').grep_string()<CR>",
	{ noremap = true, silent = true, desc = 'Find String (under cursor)' }
)
vim.keymap.set(
	'n',
	'<leader>fW',
	":lua require('telescope.builtin').grep_string({ search = vim.fn.input('GREP -> ') })<CR>",
	{ noremap = true, silent = true, desc = 'Find Line (grep)' }
)

vim.keymap.set('n', '<leader>fv', '<cmd>:VenvSelect<CR>', { noremap = true, silent = true, desc = 'Venv Select' })
vim.keymap.set(
	'n',
	'<leader>fc',
	'<cmd>:VenvSelectCached<CR>',
	{ noremap = true, silent = true, desc = 'Venv Select Cached' }
)

vim.keymap.set(
	'n',
	"<leader>'",
	':Telescope neoclip<CR>',
	{ noremap = true, silent = true, desc = 'Clipboard/Registers' }
)
vim.keymap.set(
	'n',
	'<leader>"',
	":lua require('telescope.builtin').marks()<CR>",
	{ noremap = true, silent = true, desc = 'Marks' }
)

--[[ vim.keymap.set('n', '<leader>ts', ":lua require('telescope.builtin').treesitter()<CR>", {noremap = true, silent = true }) ]]
vim.keymap.set(
	'n',
	'<leader>/',
	":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
	{ noremap = true, silent = true, desc = 'Fuzzy Find (buffer)' }
)
vim.keymap.set(
	'n',
	'<leader>ff',
	":lua require('telescope.builtin').find_files()<CR>",
	{ noremap = true, silent = true, desc = 'Find Files' }
)

vim.keymap.set(
	'n',
	'<leader>fP',
	":lua require('config.plugins.telescope').project_files()<CR>",
	{ noremap = true, silent = true, desc = 'Find Project Files' }
)
vim.keymap.set(
	'n',
	'<leader>fP',
	":lua require'telescope'.extensions.repo.list{file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%.local/', '/%.asdf/', '/%.zinit/', '/%.tmux/'}}<CR>",
	{ noremap = true, silent = true, desc = 'Find Patter Extensions' }
)

-- Git
vim.keymap.set('n', '<leader>g', 'Git', { noremap = true, silent = true, desc = '+Git' })
vim.keymap.set(
	'n',
	'<leader>gc',
	":lua require('config.plugins.telescope').my_git_commits()<CR>",
	{ noremap = true, silent = true, desc = 'Git Commits (pending)' }
)
vim.keymap.set(
	'n',
	'<leader>gs',
	":lua require('config.plugins.telescope').my_git_status()<CR>",
	{ noremap = true, silent = true, desc = 'Git Status (check)' }
)
vim.keymap.set(
	'n',
	'<leader>gb',
	":lua require('config.plugins.telescope').my_git_bcommits()<CR>",
	{ noremap = true, silent = true, desc = 'Git bcommits' }
)
vim.keymap.set(
	'n',
	'<leader>gf',
	'<cmd>DiffviewFileHistory<CR>',
	{ noremap = true, silent = true, desc = 'Git Diff File History' }
)

--[[ vim.keymap.set('n', '<leader>gn', ':Neogit<CR>', {noremap = false, desc = 'Neogit'}) ]]
--[[ vim.keymap.set('n', '<leader>gn', ":lua require('neogit').open({ kind = 'split' })<CR>", {noremap = false, desc = 'Neogit'}) ]]
vim.keymap.set('n', '<leader>gd', 'Git Diff', { noremap = true, silent = true, desc = '+Git Diff' })
vim.keymap.set('n', '<leader>gdd', '<cmd>DiffviewOpen<CR>', { noremap = true, silent = true, desc = 'Git Diff Open' })
vim.keymap.set('n', '<leader>gdc', '<cmd>DiffviewClose<CR>', { noremap = true, silent = true, desc = 'Diffview Close' })
--[[ vim.keymap.set('n', '<leader>ns', ":lua require('config.plugins.telescope').my_note()<CR>", {noremap = true, silent = true }) ]]
--[[ vim.keymap.set('n', '<leader>nn', ":lua NewNote()<CR>", {noremap = true, silent = true }) ]]

-- HLSPlsLens
vim.keymap.set(
	'n',
	'n',
	"<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	'n',
	'N',
	"<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set('n', '*', "*<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
vim.keymap.set('n', '#', "#<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
vim.keymap.set('n', 'g*', "g*<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
vim.keymap.set('n', 'g#', "g#<Cmd>lua require('hlslens').start()<CR>", { noremap = true })

-- Toggles
vim.keymap.set('n', '<leader>t', 'Toggles', { noremap = true, silent = true, desc = '+Toggles' })
vim.keymap.set(
	'n',
	'<leader>tl',
	'<cmd>TroubleToggle<cr>',
	{ silent = true, noremap = true, desc = 'LSP/Trouble toggle' }
)
vim.keymap.set(
	'n',
	'<leader>tt',
	'<cmd>TroubleToggle<cr>',
	{ silent = true, noremap = true, desc = 'LSP/Trouble toggle' }
)
vim.keymap.set(
	'n',
	'<leader>te',
	':Neotree filesystem reveal left toggle<CR>',
	{ noremap = false, silent = true, desc = 'Toggle Bar/Explorer' }
) -- File Explorer lol
vim.keymap.set(
	'n',
	'<leader>tb',
	"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
	{ silent = true, noremap = true, desc = 'Toggle Break Point' }
)
--[[ vim.keymap.set("n", "<leader>td", "", {noremap = false, silent = true, desc = "LazyDocker"}) ]]

-- Mini [Basics]
vim.keymap.set('n', '<leader>u', 'UI Toggles', { noremap = false, silent = true, desc = '+UI Toggles' })



vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = false, silent = true, desc = 'Hover Documentation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
	{ noremap = false, silent = true, desc = 'Signature Documentation' })
-- See `:help K` for why this keymap

-- LSP
vim.keymap.set('n', '<leader>l', 'LSP', { noremap = true, silent = true, desc = '+LSP' })
vim.keymap.set('n', '<leader>lh', vim.diagnostic.open_float, { noremap = true, silent = true, desc = 'LSP Float' })
vim.keymap.set('n', '<leader>l]', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = 'LSP Next' })
vim.keymap.set('n', '<leader>l[', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = 'LSP Prev' })
vim.keymap.set(
	'n',
	'<leader>lv',
	'<cmd>:VenvSelectCached<CR>',
	{ noremap = true, silent = true, desc = 'Venv Select Cached' }
)
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = 'LSP Code Action' })

vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
	local conform = require('config/plugins/conform')
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 2500, -- Default is 1000, disregarded if async = true
	})({ noremap = true, silent = true, desc = 'LSP Format' })
end, { desc = 'Format or format range if visual' })

-- Trouble
vim.keymap.set(
	'n',
	'<leader>ft',
	':TodoTrouble keywords=TODO<CR>',
	{ noremap = true, silent = true, desc = "Find Todo's" }
)
--[[ vim.keymap.set('n', '<leader>ff', ':TodoTrouble keywords=FIX,FIXME<CR>', {noremap = true, silent = true }) ]]
--[[ vim.keymap.set('n', '<leader>tn', ':TodoTrouble keywords=NOTE<CR>', {noremap = true, silent = true }) ]]
vim.keymap.set(
	'n',
	'<leader>lt',
	'<cmd>TroubleToggle<cr>',
	{ silent = true, noremap = true, desc = 'LSP/Trouble toggle' }
)
vim.keymap.set(
	'n',
	'<leader>lw',
	'<cmd>Trouble workspace_diagnostics<cr>',
	{ silent = true, noremap = true, desc = 'Workspace diagnostics' }
)
vim.keymap.set(
	'n',
	'<leader>ld',
	'<cmd>Trouble document_diagnostics<cr>',
	{ silent = true, noremap = true, desc = 'Document Diagnostics' }
)
vim.keymap.set('n', '<leader>lj', '<cmd>Trouble loclist<cr>', { silent = true, noremap = true, desc = 'Location List' })
vim.keymap.set('n', '<leader>lq', '<cmd>Trouble quickfix<cr>', { silent = true, noremap = true, desc = 'Quick Fix' })
vim.keymap.set(
	'n',
	'<leader>lR',
	'<cmd>Trouble lsp_references<cr>',
	{ silent = true, noremap = true, desc = 'References' }
)

vim.keymap.set(
	'n',
	'<leader>ll',
	":lua require('lint').try_lint()<CR>",
	{ noremap = true, silent = true, desc = 'Lint' }
)

--[[ vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename(), { silent = true, noremap = true, desc = 'Rename' }) ]]

-- Nvim-dap
vim.keymap.set('n', '<leader>d', 'Debug', { noremap = true, silent = true, desc = '+Debug' })
vim.keymap.set(
	'n',
	'<Leader>dh',
	":lua require('ror.commands').list_commands()<CR>",
	{ silent = true, desc = 'Generate' }
)
vim.keymap.set(
	'n',
	'<leader>dc',
	"<cmd>lua require'dap'.continue()<CR>",
	{ silent = true, noremap = true, desc = 'Continue' }
)
vim.keymap.set(
	'n',
	'<leader>dr',
	"<cmd>lua require'dap'.continue()<CR>",
	{ silent = true, noremap = true, desc = 'Run/Continue' }
)
vim.keymap.set(
	'n',
	'<leader>dR',
	"<cmd>lua require'dap'.run_last()<CR>",
	{ silent = true, noremap = true, desc = 'ReRun last' }
)
vim.keymap.set(
	'n',
	'<leader>ds',
	"<cmd>lua require'dap'.step_over()<CR>",
	{ silent = true, noremap = true, desc = 'Step Over' }
)
vim.keymap.set(
	'n',
	'<leader>di',
	"<cmd>lua require'dap'.step_into()<CR>",
	{ silent = true, noremap = true, desc = 'Step Into' }
)
vim.keymap.set(
	'n',
	'<leader>dO',
	"<cmd>lua require'dap'.step_out()<CR>",
	{ silent = true, noremap = true, desc = 'Step Out (of)' }
)
vim.keymap.set(
	'n',
	'<leader>db',
	"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
	{ silent = true, noremap = true, desc = 'Break Point' }
)
vim.keymap.set(
	'n',
	'<leader>dw',
	":lua require('dapui').toggle()<cr>",
	{ silent = true, noremap = true, desc = 'Toggle Window' }
)
vim.keymap.set(
	'n',
	'<leader>dr',
	"<cmd>lua require'dap'.repl.open()<CR>",
	{ silent = true, noremap = true, desc = 'REPL' }
)
vim.keymap.set(
	'n',
	'<leader>dh',
	"<cmd>lua require'telescope'.extensions.dap.commands{}<CR>",
	{ silent = true, noremap = true, desc = 'Dap Commands (help)' }
)

vim.keymap.set("n", "<leader>fp", require("telescope.builtin").diagnostics, { desc = "[P]roblems" })
vim.keymap.set("n", "<Leader>fn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>", { silent = true })
vim.keymap.set(
	'n',
	'<leader>dl',
	"<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
	{ silent = true, noremap = true, desc = 'Breakpoint List' }
)
vim.keymap.set(
	'n',
	'<leader>dv',
	"<cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
	{ silent = true, noremap = true, desc = 'Variables' }
)
vim.keymap.set(
	'n',
	'<leader>df',
	"<cmd>lua require'telescope'.extensions.dap.frames{}<CR>",
	{ silent = true, noremap = true, desc = 'Frames' }
)
-- Notes & Todo
vim.keymap.set('n', '<leader>n', 'New', { noremap = true, silent = true, desc = '+New things' })
vim.keymap.set(
	'n',
	'<leader>ns',
	":lua require('util.scratches').open_scratch_file()<CR>",
	{ noremap = true, silent = true, desc = 'Scratch File' }
)
vim.keymap.set(
	'n',
	'<leader>nf',
	":lua require('util.scratches').open_scratch_file_floating()<CR>",
	{ noremap = true, silent = true, desc = 'Floating Scratch' }
)
vim.keymap.set(
	'n',
	'<leader>nm',
	":lua require('config.plugins.telescope').my_note()<CR>",
	{ noremap = true, silent = true, desc = 'My Note(s)' }
)
--[[ vim.keymap.set('n', '<leader>nn', ':lua NewNote()<CR>', { noremap = true, silent = true, desc = 'New Note' }) ]]
