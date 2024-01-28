return {
    "sindrets/winshift.nvim",
    event = "BufEnter",
    config = function()
        local silent_opts = {
            noremap = true,
            silent = true
        }

        vim.keymap.set('n', '<Leader>w', ":WinShift<CR>", silent_opts, { desc = "[W]inshift" })
        vim.keymap.set('n', '<Leader>wh', ":WinShift left<CR>", silent_opts, { desc = "[W]inshift" })
        vim.keymap.set('n', '<Leader>wj', ":WinShift down<CR>", silent_opts, { desc = "[W]inshift" })
        vim.keymap.set('n', '<Leader>wk', ":WinShift up<CR>", silent_opts, { desc = "[W]inshift" })
        vim.keymap.set('n', '<Leader>wl', ":WinShift right<CR>", silent_opts, { desc = "[W]inshift" })

        vim.keymap.set('n', '<Leader>wH', ":WinShift far_left<CR>", silent_opts, { desc = "[W]inshift" })
        vim.keymap.set('n', '<Leader>wJ', ":WinShift far_down<CR>", silent_opts, { desc = "[W]inshift" })
        vim.keymap.set('n', '<Leader>wK', ":WinShift far_up<CR>", silent_opts, { desc = "[W]inshift" })
        vim.keymap.set('n', '<Leader>wL', ":WinShift far_right<CR>", silent_opts, { desc = "[W]inshift" })
    end
}
