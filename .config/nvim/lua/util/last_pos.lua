local M = {}


M.last_pos = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 0 and last_pos <= vim.fn.line("$") then
        vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
    end
end


return M
