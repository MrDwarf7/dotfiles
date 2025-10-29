return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  keys = {
		-- { "<Leader>fw", "<CMD>FzfLua live_grep<CR>", desc = "Find Files (cwd)" },
		-- { "<Leader>ff", "<CMD>FzfLua files<CR>", desc = "Find Files (cwd)" },
		-- { "<Leader>ff", "<CMD>FzfLua files<CR>", desc = "Find Files (cwd)" },

		-- stylua: ignore start
    { "<Leader>ff", function() require("fzf-lua").files({ root = false }) end,          desc = "Find Files (cwd)" },


    { "<Leader>fw", function() require("fzf-lua").live_grep({ root = false }) end,      desc = "Grep (cwd)" },
    { "<Leader>fW", function() require("fzf-lua").live_grep() end,                      desc = "Grep (Root Dir)" },

    { "<Leader>fr", function() require("fzf-lua").oldfiles() end,                       desc = "Recent" },
    { "<Leader>fR", function() require("fzf-lua").oldfiles({ cwd = vim.uv.cwd() }) end, desc = "Recent (cwd)" },

    { "<Leader>gc", "<cmd>FzfLua git_commits<CR>",                                      desc = "Commits" },
    { "<Leader>gs", "<cmd>FzfLua git_status<CR>",                                       desc = "Status" }, -- TODO: need to change the sub-binds for this

    { "<Leader>gc", function() require("fzf-lua").git_commits() end,                    desc = "Commits" },
    { "<Leader>gs", function() require("fzf-lua").git_status() end,                     desc = "Status" },

    { '<Leader>f"', function() require("fzf-lua").registers() end,                      desc = "Registers" },
    { "<Leader>fa", function() require("fzf-lua").autocmds() end,                       desc = "Autocmds" },

    { "<Leader>/",  function() require("fzf-lua").grep_curbuf() end,                    desc = "Grep Buffer" },


    { "<Leader>fq", function() require("fzf-lua").command_history() end,                desc = "Command History" },
    { "<Leader>fQ", function() require("fzf-lua").commands() end,                       desc = "Command" },

    { "<Leader>fd", function() require("fzf-lua").diagnostics_document() end,           desc = "Diag - Document" },
    { "<Leader>fD", function() require("fzf-lua").diagnostics_workspace() end,          desc = "Diag - Workspace" },

    { "<Leader>ld", function() require("fzf-lua").diagnostics_document() end,           desc = "Diag - Document" },
    { "<Leader>lD", function() require("fzf-lua").diagnostics_workspace() end,          desc = "Diag - Workspace" },


    { "<Leader>fM", function() require("fzf-lua").man_pages() end,                      desc = "Man Pages" },
    { "<Leader>fh", function() require("fzf-lua").help_tags() end,                      desc = "Help Pages" },

    { "<Leader>fH", function() require("fzf-lua").highlights() end,                     desc = "Highlights" },

    { "<Leader>fj", function() require("fzf-lua").jumps() end,                          desc = "Jump List" },
    { "<Leader>fk", function() require("fzf-lua").keymaps() end,                        desc = "Keymaps" },
    { "<Leader>fl", function() require("fzf-lua").loclist() end,                        desc = "Loc-List" },

    { "<Leader>fm", function() require("fzf-lua").marks() end,                          desc = "Marks" },
    { "<Leader>f'", function() require("fzf-lua").marks() end,                          desc = "Marks" },

    { "<Leader>fl", function() require("fzf-lua").resume() end,                         desc = "Resume latest" },

    { "<Leader>fc", function() require("fzf-lua").grep_cword({ root = false }) end,     desc = "Word (cwd)" },
    { "<Leader>fC", function() require("fzf-lua").grep_cword() end,                     desc = "Word (Root)" },

    { "<Leader>fc", function() require("fzf-lua").grep_visual({ root = false }) end,    mode = "v",               desc = "Selection (cwd)" },
    { "<Leader>fC", function() require("fzf-lua").grep_visual() end,                    mode = "v",               desc = "Selection (Root)" },

    { "<Leader>fu", function() require("fzf-lua").colorschemes() end,                   desc = "Colorschemes" },
    -- stylua: ignore end
  },
  opts = {},
}
