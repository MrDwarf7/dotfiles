-- local vscode = require("vscode")
print("Vscode specific actions file loads...")

return {
	-- vim.keymap.set("n", "j", function()
	-- 	require("vscode").call("editor.cursorDown")
	-- end),
	--
	-- vim.keymap.set("n", "k", function()
	-- 	require("vscode").call("editor.cursorDown")
	-- end),

	vim.keymap.set("i", "jj", function()
		require("vscode").action("vscode-neovim.escape")
	end),

	vim.keymap.set("i", "kj", function()
		require("vscode").action("vscode-neovim.escape")
	end),

	vim.keymap.set("i", "jk", function()
		require("vscode").action("vscode-neovim.escape")
	end),

	vim.keymap.set("n", "gd", function()
		print("Go to definition")
		require("vscode").action("editor.action.revealDefinition")
	end),

	vim.keymap.set("n", "gD", function()
		print("Go to declaration")
		require("vscode").action("editor.action.revealDeclaration")
	end),

	vim.keymap.set("n", "<C-w>d", function()
		print("Go to declaration")
		require("vscode").action("editor.action.revealDefinitionAside")
	end),

	vim.keymap.set("n", "<C-w>e", function()
		print("Reset editor window sizes")
		require("vscode").action("workbench.action.evenEditorWidths")
	end),

	vim.keymap.set("n", "gr", function()
		print("Go to references")
		require("vscode").action("editor.action.goToReferences")
	end),

	vim.keymap.set("n", "gi", function()
		print("Go to implementation")
		require("vscode").action("editor.action.goToImplementation")
	end),

	vim.keymap.set("n", "gI", function()
		print("Go to last edit location")
		require("vscode").action("workbench.action.navigateToLastEditLocation")
	end),

	vim.keymap.set("n", "gt", function()
		print("Go to type definition")
		require("vscode").action("editor.action.goToTypeDefinition")
	end),

	vim.keymap.set("n", "gO", function()
		print("Goto Symbol")
		require("vscode").action("workbench.action.gotoSymbol")
	end),

	vim.keymap.set("n", "K", function()
		print("Hover")
		require("vscode").call("editor.action.showHover")
	end),

	vim.keymap.set("n", "gp", function()
		print("Peek Declaration")
		require("vscode").call("editor.action.peekDeclaration")
	end),

	vim.keymap.set("n", "<C-k>", function()
		print("Peek definition")
		require("vscode").action("editor.action.peekDefinition")
	end),

	-- Non Ctrl variants,
	vim.keymap.set("n", "<Left>", function()
		print("Increase view width")
		require("vscode").call("workbench.action.increaseViewWidth")
	end),

	vim.keymap.set("n", "<Right>", function()
		print("Decrease view width")
		require("vscode").call("workbench.action.decreaseViewWidth")
	end),

	-- This are 'inverted' to an extent, because you're changing the actual editor size
	vim.keymap.set("n", "<Down>", function()
		print("Increase view height")
		require("vscode").call("workbench.action.increaseViewHeight")
	end),

	vim.keymap.set("n", "<Up>", function()
		print("Decrease view height")
		require("vscode").call("workbench.action.decreaseViewHeight")
	end),

	-- Ctrl variants,
	vim.keymap.set("n", "<C-Left>", function()
		print("Increase view width")
		require("vscode").call("workbench.action.increaseViewWidth")
	end),

	vim.keymap.set("n", "<C-Right>", function()
		print("Decrease view width")
		require("vscode").call("workbench.action.decreaseViewWidth")
	end),

	-- Ctrl variants,
	vim.keymap.set("n", "<C-h>", function()
		print("Increase view width")
		require("vscode").call("workbench.action.increaseViewWidth")
	end),

	vim.keymap.set("n", "<C-l>", function()
		print("Decrease view width")
		require("vscode").call("workbench.action.decreaseViewWidth")
	end),

	vim.keymap.set("n", "<C-Down>", function()
		print("Increase view size")
		require("vscode").call("workbench.action.increaseViewSize")
	end),

	vim.keymap.set("n", "<C-Up>", function()
		print("Decrease view size")
		require("vscode").call("workbench.action.decreaseViewSize")
	end),

	vim.keymap.set("n", "<C-w>e", function()
		print("Reset view size")
		require("vscode").call("workbench.action.evenEditorWidths")
	end),

	vim.keymap.set("n", "<C-w>t", function()
		print("Last editor closed")
		require("vscode").call("workbench.action.reopenClosedEditor")
	end),

	vim.keymap.set("n", "<C-w>m", function()
		print("Maxamize editor group")
		require("vscode").call("workbench.action.minimizeOtherEditors")
	end),
	-- actions(),
}
