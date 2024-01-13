---@diagnostic disable: different-requires
if vim.g.neovide then
	require("base.neovide")
end


if vim.g.vscode then
	require("base.keymaps")
	require("base.vscode")
	-- vim.opt.clipboard:append("unnamedplus")
end


-- require("Comment").setup()
-- require("config.mini")

if vim.g ~= vim.g.vscode and vim.g ~= vim.g.neovide then
	require("base.options")
	require("base.lazy")
	--require("config.misc")
	require("base.keymaps")
	vim.cmd.colorscheme("catppuccin")
	require("git-worktree").setup()
	require("Comment").setup()
	require("config.dap")
	require("config.lualine")
	require("base.autocmds")
	require("config.gitsigns")
	require("config.tele")
	require("config.treesitter")
	require("config.lsp")
	require("config.linter")
	-- require("config.mini")
end



-- if not vim.g.vscode and not vim.g.neovide then
-- 	require("base.options")
-- 	require("base.lazy")
-- 	--require("config.misc")
-- 	require("base.keymaps")
-- 	vim.cmd.colorscheme("catppuccin")
-- 	require("git-worktree").setup()
-- 	require("Comment").setup()
-- 	require("config.dap")
-- 	require("config.lualine")
-- 	require("base.autocmds")
-- 	require("config.gitsigns")
-- 	require("config.tele")
-- 	require("config.treesitter")
-- 	require("config.lsp")
-- 	require("config.linter")
-- 	-- require("config.mini")
-- end
