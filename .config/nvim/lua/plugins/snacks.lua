return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
      --stylua: ignore start
      -- Top Pickers & Explorer
      { "<Leader>ff", function() Snacks.picker.smart() end, desc = "Smart Find Files" }, -- can be set up to use { multi = { "buffers", "files", "recent" } } etc.
      { "<Leader>fF", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files" },
      { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<Leader>fw", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<Leader>fc", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

      { "<Leader>fC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<Leader>f:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { '<Leader>f/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { '<Leader>f"', function() Snacks.picker.registers() end, desc = "Registers" },
      { "<Leader>fa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },

      { "<Leader>fN", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<Leader>nN", function() Snacks.notifier.hide() end, desc = "Clear notifications" },

      { "<Leader>fn", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<Leader>fz", function() Snacks.picker.zoxide() end, desc = "Zoxide open project" },
      -- { "<Leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- find
      -- { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      -- { "<Leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<Leader>fgf", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<Leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<Leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      -- git
      { "<Leader>fgb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<Leader>fgl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<Leader>fgL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<Leader>fgs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<Leader>fgS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<Leader>fgd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<Leader>fgf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- Grep
      { "<Leader>fs", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<Leader>fS", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      -- { "<Leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      -- search
      -- { "<Leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      -- { "<Leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },

      { "<Leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<Leader>fH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<Leader>fi", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<Leader>fj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<Leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<Leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<Leader>fM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<Leader>fP", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },


      { "<Leader>fl", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<Leader>fu", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<Leader>fU", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

      -----------

      { "<Leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" }, -- find diag
      { "<Leader>fD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" }, -- find DIAG

      { "<Leader>ld", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" }, -- lsp diag
      { "<Leader>lD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" }, -- lsp DIAG

      { "<Leader>fL", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<Leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<Leader>lq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },

      -- gh
      { "<Leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<Leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      { "<Leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      { "<Leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },


      { "<Leader>t;", function() Snacks.terminal() end, desc = "Toggle terminal" },
      { "<Leader>zz", function() Snacks.zen() end, desc = "Toggle Zen mode" },
      { "<Leader>zi", function() Snacks.zen.zoom() end, desc = "Toggle Zen Zoom" },

    -- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    -- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    -- { "gr", function() Snacks.picker.lsp_references() end,  nowait = true, desc = "References" },
    -- { "gi", function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
    -- { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    -- { "gai", function() Snacks.picker.lsp_incoming_calls() end,  desc = "C[a]lls Incoming" },
    -- { "gao", function() Snacks.picker.lsp_outgoing_calls() end,  desc = "C[a]lls Outgoing" },
    -- { "<Leader>ls", function() Snacks.picker.lsp_symbols() end,  desc = "LSP Symbols" },
    -- { "<Leader>lS", function() Snacks.picker.lsp_workspace_symbols() end,  desc = "LSP Workspace Symbols" },
    -- { "<Leader>l`", function() Snacks.picker.lsp_config() end,  desc = "Pulls up the capabilities of various LSP servers" },

    -- LSP -- implemented in config/lsp.lua
    -- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    -- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    -- { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    -- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    -- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    -- { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
    -- { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
    -- { "<Leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    -- { "<Leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
  },
  --stylua: ignore end

  ---@type snacks.Config
  opts = {

    styles = {
      notification = {
        border = true,
      },
    },

    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below

    -- Efficient animations including over 45 easing functions _(library)_
    animate = { enabled = false },
    -- Deal with big files ‼️
    bigfile = { enabled = true },
    -- Delete buffers without disrupting window layout
    bufdelete = { enabled = false },
    -- Beautiful declarative dashboards ‼️
    dashboard = { enabled = false },
    -- Pretty inspect & backtraces for debugging
    debug = { enabled = true },
    -- Focus on the active scope by dimming the rest
    dim = { enabled = false },
    -- A file explorer (picker in disguise) ‼️
    explorer = { enabled = false },
    -- GitHub CLI integration
    gh = { enabled = true },
    -- Git utilities
    git = { enabled = false },
    -- Open the current file, branch, commit, or repo in a browser (e.g. GitHub, GitLab, Bitbucket)
    gitbrowse = { enabled = false },
    -- Image viewer using Kitty Graphics Protocol, supported by `kitty`, `wezterm` and `ghostty` ‼️
    image = {
      enabled = true,
      --
    },
    -- Indent guides and scopes
    indent = { enabled = false },
    -- Better `vim.ui.input` ‼️
    input = { enabled = true },
    -- Better `vim.keymap` with support for filetypes and LSP clients
    keymap = { enabled = true },
    -- Window layouts
    layout = { enabled = false },
    -- Open LazyGit in a float, auto-configure colorscheme and integration with Neovim
    lazygit = { enabled = false },
    -- Pretty `vim.notify` ‼️
    ---@class snacks.notifier.Config
    notifier = {
      enabled = true,
      timeout = 1750,
      margin = { top = 0, right = 0, bottom = 0 },
      top_down = false,
    },
    -- Utility functions to work with Neovim's `vim.notify`
    notify = {
      enabled = false,
    },
    -- Picker for selecting items ‼️
    ---@type snacks.picker.Config
    picker = {
      enabled = true,
      auto_confirm = true,
      show_delay = 0,
      jump = {
        tagstack = true,
        reuse_win = false,
      },
      toggles = {
        hidden = { icon = "h", value = true },
      },
      win = {
        input = {
          keys = { -- KEYS END
            ["<Esc>"] = { "close", mode = { "n", "i" } },

            ["<C-c>"] = { "cancel", mode = "i" },

            ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
            ["<CR>"] = { "confirm", mode = { "n", "i" } },

            ["<Down>"] = { "list_down", mode = { "i", "n" } },
            ["<Up>"] = { "list_up", mode = { "i", "n" } },
            ["<C-j>"] = { "list_down", mode = { "i", "n" } },
            ["<C-k>"] = { "list_up", mode = { "i", "n" } },

            ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },

            ["<C-y>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<C-e>"] = { "preview_scroll_down", mode = { "i", "n" } },

            ["<C-s>"] = { "edit_split", mode = { "i", "n" } },
            ["<C-v>"] = { "edit_vsplit", mode = { "i", "n" } },

            ["<C-q>"] = { "qflist", mode = { "i", "n" } },
            ["<C-t>"] = { "tab", mode = { "n", "i" } },

            ["<C-g>"] = { "toggle_live", mode = { "i", "n" } },

            ["<A-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<C-p>"] = { "cycle_win", mode = { "i", "n" } },

            -- ["<C-n>"] = { "list_down", mode = { "i", "n" } },
            -- ["<C-p>"] = { "list_up", mode = { "i", "n" } },

            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["/"] = "toggle_focus",
            ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
            ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
            -- ["<Esc>"] = "cancel",
            ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
            ["<A-d>"] = { "inspect", mode = { "n", "i" } },
            ["<C-a>"] = { "select_all", mode = { "n", "i" } },

            ["<C-d>"] = { "list_scroll_down", mode = { "i", "n" } },
            ["<C-u>"] = { "list_scroll_up", mode = { "i", "n" } },

            ["<C-w>H"] = "layout_left",
            ["<C-w>J"] = "layout_bottom",
            ["<C-w>K"] = "layout_top",
            ["<C-w>L"] = "layout_right",
            ["?"] = "toggle_help_input",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["q"] = "cancel",

            ["<C-r>#"] = { "insert_alt", mode = "i" },
            ["<C-r>%"] = { "insert_filename", mode = "i" },
            ["<C-r><c-a>"] = { "insert_cWORD", mode = "i" },
            ["<C-r><c-f>"] = { "insert_file", mode = "i" },
            ["<C-r><c-l>"] = { "insert_line", mode = "i" },
            ["<C-r><c-p>"] = { "insert_file_full", mode = "i" },
            ["<C-r><c-w>"] = { "insert_cword", mode = "i" },

            ["<A-f>"] = { "toggle_follow", mode = { "i", "n" } },
            ["<A-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<A-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<A-r>"] = { "toggle_regex", mode = { "i", "n" } },
            ["<A-m>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<A-p>"] = { "toggle_preview", mode = { "i", "n" } },
          },
        }, -- INPUT END
        -- result list window
        list = {
          keys = {
            ["/"] = "toggle_focus",
            ["<2-LeftMouse>"] = "confirm",
            ["<CR>"] = "confirm",
            ["<Down>"] = "list_down",
            ["<Esc>"] = "cancel",
            ["<S-CR>"] = { { "pick_win", "jump" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
            ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
            ["<Up>"] = "list_up",
            ["<a-d>"] = "inspect",
            ["<a-f>"] = "toggle_follow",
            ["<a-h>"] = "toggle_hidden",
            ["<a-i>"] = "toggle_ignored",
            ["<a-m>"] = "toggle_maximize",
            ["<a-p>"] = "toggle_preview",
            ["<a-w>"] = "cycle_win",
            ["<c-a>"] = "select_all",
            ["<c-b>"] = "preview_scroll_up",
            ["<c-d>"] = "list_scroll_down",
            ["<c-f>"] = "preview_scroll_down",
            ["<c-j>"] = "list_down",
            ["<c-k>"] = "list_up",
            ["<c-n>"] = "list_down",
            ["<c-p>"] = "list_up",
            ["<c-q>"] = "qflist",
            ["<c-g>"] = "print_path",
            ["<c-s>"] = "edit_split",
            ["<c-t>"] = "tab",
            ["<c-u>"] = "list_scroll_up",
            ["<c-v>"] = "edit_vsplit",
            ["<c-w>H"] = "layout_left",
            ["<c-w>J"] = "layout_bottom",
            ["<c-w>K"] = "layout_top",
            ["<c-w>L"] = "layout_right",
            ["?"] = "toggle_help_list",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["i"] = "focus_input",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["q"] = "cancel",
            ["zb"] = "list_scroll_bottom",
            ["zt"] = "list_scroll_top",
            ["zz"] = "list_scroll_center",
          },
          wo = {
            conceallevel = 2,
            concealcursor = "nvc",
          },
        }, -- LIST END

        -- preview window
        preview = {
          -- on_win = function(win)
          -- end,
          keys = {
            ["<Esc>"] = "cancel",
            ["q"] = "cancel",
            ["i"] = "focus_input",
            ["<a-w>"] = "cycle_win",
          },
        }, -- PREVIEW END
      }, -- WIN END

      files = {
        hidden = true,
      },
      smart = {
        multi = { "buffers", "recent", "files", "hidden" },
        exclude = { "node_modules", ".git/", ".next/", ".turbo/" },
        show_empty = false,
        hidden = true,
      },
    }, -- PICKER END

    -- Neovim lua profiler
    profiler = { enabled = false },
    -- When doing `nvim somefile.txt`, it will render the file as quickly as possible, before loading your plugins. ‼️
    quickfile = { enabled = true },
    -- LSP-integrated file renaming with support for plugins like [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) and [mini.files](https://github.com/nvim-mini/mini.files).
    rename = { enabled = true },
    -- Scope detection, text objects and jumping based on treesitter or indent ‼️
    scope = { enabled = false },
    -- Scratch buffers with a persistent file
    scratch = { enabled = false },
    -- Smooth scrolling ‼️
    scroll = { enabled = false },
    -- Pretty status column ‼️
    statuscolumn = { enabled = false },
    -- Create and toggle floating/split terminals
    terminal = {
      enabled = true,
    },
    -- Toggle keymaps integrated with which-key icons / colors
    toggle = { enabled = true },
    -- Utility functions for Snacks _(library)_
    util = { enabled = true },
    -- Create and manage floating windows or splits
    win = { enabled = false },
    -- Auto-show LSP references and quickly navigate between them ‼️
    words = {
      enabled = false,
      debounce = 200, -- time in ms to wait before updating
      notify_jump = false, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { "n", "i", "c" }, -- modes to show references
      filter = function(buf) -- what buffers to enable `snacks.words`
        return vim.g.snacks_words ~= false and vim.b[buf].snacks_words ~= false
      end,
    },
    -- Zen mode • distraction-free coding
    ---@type snacks.zen.Config
    zen = {
      enabled = true,

      -- You can add any `Snacks.toggle` id here.
      -- Toggle state is restored when the window is closed.
      -- Toggle config options are NOT merged.
      ---@type table<string, boolean>
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        -- diagnostics = false,
        -- inlay_hints = false,
      },
      center = true, -- center the window
      show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
      },
      ---@type snacks.win.Config
      win = { style = "zen" },
      -- --- Callback when the window is opened.
      -- ---@param win snacks.win
      -- on_open = function(win) end,
      -- --- Callback when the window is closed.
      -- ---@param win snacks.win
      -- on_close = function(win) end,
      --- Options for the `Snacks.zen.zoom()`
      zoom = {
        toggles = {
          dim = true,
          line_numbers = true,
          words = true,
          git_signs = false,
        },
        center = true,
        show = { statusline = true, tabline = true },
        win = {
          style = "zen",
          backdrop = false,
          width = 0, -- full width
        },
      },
    },
  },
}
