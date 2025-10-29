local map = vim.keymap.set

-- local nvim_dap_ui = require("dapui")
-- local nvim_dap = require("dap")

local M = {}

M.dap_ui_binds = function()
    map("n", "<Leader>dw", function()
        require("dapui").toggle()
    end, { desc = "[w]indow" })

    map("n", "<Leader>d[", function()
        require("dapui").open()
    end, { desc = "dap OPEN" })

    map("n", "<Leader>d]", function()
        require("dapui").close()
    end, { desc = "dap CLOSE" })

    map("n", "<Leader>dz", function()
        require("dapui").open({ reset = true })
    end, { desc = "[z]reset ui" })

    map({ "n", "v" }, "<Leader>de", function()
        require("dap.ui.widgets").hover()
    end, { desc = "[hover]" })

    map({ "n", "v" }, "<Leader>dh", function()
        require("dapui").eval()
    end, { desc = "[e]val" })

    map("n", "<Leader>df", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
    end, { desc = "[f]rames" })

    map("n", "<Leader>ds", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
    end, { desc = "[s]copes" })

    map({ "n", "v" }, "<Leader>dp", function()
        require("dap.ui.widgets").preview()
    end, { desc = "[p]review" })
end

return M
