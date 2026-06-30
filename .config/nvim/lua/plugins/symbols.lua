return {
  -- {
  "oskarrrrrrr/symbols.nvim",
  version = "*",
  keys = {
    { "<Leader>ls", "<CMD>Symbols<CR>", desc = "Symbols Open" },
    { "<Leader>lS", "<CMD>SymbolsClose<CR>", desc = " Symbols Close" },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "SymbolsHelp" },
      callback = function()
        vim.keymap.set("n", "<Esc>", function()
          vim.api.nvim_buf_delete(0, { force = true })
        end, { silent = true, buffer = true })
      end,
    })
  end,
  opts = {
    sidebar = {
      hide_cursor = false,
      -- open_direction = "try-right",
      open_direction = "try-left",
      on_open_make_windows_eqal = false,
      cursor_follow = true,
      auto_resize = {
        -- When enabled the sidebar will be resized whenever the view changes.
        -- For example, after folding/unfolding symbols, after toggling inline details
        -- or whenever the source file is saved.
        enabled = true,
        -- The sidebar will never be auto resized to a smaller width then `min_width`.
        min_width = 20,
        -- The sidebar will never be auto resized to a larger width then `max_width`.
        max_width = 40,
      },
    },
    fixed_width = 40,

    show_inline_details = false, -- off by default
    show_details_pop_up = false, -- off by default
    auto_peek = false,
    unfold_on_goto = true, -- sends a `zv` after `zz`
    close_on_goto = false, -- close the sidebar on goto symbol
    wrap = false,
    show_guide_lines = true,

    preview = {
      show_always = true,
      show_line_number = true,
      -- Whether to determine the preview window's height automatically.
      auto_size = true,
      -- The total number of extra lines shown in the preview window.
      auto_size_extra_lines = 6,
      -- Minimum window height when `auto_size` is true.
      min_window_height = 7,
      -- Maximum window height when `auto_size` is true.
      max_window_height = 30,
      -- Preview window size when `auto_size` is false.
      fixed_size_height = 12,
      -- Desired preview window width. Actuall width will be capped at
      -- the current width of the source window width.
      window_width = 100,
      -- Keymaps for actions in the preview window. Available actions:
      -- close: Closes the preview window.
      -- goto-code: Changes window to the source code and moves cursor to
      --            the same position as in the preview window.
      -- Note: goto-code is not set by default because the most natual
      -- key would be Enter but some people already have that key mapped.
      keymaps = {
        ["q"] = "close",
      },
    },
    -- keymaps = {},
    providers = {
      -- Order in which providers will be called to get symbols.
      priority = {
        -- Default in case other rules are not defined.
        ["*"] = { "treesitter", "lsp" },
        -- Treesitter provider for JSON can be slow for large files.
        json = { "lsp", "treesitter" },
      },
      -- Override the priority using extra context.
      -- Input has the following fields:
      --  * filetype string
      --  * path string - absolute path
      --
      -- Return `nil` to fall back to `priority` table.
      ---@diagnostic disable-next-line: unused-local
      priority_fun = function(input)
        return nil
      end,
      lsp = {
        timeout_ms = 1000,
        details = {},
        kinds = { default = {} },
        -- highlights = {
        --     -- ...
        --     default = { }
        -- },
      },
      treesitter = {
        details = {},
        kinds = { default = {} },
        -- highlights = {
        --     -- ...
        --     default = {}
        -- }
      },
    },
  },
  -- },
  -- We know aerial work, but symbols has some nice features that look useful
  -- {
  --   "stevearc/aerial.nvim",
  --   enabled = false,
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },
  -- {
  --   "hedyhli/outline.nvim",
  --   enabled = false,
  --   opts = {},
  -- },
}
