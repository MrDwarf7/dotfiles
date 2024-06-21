local cmd = vim.cmd
local bufnr = vim.api.nvim_get_current_buf()

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "RUST: " .. desc })
end

-- vim.g.rustaceanvim.tools.code_actions.ui_select_fallback = true

map("<Leader>lf", function()
	cmd.RustFmt()
end, "[f]ormat")

map("<Leader>lc", function()
	cmd.RustLsp("flyCheck")
end, "[c]heck")

map("<Leader>dd", function()
	cmd.RustLsp("debuggables")
end, "[d]ebuggables")

map("<Leader>dr", function()
	cmd.RustLsp("runnables")
end, "[r]un")

map("<Leader>lh", function()
	cmd.RustLsp("hover")
end, "[h]over")

map("<Leader>la", function()
	cmd.RustLsp("codeAction")
end, "[a]ction")
