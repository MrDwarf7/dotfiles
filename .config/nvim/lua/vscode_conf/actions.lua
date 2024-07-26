print("vscode specific actions file loads...")
local vscode = require("vscode-neovim")
-- local map = vim.keymap.set

print("Vscode specific actions file loads...")

vim.keymap.set("n", "gd", function()
	print("Go to definition")
	vscode.action("editor.action.revealDefinition")
end)

vim.keymap.set("n", "gD", function()
	print("Go to declaration")
	vscode.action("editor.action.revealDeclaration")
end)

vim.keymap.set("n", "<C-w>d", function()
	print("Go to declaration")
	vscode.action("editor.action.revealDefinitionAside")
end)

vim.keymap.set("n", "<C-w>e", function()
	print("Reset editor window sizes")
	vscode.action("workbench.action.evenEditorWidths")
end)

vim.keymap.set("n", "gr", function()
	print("Go to references")
	vscode.action("editor.action.goToReferences")
end)

vim.keymap.set("n", "gi", function()
	print("Go to implementation")
	vscode.action("editor.action.goToImplementation")
end)

vim.keymap.set("n", "gI", function()
	print("Go to last edit location")
	vscode.action("workbench.action.navigateToLastEditLocation")
end)

vim.keymap.set("n", "gt", function()
	print("Go to type definition")
	vscode.action("editor.action.goToTypeDefinition")
end)

vim.keymap.set("n", "gO", function()
	print("Goto Symbol")
	vscode.action("workbench.action.gotoSymbol")
end)

vim.keymap.set("n", "K", function()
	print("Hover")
	vscode.call("editor.action.showHover")
end)

vim.keymap.set("n", "gp", function()
	print("Peek Declaration")
	vscode.call("editor.action.peekDeclaration")
end)

vim.keymap.set("n", "<C-k>", function()
	print("Peek definition")
	vscode.action("editor.action.peekDefinition")
end)

-- Non Ctrl variants
vim.keymap.set("n", "<Left>", function()
	print("Increase view width")
	vscode.call("workbench.action.increaseViewWidth")
end)

vim.keymap.set("n", "<Right>", function()
	print("Decrease view width")
	vscode.call("workbench.action.decreaseViewWidth")
end)

-- This are 'inverted' to an extent, because you're changing the actual editor size
vim.keymap.set("n", "<Down>", function()
	print("Increase view height")
	vscode.call("workbench.action.increaseViewHeight")
end)

vim.keymap.set("n", "<Up>", function()
	print("Decrease view height")
	vscode.call("workbench.action.decreaseViewHeight")
end)

-- Ctrl variants
vim.keymap.set("n", "<C-Left>", function()
	print("Increase view width")
	vscode.call("workbench.action.increaseViewWidth")
end)

vim.keymap.set("n", "<C-Right>", function()
	print("Decrease view width")
	vscode.call("workbench.action.decreaseViewWidth")
end)

vim.keymap.set("n", "<C-Down>", function()
	print("Increase view size")
	vscode.call("workbench.action.increaseViewSize")
end)

vim.keymap.set("n", "<C-Up>", function()
	print("Decrease view size")
	vscode.call("workbench.action.decreaseViewSize")
end)

vim.keymap.set("n", "<C-w>e", function()
	print("Reset view size")
	vscode.call("workbench.action.evenEditorWidths")
end)

vim.keymap.set("n", "<C-w>t", function()
	print("Last editor closed")
	vscode.call("workbench.action.reopenClosedEditor")
end)

vim.keymap.set("n", "<C-w>m", function()
	print("Maxamize editor group")
	vscode.call("workbench.action.minimizeOtherEditors")
end)
