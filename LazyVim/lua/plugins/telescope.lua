-- local keys = {
--   { "<leader><space>", false },
--   --
--   { "<leader>fw", telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
--   { "<leader>fW", telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
--   { "<leader>fg", telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
--   { "<leader>fG", telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
-- }

return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
