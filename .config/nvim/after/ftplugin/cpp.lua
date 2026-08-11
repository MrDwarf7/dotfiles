local dap = require("dap")

dap.adapters.cpp = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
  name = "codelldb",
  host = "127.0.0.1",
  port = "${port}",
  options = {
    source_filetypes = { "cpp", "c", "rust" },
  },
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}
