if vim.g.neovide then
	require("config.neovide")
end
require('config.settings')
require('config.color')
-- Lazy
require('config.lazy')
require('config.completion')
-- Key map
require('config.mappings')
--require('config.autocmds')
