local M = {}

M.architechture = function()
    local os_type = function()
        if vim.fn.has("win32") == 1 then
            return "win32"
        end
        if vim.fn.has("unix") == 1 then
            return "unix"
        end
    end
    return os_type()
end

return M
