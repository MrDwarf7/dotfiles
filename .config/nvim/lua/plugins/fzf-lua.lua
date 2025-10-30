-- Can get the entire 'action list'
-- by calling this:
-- lua vim.print(vim.inspect(require("fzf-lua").actions))
--
-- Or generally, the entire module(s) interface:
-- lua vim.print(vim.inspect(require("fzf-lua")))

-- further info can be found via:
-- (we want the full doc lol)
-- h fzf-lua.txt
--
-- With commands at:
-- h fzf-lua-commands

-- local actions = require("fzf-lua").actions

return {
  "ibhagwan/fzf-lua",
  lazy = false,
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
		-- { "<Leader>ff", function() require("fzf-lua").files({ cwd = vim.uv.cwd() }) end,                                       desc = "Find Files (root=cwd)" },
		{ "<Leader>ff", function() require("fzf-lua").files({ cwd = vim.uv.cwd() }) end,                         desc = "Find Files (root=cwd)" },
		-- TODO: This is a little janky, oil expects the oil buffer to be open to get the current dir.
		{ "<Leader>fF", function() require("fzf-lua").files({ cwd = require("oil").get_current_dir() }) end,     desc = "Find Files (oil)" },

		{ "<Leader>fr", function() require("fzf-lua").oldfiles() end,                                            desc = "Recent" },
		{ "<Leader>fR", function() require("fzf-lua").oldfiles({ cwd = vim.uv.cwd() }) end,                      desc = "Recent (cwd)" },

		{ "<Leader>fz", function() require("fzf-lua").zoxide() end,                                              desc = "Find via Zoxide" },
		{ "<Leader>fb", function() require("fzf-lua").buffers() end,                                             desc = "Find Buffers" },

		{ "<Leader>fg", function() require("fzf-lua").git_files({ cwd = vim.uv.cwd() }) end,                     desc = "Find Git Files (root=cwd)" },
		-- { "<Leader>fg", function() require("fzf-lua").git_files({ root = false, cwd = vim.uv.cwd() }) end,                     desc = "Find Git Files (root=cwd)" },
		{ "<Leader>fG", function() require("fzf-lua").git_files({ cwd = require("oil").get_current_dir() }) end, desc = "Find Git Files (oil)" },

		{ "<Leader>fw", function() require("fzf-lua").live_grep({ cwd = vim.uv.cwd() }) end,                     desc = "Grep (cwd)" },
		{ "<Leader>fW", function() require("fzf-lua").live_grep() end,                                           desc = "Grep (Root Dir)" },

		{ "<Leader>fl", function() require("fzf-lua").resume() end,                                              desc = "Resume latest" },

		{ "<Leader>fP", function() require("fzf-lua").profiles() end,                                            desc = "Profiles picker" },

		-- persistence / persistence.nvim
		{ "<Leader>sf", function() require("persistence").select() end,                                          desc = "Select Session" },
		{ "<Leader>fS", function() require("persistence").select() end,                                          desc = "Select Session" },

		{ "<Leader>gc", function() require("fzf-lua").git_commits() end,                                         desc = "Commits" },
		{ "<Leader>gs", function() require("fzf-lua").git_status() end,                                          desc = "Status" },

		{ '<Leader>f"', function() require("fzf-lua").registers() end,                                           desc = "Registers" },
		{ "<Leader>fa", function() require("fzf-lua").autocmds() end,                                            desc = "Autocmds" },

		{ "<Leader>/",  function() require("fzf-lua").grep_curbuf() end,                                         desc = "Grep Buffer" },


		{ "<Leader>fq", function() require("fzf-lua").command_history() end,                                     desc = "Command History" },
		{ "<Leader>fQ", function() require("fzf-lua").commands() end,                                            desc = "Command" },

		{ "<Leader>fd", function() require("fzf-lua").diagnostics_document() end,                                desc = "Diag - Document" },
		{ "<Leader>fD", function() require("fzf-lua").diagnostics_workspace() end,                               desc = "Diag - Workspace" },

		{ "<Leader>ld", function() require("fzf-lua").diagnostics_workspace() end,                               desc = "Diag - Workspace" },
		{ "<Leader>lD", function() require("fzf-lua").diagnostics_document() end,                                desc = "Diag - Document" },

		{ "<Leader>fM", function() require("fzf-lua").man_pages() end,                                           desc = "Man Pages" },
		{ "<Leader>fh", function() require("fzf-lua").help_tags() end,                                           desc = "Help Pages" },

		{ "<Leader>fH", function() require("fzf-lua").highlights() end,                                          desc = "Highlights" },

		{ "<Leader>fj", function() require("fzf-lua").jumps() end,                                               desc = "Jump List" },
		-- TODO: this isn't indexing 'builtin' keymaps (like marks via `'` or `\`` for instance)
		{ "<Leader>fk", function() require("fzf-lua").keymaps() end,                                             desc = "Keymaps" },
		{ "<Leader>fL", function() require("fzf-lua").loclist() end,                                             desc = "Loc-List" },

		{ "<Leader>fm", function() require("fzf-lua").marks() end,                                               desc = "Marks" },
		{ "<Leader>f'", function() require("fzf-lua").marks() end,                                               desc = "Marks" },

		{ "<Leader>fc", function() require("fzf-lua").grep_cword({ root = false }) end,                          desc = "Word (cwd)" },
		{ "<Leader>fC", function() require("fzf-lua").grep_cword() end,                                          desc = "Word (Root)" },

		{ "<Leader>fc", function() require("fzf-lua").grep_visual({ root = false }) end,                         mode = "v",                        desc = "Selection (cwd)" },
		{ "<Leader>fC", function() require("fzf-lua").grep_visual() end,                                         mode = "v",                        desc = "Selection (Root)" },

		{ "<Leader>fu", function() require("fzf-lua").colorschemes() end,                                        desc = "Colorschemes" },
    -- stylua: ignore end
  },

  opts = function()
    local actions = require("fzf-lua").actions
    local opts = {
      { "default-title", "default-prompt", "hide" },
      fzf_bin = "fzf",
      -- "fzf-tmux", -- very cool, it uses a tmux pop-up win, but blocks tmux leader key input
      -- fzf_bin = "sk",  -- skim
      -- fzf_bin = "other",  -- supports other fzf-compatible binaries

      defaults = {
        -- if `files.fzf_opts.["--ansi"] = true`, turn both of these to false
        git_icons = true,
        file_icons = true,
        -- or if you're turning these off,
        -- you can change the `grep.fzf_opts` to `["--ansi"]=true` instead,
        -- which will speed up rg results
      },
      winopts = {
        treesitter = {
          enabled = true,
        }, -- can turn it off for matching 'max-perf' profile
        preview = {

          -- EITHER USE BUILTIN PREVIEWER OR BAT
          -- (bat kinda looks odd cos it's different syntax highlight to nvim's)
          default = "builtin",
          -- default = "bat",
        },
      },
      manpages = { previewer = "man_native" },
      helptags = { previewer = "help_native" },

      lsp = {
        jump1 = true,
        code_actions = {
          previewer = "codeaction_native",
        },
      },
      tags = { previewer = "bat" },
      btags = { previewer = "bat" },

      -- major per opts
      files = {
        fzf_opts = {
          ["--ansi"] = true, -- recommended not to turn this off if icons are used (get scrambled unicode ascii otherwise)
        },
      },
      grep = {
        -- prompt = "Rg❯ ",
        multiprocess = true, -- run command in a sep. process

        git_icons = false,
        file_icons = true,
        color_icons = true,

        fzf_opts = {
          ["--ansi"] = true, -- recommended not to turn this off if icons are used (get scrambled unicode ascii otherwise)
        },
        -- rg_glob=true is also very fast now no matter mt/st (when disable fn_transform,fn_postprocess)
        rg_glob = true,

        -- 'normal' options
        grep_opts = require("fzf-lua.utils").is_darwin()
            and "--color=always --binary-files=without-match --line-number --recursive --extended-regexp -e"
          or "--color=always --binary-files=without-match --line-number --recursive --perl-regexp -e",
        rg_opts = " --color=always --column --line-number --no-heading --smart-case --max-columns=4096 -e",

        -- performance options (no color)
        -- grep_opts = require("fzf-lua.utils").is_darwin()
        --     and "--color=never --binary-files=without-match --line-number --recursive --extended-regexp -e"
        --   or "--color=never --binary-files=without-match --line-number --recursive --perl-regexp -e",
        -- rg_opts = " --color=never --column --line-number --no-heading --smart-case --max-columns=4096 -e",
      },
      --

      -- oldfiles = {
      --
      -- },
      buffers = {
        file_icons = true,
        color_icons = true,
        sort_lastused = true, -- sort by last used
        show_unloaded = true, -- show unloaded buffers
        cwd_only = false, -- buffers for the cwd only
        cwd = nil, -- buffers list for a given dir
        -- actions = {
        -- 	-- these auto-inherit from actions.files anyway
        -- }
      },
      -- tabs = {},
      -- lines = {
      -- 	file_icons = true,
      -- },

      fzf_colors = true, -- will 'auto-generate' based on colorscheme
      keymap = {
        -- handles all 'general'/generic-ish fzf-lua invoked pickers
        builtin = {
          true,
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        -- THIS IS THE ONE that handles inside the actual pop-up itself!!!!!!!
        fzf = {
          true,
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-q"] = "select-all+accept",
          ["ctrl-t"] = "select-all+accept", -- idk how this is different to the actions.files mapping tbh
        },
      },

      actions = {
        files = {
          ["enter"] = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          -- ["ctrl-t"] = actions.file_tabedit,
          ["ctrl-t"] = actions.file_sel_to_qf,
          -- ["ctrl-t"] = actions.file_sel_to_qf,
          -- ["alt-q"] = actions.file_sel_to_qf,
        },
      },

      -- buffers = {
      -- keymap = {
      --   builtin = {
      --     ["<C-d>"] = false,
      --   },
      -- },
      -- actions = {
      --   ["ctrl-x"] = {
      --     actions.buf_del,
      --     reload = true,
      --   },
      --   ["ctrl-d"] = {
      --     actions.buf_del,
      --     reload = true,
      --   },
      -- },
      -- },
    }
    return opts
  end,
}

-- opts = {
--   fzf_bin = "fzf",
--   -- fzf_bin = "sk",  -- skim
--   -- fzf_bin = "other",  -- supports other fzf-compatible binaries
--
--   fzf_colors = true, -- will 'auto-generate' based on colorscheme
--   keymap = {
--     builtin = {
--       true,
--       ["ctrl-u"] = "preview-page-up",
--       ["ctrl-d"] = "preview-page-down",
--     },
--     fzf = {
--       true,
--       ["ctrl-u"] = "preview-page-up",
--       ["ctrl-d"] = "preview-page-down",
--     },
--   },
--   -- TODO: Docs site using `FzfLua` but it's not global until the
--   -- module itself is initialized tf...?
--   --
--   actions = {
--     files = {
--       ["ctrl-q"] = actions.file_sel_to_qf,
--       ["ctrl-l"] = actions.file_sel_to_ll,
--     },
--   },
--   buffers = {
--     keymap = {
--       builtin = {
--         ["<C-d>"] = false,
--       },
--       actions = {
--         ["<C-d>"] = { actions.buf_del, actions.resume },
--       },
--     },
--   },
--
--   -- fzf_opts = {
--   -- }
--
--   lsp = {
--     jump1 = true,
--     -- jump1_action = FzfLua.actions.file_edit,
--     -- includeDeclaration = false,
--   },
-- },
