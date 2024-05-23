local opt_val = vim.api.nvim_get_option_value
local t_con = vim.tbl_contains
local map = vim.keymap.set
local fn = vim.fn

local M = {}

M.q_to_close = function(args)
    local buftype = opt_val("buftype", { buf = args.buf })
    if t_con({
            "help",
            "nofile",
            "quickfix",
            "LspInfo",
            ":LspSaga",
        }, buftype) and fn.maparg("q", "n") == "" then
        map("n", "q", "<cmd>close<cr>", {
            desc = "Close window",
            buffer = args.buf,
            silent = true,
            nowait = true,
        })
    end
end

return M
