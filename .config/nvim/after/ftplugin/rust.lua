-- local bufnr = vim.api.nvim_get_current_buf()
--
--  vim.keymap.set("n", "<Leader>lf", function()
--  	vim.cmd.RustFmt()
--  end, { desc =  "[f]ormat"})
--
--  vim.keymap.set("n", "<Leader>lc", function()
--  	vim.cmd.RustLsp("flyCheck")
--  end, { desc = "[c]heck"})
--
--  vim.keymap.set("n", "<Leader>dd", function()
--  	vim.cmd.RustLsp("debuggables")
--  end, { desc = "[d]ebuggables"})
--
--  vim.keymap.set("n", "<Leader>dr", function()
--  	vim.cmd.RustLsp("runnables")
--  end, { desc =  "[r]un"})
--
--  vim.keymap.set("n", "<Leader>lh", function()
--  	vim.cmd.RustLsp()
--  end, { desc = "[h]over"})
--
--  vim.keymap.set("n", "<Leader>la", function()
--  	vim.cmd.RustLsp('codeAction')
--  end, {desc = "[a]ction", buffer = bufnr})
