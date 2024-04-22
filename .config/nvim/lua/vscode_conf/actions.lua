print("vscode specific actions file loads...")
local vscode = require("vscode-neovim")
local map = vim.keymap.set

print("Vscode specific actions file loads...")

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

map("n", "<C-w>e", function()
	print("Reset editor window sizes")
	vscode.action("workbench.action.evenEditorWidths")
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

-- Non Ctrl variants
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

-- Ctrl variants
map("n", "<C-Left>", function()
	print("Increase view width")
	vscode.call("workbench.action.increaseViewWidth")
end)

map("n", "<C-Right>", function()
	print("Decrease view width")
	vscode.call("workbench.action.decreaseViewWidth")
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

local silent_opts = { noremap = true, silent = true, expr = true }
local function mapMove(key, direction)
	vim.keymap.set("n", key, function()
		local count = vim.v.count
		local v = 1
		local style = "wrappedLine"
		if count > 0 then
			v = count
			style = "line"
		end
		vscode.action("cursorMove", {
			args = {
				to = direction,
				by = style,
				value = v,
			},
		})
	end, silent_opts)
end
mapMove("k", "up")
mapMove("j", "down")
