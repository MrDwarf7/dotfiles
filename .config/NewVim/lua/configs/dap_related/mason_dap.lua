local mason_dap = require("mason-nvim-dap")

local ensure_installed_table = {}

if vim.g.os == "unix" then
    ensure_installed_table = {
        "bash-debug-adapter",
        "chrome-debug-adapter",
        "codelldb",
        "cpptools",
        "debugpy",
        "firefox-debug-adapter",
    }
elseif vim.g.os == "win32" then
    ensure_installed_table = {
        "chrome-debug-adapter",
        "codelldb",
        "cpptools",
        "debugpy",
        "firefox-debug-adapter",
    }
end

mason_dap.setup({
    ensure_installed = ensure_installed_table,
    automatic_installation = true,
    handlers = {},
})
