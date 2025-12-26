---@type LazyPluginBase
return {
  "sindrets/winshift.nvim",
  lazy = true,
  -- event = "BufReadPost",
  ---@type LazyKeys
  keys = {
    { "<Leader>w", "+[w]inShift", desc = "+[w]inShift", mode = "n" },
    { "<Leader>ww", "<CMD>WinShift<CR>", silent = true, noremap = true },
    { "<Leader>wh", "<CMD>WinShift left<CR>", silent = true, noremap = true },
    { "<Leader>wj", "<CMD>WinShift down<CR>", silent = true, noremap = true },
    { "<Leader>wk", "<CMD>WinShift up<CR>", silent = true, noremap = true },
    { "<Leader>wl", "<CMD>WinShift right<CR>", silent = true, noremap = true },
    { "<Leader>wH", "<CMD>WinShift far_left<CR>", silent = true, noremap = true },
    { "<Leader>wJ", "<CMD>WinShift far_down<CR>", silent = true, noremap = true },
    { "<Leader>wK", "<CMD>WinShift far_up<CR>", silent = true, noremap = true },
    { "<Leader>wL", "<CMD>WinShift far_right<CR>", silent = true, noremap = true },
  },
  opts = {},
}
