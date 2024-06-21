-- local nvim_dap = require("dap")
-- local nvim_dap_ui =
-- local dap_virtual_text = require("nvim-dap-virtual-text")
-- local dap_ui_mappings = require("util.dap-ui-mappings")

require("dapui").setup()

require("dap").listeners.before.attach.nvim_dap_ui_config = function()
	require("dapui").open()
end
require("dap").listeners.before.launch.nvim_dap_ui_config = function()
	require("dapui").open()
end

require("util.dap-ui-mappings").dap_ui_binds()
require("nvim-dap-virtual-text").setup()
