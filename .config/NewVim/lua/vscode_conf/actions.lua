-- local M = {}

-- M.vscode_actions = function()
print("vscode specific actions file loads...")
local vscode = require("vscode-neovim")
local map = vim.keymap.set

print("Vscode specific actions file loads...")

-- map("n", "j", function()
-- 	print("j fnc ran")
-- 	vscode.call("v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'j' : 'gj'")
-- end)
--
-- map("n", "k", function()
-- 	print("k fnc ran")
-- 	vscode.call("v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'k' : 'gk'")
-- end)

-- map("n", "j", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'j' : 'gj'", { expr = true })
-- map("n", "k", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'k' : 'gk'", { expr = true })

map("n", "gd", function()
	print("Go to definition")
	vscode.action("editor.action.revealDefinition")
end)

map("n", "gD", function()
	print("Go to declaration")
	vscode.action("editor.action.revealDeclaration")
end)

map("n", "<C-w>d", function()
	print("Go to declaration")
	vscode.action("editor.action.revealDefinitionAside")
end)

map("n", "gr", function()
	print("Go to references")
	vscode.action("editor.action.goToReferences")
end)

map("n", "gi", function()
	print("Go to implementation")
	vscode.action("editor.action.goToImplementation")
end)

map("n", "gI", function()
	print("Go to last edit location")
	vscode.action("workbench.action.navigateToLastEditLocation")
end)

map("n", "gt", function()
	print("Go to type definition")
	vscode.action("editor.action.goToTypeDefinition")
end)

map("n", "gO", function()
	print("Goto Symbol")
	vscode.action("workbench.action.gotoSymbol")
end)

map("n", "K", function()
	print("Hover")
	vscode.call("editor.action.showHover")
end)

map("n", "gp", function()
	print("Peek Declaration")
	vscode.call("editor.action.peekDeclaration")
end)

map("n", "<C-k>", function()
	print("Peek definition")
	vscode.action("editor.action.peekDefinition")
end)

map("n", "]d", function()
	print("Next Diagnostic")
	vscode.call("editor.action.marker.next")
end)

map("n", "[d", function()
	print("Prev Diagnostic")
	vscode.call("editor.action.marker.prev")
end)

map("n", "]m", function()
	print("Next Bookmark")
	vscode.call("bookmarks.jumpToNext")
end)

map("n", "[m", function()
	print("Prev Bookmark")
	vscode.call("bookmarks.jumpToPrevious")
end)

map("n", "<Left>", function()
	print("Increase view width")
	vscode.call("workbench.action.increaseViewWidth")
end)

map("n", "<Right>", function()
	print("Decrease view width")
	vscode.call("workbench.action.decreaseViewWidth")
end)

-- This are 'inverted' to an extent, because you're changing the actual editor size
map("n", "<Down>", function()
	print("Increase view height")
	vscode.call("workbench.action.increaseViewHeight")
end)

map("n", "<Up>", function()
	print("Decrease view height")
	vscode.call("workbench.action.decreaseViewHeight")
end)

map("n", "<C-Down>", function()
	print("Increase view size")
	vscode.call("workbench.action.increaseViewSize")
end)

map("n", "<C-Up>", function()
	print("Decrease view size")
	vscode.call("workbench.action.decreaseViewSize")
end)

map("n", "<C-w>e", function()
	print("Reset view size")
	vscode.call("workbench.action.evenEditorWidths")
end)

map("n", "<C-w>t", function()
	print("Last editor closed")
	vscode.call("workbench.action.reopenClosedEditor")
end)

map("n", "<C-w>m", function()
	print("Maxamize editor group")
	vscode.call("workbench.action.minimizeOtherEditors")
end)

map("n", "za", function()
	print("Fold toggle")
	vscode.call("editor.toggleFold")
end)

-- unfold
map("n", "zr", function()
	print("Open fold")
	vscode.call("editor.unfold")
end)

-- unfold ALL
map("n", "zR", function()
	print("Open folds all")
	vscode.call("editor.unfoldAll")
end)

-- unfold recursively
map("n", "zo", function()
	print("Open folds recurse")
	vscode.call("editor.unfoldRecursively")
end)

-- fold
map("n", "zc", function()
	print("Close fold")
	vscode.call("editor.fold")
end)

-- fold ALL
map("n", "zC", function()
	print("Close all folds")
	vscode.call("editor.foldAll")
end)

-- fold recursively
map("n", "zm", function()
	print("Close folds recurse")
	vscode.call("editor.foldRecursively")
end)
-- end
-- return M
