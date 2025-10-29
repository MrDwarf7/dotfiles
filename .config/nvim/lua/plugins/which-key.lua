return {
  "folke/which-key.nvim",
  event = "CursorMoved",
  opts = {
    preset = "modern",
    spec = {
      { "<Leader>a", group = "jj/jujutsu" },
      { "<Leader>h", group = "+[H]unk(s)" },
      { "<Leader>l", group = "+[L]SP" },
      { "<Leader>p", group = "+[P]lugins" },
      { "<Leader>m", group = "+[M]arks" },
      { "<Leader>f", group = "+[F]ind" },
      { "<Leader>t", group = "+[T]oggles" },
      { "<Leader>b", group = "+[B]uffers" },
      { "<Leader>x", group = "+trouble" },
      { "<Leader>g", group = "+[G]it & GO" },
    },
  },
}
