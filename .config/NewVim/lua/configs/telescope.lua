local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

-- local previewer = require("telescope.previewers")

local trouble = require("trouble.providers.telescope")

local cmd = vim.cmd
local map = vim.keymap.set

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- require("fzy_native")
-- require("live_grep_args")
-- require("neoclip")
-- require("notify")
require("configs.local_telescope_plugins.harpoon")

-- require("telescope").load_extension("notify")

telescope.setup({
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
                -- preview_width = 0.55,
                -- results_width = 0.8,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules", ".venv", "venv" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        prompt_prefix = "   ",
        selection_caret = "|> ",
        winblend = 12,
        border = {},
        set_env = { ["COLORTERM"] = "truecolor" },
        color_devicons = true,
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,

                ["<C-p>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.move_selection_next,

                ["<C-t>"] = trouble.open_with_trouble,
                ["<C-q>"] = actions.close,
                ["<C-d>"] = actions.delete_buffer,
            },
            n = {
                ["q"] = actions.close,
                ["<C-q>"] = actions.close,
                ["<esc>"] = actions.close,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.move_selection_next,
                ["<C-d>"] = actions.delete_buffer,
            },
        },
    },
    -------------------------------------------------
})


-- Mappings for telescope, that aren't part of pickers etc.
map("n", "<Leader>ff", builtin.find_files, { desc = "[f]iles" })
map("n", "<Leader>fw", builtin.live_grep, { desc = "[w]ord" })
map("n", "<Leader>fb", builtin.buffers, { desc = "[b]uffers" })
map("n", "<Leader>fr", builtin.oldfiles, { desc = "[r]ecents" })
map("n", "<Leader>fl", builtin.resume, { desc = "[l]ast search" })
map("n", "<Leader>f'", builtin.marks, { desc = "[']marks" })
map("n", "<Leader>fj", builtin.jumplist, { desc = "[j]ump list" })
map("n", "<Leader>fp", builtin.diagnostics, { desc = "[p]roblems (telescope)" })
map("n", "<Leader>fV", builtin.vim_options, { desc = "[v]im options browser" })

map("n", "<Leader>ft", ":TodoTelescope<CR>", { desc = "[t]odo's" })

map("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer]" })

map(
    "n",
    '<Leader>f"',
    ":Telescope neoclip<CR>",
    { noremap = true, silent = true, desc = "Clipboard/Registers" }
)

map({ "n", "v" }, "<Leader>fs", function()
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word })
end, { desc = "[s]earch [w]ord" })

map({ "n", "v" }, "<Leader>fS", function()
    local word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word })
end, { desc = "[S]earch [W]ORD" })


-- Telescope extension setups
-------------------------------------------------

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("neoclip")
require("telescope").load_extension("harpoon")


-- NOTE: Add 'extension' mappings here later

-- Niche autocmd to fix TS highlinging in preview buffer windows

-- autocmd("User", {
--     pattern = "TelescopePreviewwerLoaded",
--     callback = function()
--         vim.opt_local.splitkeep = "cursor"
--     end,
--     group = augroup("TelescopePluginEvents", {}),
-- })
