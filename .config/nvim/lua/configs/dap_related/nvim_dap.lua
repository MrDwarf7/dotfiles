-- local fn = vim.fn
local nvim_dap = require("dap")
local dap_setups = require("util.dap-setup-entries")
local dap_mappings = require("util.dap-keys")
local dap_virtual_text = require("nvim-dap-virtual-text")

nvim_dap.config = function() end

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)

dap_mappings.dap_binds()

dap_setups.dap_entries_configs()

dap_virtual_text.setup({
	commented = true,
})
