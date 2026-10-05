local hunk_nav_settings = {
  count = 1,
  wrap = true,
  target = "all",
  preview = false,
  foldopen = false,
  greedy = false,
  navigation_message = false,
}

local prev_hunk = function()
  --
  require("gitsigns").nav_hunk(
    "prev",
    hunk_nav_settings,
    vim.schedule(function()
      if vim.api.nvim_get_mode().mode == "n" and vim.bo.buftype == "" then
        vim.cmd("normal! zz")
      end
    end)
  )
end

local next_hunk = function()
  --
  require("gitsigns").nav_hunk(
    "next",
    hunk_nav_settings,
    vim.schedule(function()
      if vim.api.nvim_get_mode().mode == "n" and vim.bo.buftype == "" then
        vim.cmd("normal! zz")
      end
    end)
  )
end

---@see gitsigns-config-current_line_blame_formatter
-- Type: `string|function`, Default: `" <author>, <author_time:%R> - <summary> "`
--
-- String or function used to format the virtual text of
-- |gitsigns-config-current_line_blame|.
--
-- When a string, accepts the following format specifiers:
--
--     • `<abbrev_sha>`
--     • `<orig_lnum>`
--     • `<final_lnum>`
--     • `<author>`
--     • `<author_mail>`
--     • `<author_time>` or `<author_time:FORMAT>`
--     • `<author_tz>`
--     • `<committer>`
--     • `<committer_mail>`
--     • `<committer_time>` or `<committer_time:FORMAT>`
--     • `<committer_tz>`
--     • `<summary>`
--     • `<previous>`
--     • `<filename>`
--
--   For `<author_time:FORMAT>` and `<committer_time:FORMAT>`, `FORMAT` can
--   be any valid date format that is accepted by `os.date()` with the
--   addition of `%R` (defaults to `%Y-%m-%d`):
--
--     • `%a`  abbreviated weekday name (e.g., Wed)
--     • `%A`  full weekday name (e.g., Wednesday)
--     • `%b`  abbreviated month name (e.g., Sep)
--     • `%B`  full month name (e.g., September)
--     • `%c`  date and time (e.g., 09/16/98 23:48:10)
--     • `%d`  day of the month (16) [01-31]
--     • `%H`  hour, using a 24-hour clock (23) [00-23]
--     • `%I`  hour, using a 12-hour clock (11) [01-12]
--     • `%M`  minute (48) [00-59]
--     • `%m`  month (09) [01-12]
--     • `%p`  either "am" or "pm" (pm)
--     • `%S`  second (10) [00-61]
--     • `%w`  weekday (3) [0-6 = Sunday-Saturday]
--     • `%x`  date (e.g., 09/16/98)
--     • `%X`  time (e.g., 23:48:10)
--     • `%Y`  full year (1998)
--     • `%y`  two-digit year (98) [00-99]
--     • `%%`  the character `%`
--     • `%R`  relative (e.g., 4 months ago)
--
-- When a function:
--   Parameters: ~
--     {name}       Git user name returned from `git config user.name` .
--     {blame_info} Table with the following keys:
--                    • `abbrev_sha`: string
--                    • `orig_lnum`: integer
--                    • `final_lnum`: integer
--                    • `author`: string
--                    • `author_mail`: string
--                    • `author_time`: integer
--                    • `author_tz`: string
--                    • `committer`: string
--                    • `committer_mail`: string
--                    • `committer_time`: integer
--                    • `committer_tz`: string
--                    • `summary`: string
--                    • `previous`: string
--                    • `filename`: string
--                    • `boundary`: true?
--
--                  Note that the keys map onto the output of:
--                    `git blame --line-porcelain`
--
--   Return: ~
--     The result of this function is passed directly to the `opts.virt_text`
--     field of |nvim_buf_set_extmark| and thus must be a list of
--     [text, highlight] tuples.

return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  -- event = "BufReadPre",
  keys = {

    -- stylua: ignore start
    -- stylua: ignore end

    -- Disable a bunch of built-ins
    -- stylua: ignore start
    { "<Leader>hp", function() return require("gitsigns").preview_hunk() end,              desc = "[p]review hunk" },
    { "<Leader>hs", function() return require("gitsigns").stage_hunk() end,                desc = "[s]tage hunk" },
    { "<Leader>hr", function() return require("gitsigns").reset_hunk() end,                desc = "[r]eset hunk" },
    { "<Leader>hR", function() return require("gitsigns").reset_buffer() end,              desc = "[R]eset buffer" },
    { "<Leader>hS", function() return require("gitsigns").stage_buffer() end,              desc = "[S]tage buffer" },
    -- { "<Leader>hu", function() return require("gitsigns").undo_stage_hunk() end,           desc = "[u]ndo stage" },
    { "<Leader>hb", function() return require("gitsigns").blame_line({ full = true }) end, desc = "[b]lame line" },
    { "<Leader>hB", function() return require("gitsigns").blame() end, desc = "[b]lame line" },
    { "<Leader>hT", function() return require("gitsigns").toggle_current_line_blame() end, desc = "[T]oggle deleted" },
    -- { "<Leader>ht", function() return require("gitsigns").toggle_deleted() end,            desc = "[t]oggle blame" },
    { "<Leader>ht", function() return require("gitsigns").preview_hunk_inline() end,            desc = "[t]oggle blame" },
    { "<Leader>hd", function() return require("gitsigns").diffthis() end,                  desc = "[d]iff this" },
    { "<Leader>hD", function() return require("gitsigns").diffthis("main") end,            desc = "[D]iff main" },
    -- stylua: ignore end

    {
      "[c",
      prev_hunk,
      desc = "[p]revious hunk",
      mode = { "n", "v" },
    },

    {
      "]c",
      next_hunk,
      desc = "[n]ext hunk",
      mode = { "n", "v" },
    },

    {
      "[h",
      prev_hunk,
      desc = "[p]revious hunk",
      mode = { "n", "v" },
    },

    {
      "]h",
      next_hunk,
      desc = "[n]ext hunk",
      mode = { "n", "v" },
    },
  },

  ---@type Gitsigns.Config
  opts = {
    signs = {
      add = { text = "│" },
      changedelete = { text = "~" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      untracked = { text = "│" },
    },

    signs_staged = {
      add = { text = "│" },
      changedelete = { text = "~" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      untracked = { text = "│" },
    },
    signs_staged_enable = true,
    -- worktrees = {},

    signcolumn = true,
    numhl = false, -- Colored sign colum numbers: default: false,
    linehl = false, -- Colored line-hunks: default: false,
    word_diff = false, -- Colored word-diffs (very distracting): default: false,
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true, -- default: true,
    attach_to_untracked = false, -- default: false
    current_line_blame = true, -- Line blame default state: default: false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 300,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },

    ---@see gitsigns-config-current_line_blame_formatter
    current_line_blame_formatter = "\t\t<author>, <author_time:%R> - <summary>",

    -- blame_formatter = nil, -- Use default
    -- trouble = true, -- default: true if trouble is also already installed
    gh = true, -- enable intergration with the gh-cli/gh cli: default: false

    sign_priority = 6,
    update_debounce = 100,
    -- status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },

    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      -- local function map(mode, lhs, rhs, desc)
      --   vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
      -- end
      local map = vim.keymap.set

      map("o", "ih", gs.select_hunk, { desc = "select hunk" })
      map("x", "ih", gs.select_hunk, { desc = "select hunk" })
    end,
  },
}
