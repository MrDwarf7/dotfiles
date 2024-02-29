local nvim_dap = require("dap")
local nvim_dap_ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")
local dap_ui_mappings = require("util.dap-ui-mappings")


nvim_dap_ui.setup()

nvim_dap.listeners.before.attach.nvim_dap_ui_config = function()
    nvim_dap_ui.open()
end

nvim_dap.listeners.before.launch.nvim_dap_ui_config = function()
    nvim_dap_ui.open()
end


dap_ui_mappings.dap_ui_binds()

dap_virtual_text.setup()
