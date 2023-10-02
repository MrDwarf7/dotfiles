---@diagnostic disable: different-requires
if not vim.g.vscode then
    require('config.settings')
    require('config.color')
    -- Lazy
    require('config.lazy')
    require('config.completion')
    -- Keymap
    require('config.mappings')
    --
else -- If vscode
    require('config.settings')
    require('config.color')
    require('config.lazy')
    require('config.completion')
    require('config.mappings')
end
