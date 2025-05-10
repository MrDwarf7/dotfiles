return {
  "fzf-lua",
  keys = {
    { "<leader>/", false },
    { "<leader><space>", false },
    { "<leader>fc", false },
    { "<leader>sq", false },

    -- { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
    -- { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    -- { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    -- {
    --   "<leader>,",
    --   "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
    --   desc = "Switch Buffer",
    -- },
    -- { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },

    { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
    { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },

    { "<Leader>,", false },
    { "<Leader>f:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    -- find
    { "<Leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<Leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<Leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<Leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
    { "<Leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
    { "<Leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    -- git
    { "<Leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
    { "<Leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" }, -- TODO: need to change the sub-binds for this
    -- search
    { '<Leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
    { "<Leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
    { "<Leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
    { "<Leader>sq", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    { "<Leader>sQ", "<cmd>FzfLua commands<cr>", desc = "Commands" },

    { "<Leader>fD", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
    { "<Leader>fd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },

    { "<Leader>fw", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<Leader>fW", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },

    { "<Leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
    { "<Leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },

    { "<Leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },

    { "<Leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },

    { "<Leader>fl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },

    { "<Leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },

    { "<Leader>fm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },

    { "<Leader>fl", "<cmd>FzfLua resume<cr>", desc = "Resume" },

    { "<Leader>fc", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
    { "<Leader>fC", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },

    { "<Leader>fc", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
    { "<Leader>fC", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },

    { "<Leader>uC", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },

    -- {
    --   "<leader>ss",
    --   function()
    --     require("fzf-lua").lsp_document_symbols({
    --       regex_filter = symbols_filter,
    --     })
    --   end,
    --   desc = "Goto Symbol",
    -- },
    -- {
    --   "<leader>sS",
    --   function()
    --     require("fzf-lua").lsp_live_workspace_symbols({
    --       regex_filter = symbols_filter,
    --     })
    --   end,
    --   desc = "Goto Symbol (Workspace)",
    -- },
  },
  opts = {},
}
