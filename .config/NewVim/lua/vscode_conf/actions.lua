local vscode = require("vscode-neovim")
local map = vim.keymap.set

return {
	print("Vscode specific actions file loads..."),

	map("n", "gd", function()
		print("Go to definition")
		vscode.action("editor.action.revealDefinition")
	end),

	map("n", "gD", function()
		print("Go to declaration")
		vscode.action("editor.action.revealDeclaration")
	end),

	map("n", "<C-w>d", function()
		print("Go to declaration")
		vscode.action("editor.action.revealDefinitionAside")
	end),

	map("n", "gr", function()
		print("Go to references")
		vscode.action("editor.action.goToReferences")
	end),

	map("n", "gi", function()
		print("Go to implementation")
		vscode.action("editor.action.goToImplementation")
	end),

	map("n", "gI", function()
		print("Go to last edit location")
		vscode.action("workbench.action.navigateToLastEditLocation")
	end),

	map("n", "gt", function()
		print("Go to type definition")
		vscode.action("editor.action.goToTypeDefinition")
	end),

	map("n", "K", function()
		print("Hover")
		vscode.call("editor.action.showHover")
	end),

	map("n", "<C-k>", function()
		print("Peek definition")
		vscode.action("editor.action.peekDefinition")
	end),

	map("n", "]d", function()
		print("Next Diagnostic")
		vscode.call("editor.action.marker.next")
	end),

	map("n", "[d", function()
		print("Prev Diagnostic")
		vscode.call("editor.action.marker.prev")
	end),
}
