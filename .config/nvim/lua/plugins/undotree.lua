return {
  "mbbill/undotree",
  event = "VeryLazy",
  keys = {
    { "<Leader>u", "<CMD>UndotreeToggle<CR>", desc = "[u]ndotree", silent = true },
  },
  init = function()
    vim.g.undotree_WindowLayout = 1 -- Default: 1 - One of 4 set window layouts

    vim.g.undotree_ShortIndicators = 0 -- Default: 0 - Use 'd' instead of 'days'
    vim.g.undotree_SplitWidth = 48 -- Default: 30 - window width, forces to 24 if the ShortIndicators is 1
    vim.g.undotree_DiffpanelHeight = 10 -- Default: 10 - height of diff panel
    vim.g.undotree_DiffAutoOpen = 0 -- Default: 1 -  Open diff panel automatically
    vim.g.undotree_SetFocusWhenToggle = 1 -- Default: 1 - let undotree pull focus when being spawned, otherwise stay in current window

    vim.g.undotree_TreeNodeShape = "◆" -- Default: '•' - shape of tree node
    vim.g.undotree_TreeVertShape = "│" -- Default: '│' - shape of tree vertical line
    vim.g.undotree_TreeSplitShape = "/" -- Default: '/' - shape of tree split line
    vim.g.undotree_TreeReturnShape = "\\" -- Default: '\' - shape of tree return line
    vim.g.undotree_DiffCommand = "diff" -- Default: 'diff' - external diff command
    vim.g.undotree_RelativeTimestamp = 1 -- Default: 1 - Show relative timestamps
    vim.g.undotree_HighlightChangedText = 1 -- Default: 1 - Highlight changed text
    vim.g.undotree_HighlightChangedWithSign = 1 -- Default: 1 - Highlight changed lines with sign column

    vim.g.undotree_SignAdded = "++" -- Default: '++' - sign for added lines
    vim.g.undotree_SignChanged = "~~" -- Default: '~~' - sign for changed lines
    vim.g.undotree_SignDeleted = "--" -- Default: '--' - sign for deleted lines
    vim.g.undotree_SignDeletedEnd = "-v" -- Default: '-v' - sign for deleted lines at the end of file

    vim.g.undotree_HelpLine = 1
    vim.g.undotree_CursorLine = 1
    vim.g.undotree_StatusLine = 1
    vim.g.undotree_DisabledFiletypes = {}
    vim.g.undotree_DisabledBuftypes = { "terminal", "prompt", "quickfix", "nofile" }

    vim.g.undotree_UndoDir = vim.fn.stdpath("data") .. "/undodir"
  end,
}
