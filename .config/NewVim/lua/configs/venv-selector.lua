local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set
local fn = vim.fn

local venv_select = require("venv-selector")


venv_select.setup({
    name = { ".venv", ".venv/", "$HOME/.config/.pyenv/versions/3.12.1/bin/python3" },
    pdm_path = "pdm",
})


local opts = { silent = true, nowait = true }
autocmd("VimEnter", {
    desc = "Auto select virtualenv Nvim open",
    pattern = "*",
    callback = function()
        map("n", "<Leader>fv", "<cmd>VenvSelect<CR>", opts)
        map("n", "<Leader>fz", "<cmd>VenvSelectCached<CR>", opts)
        local venv = fn.findfile("pyproject.toml", fn.getcwd() .. ".venv")
        if venv ~= "" then
            require("venv-selector").retrieve_from_cache()
        end
    end,
    once = true,
})
