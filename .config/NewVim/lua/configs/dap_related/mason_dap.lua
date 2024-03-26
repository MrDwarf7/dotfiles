local architecture = require("util.architecture")
local ensure_installed_table = {}

if architecture.is_windows() == true then
	ensure_installed_table = {
		"chrome-debug-adapter",
		"codelldb",
		"cpptools",
		"debugpy",
		"firefox-debug-adapter",
	}
elseif architecture.is_windows() == false then
	ensure_installed_table = {
		"bash-debug-adapter",
		"chrome-debug-adapter",
		"codelldb",
		"cpptools",
		"debugpy",
		"firefox-debug-adapter",
	}
end

require("mason-nvim-dap").setup({
	ensure_installed = ensure_installed_table,
	automatic_installation = true,
	handlers = {},
})
