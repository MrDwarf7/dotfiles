---@param keys string
---@param func function
---@param desc string
---@return nil
local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = "PREVIEW: " .. desc })
end

require("goto-preview").setup({
	default_mappings = false,
})

map("gpd", require("goto-preview").goto_preview_definition, "[d]efinition")
map("gpD", require("goto-preview").goto_preview_declaration, "[D]eclaration")
map("gpr", require("goto-preview").goto_preview_references, "[r]eferences")
map("gpi", require("goto-preview").goto_preview_implementation, "[i]mpl")
map("gpt", require("goto-preview").goto_preview_type_definition, "[t]ype")
map("gP", require("goto-preview").close_all_win, "close all")
