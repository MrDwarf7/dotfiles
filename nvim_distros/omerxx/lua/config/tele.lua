require("telescope").load_extension("harpoon")
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("live_grep_args")

local M = {}

local trouble = require("trouble.providers.telescope")
local actions = require("telescope.actions")
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "bottom",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-n>"] = actions.move_selection_next,
				["<c-t>"] = trouble.open_with_trouble,
				['<c-d>'] = actions.delete_buffer,
				--[[ ["<esc>"] = actions.close, ]]
				["<C-q>"] = actions.close,
			},
			n = {
				["q"] = actions.close,
				["<C-q>"] = actions.close,
				["<esc>"] = actions.close,
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-n>"] = actions.move_selection_next,
				['<c-d>'] = actions.delete_buffer,
			},
		},
	},
})

M.extensions = {
	fzy = {
		override_generic_sorter = false,
		override_file_sorter = true,
	},
}

M.previewers = require("telescope.previewers")
M.delta = M.previewers.new_termopen_previewer({
	get_command = function(entry)
		-- this is for status
		-- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
		-- just do an if and return a different command
		if entry.status == " D" then
			return
		end

		if entry.status == "??" then
			return { "bat", "--style=plain", "--pager", "less -R", entry.value }
		end

		return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value }
	end,
})

--[[ 		mappings = { ]]
--[[ 			i = { ]]
--[[ 				["<C-u>"] = false, ]]
--[[ 				["<C-d>"] = false, ]]
--[[ 				["<C-j>"] = require("telescope.actions").move_selection_next, ]]
--[[ 				["<C-k>"] = require("telescope.actions").move_selection_previous, ]]
--[[ 			}, ]]
--[[ 		}, ]]
--[[ 	}, ]]
--[[ }) ]]

-- Enable telescope fzf native, if installed
--pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "[F]ind [R]ecents" })

vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[H]elp" })

vim.keymap.set("n", "<leader>fs", require("telescope.builtin").grep_string, { desc = "[S]tring" })
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[D]iagnostics" })
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[B]uffers" })
vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status, { desc = "[G]it [S]tatus" })

vim.keymap.set("n", "<leader>fm", ":Telescope harpoon marks<CR>", { silent = true, desc = "Harpoon [M]arks" })
vim.keymap.set("n", "<Leader>gw", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
	{ silent = true })

--vim.keymap.set("n", "<Leader>sR", "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", silent)
vim.keymap.set("n", "<Leader>\\", "<CMD>lua require('telescope').extensions.notify.notify()<CR>", { silent = true })

return M
