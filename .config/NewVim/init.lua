-- https://github.com/bluz71/dotfiles/blob/master/nvim/init.lua
local fn = vim.fn

if fn.has("nvim-0.9") == 1 then
    vim.loader.enable()
end

if vim.g.neovide then
    require("core.neovide")
    require("core.options")
    require("core.mappings")
    -- require("core.autocmds")
end

if vim.g.vscode then
    require("core.options")
    require("core.mappings")
    require("core.autocmds")
else
    require("core.options")
    require("core.mappings")
    require("core.autocmds")
    require("core.lazy")
end

----------------------------
