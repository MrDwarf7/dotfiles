return {
  "folke/which-key.nvim",
  ---@type LazyEventSpec
  event = "CursorMoved",
  opts = {
    preset = "modern",
    spec = {
      { "<Leader>a", group = "jj/jujutsu" },
      { "<Leader>b", group = "+[B]uffers" },
      { "<Leader>f", group = "+[F]ind" },
      { "<Leader>g", group = "+[G]it & GO" },
      { "<Leader>h", group = "+[H]unk(s)" },
      { "<Leader>l", group = "+[L]SP" },
      { "<Leader>m", group = "+[M]arks" },
      { "<Leader>n", group = "+[N]otifications" },
      { "<Leader>o", group = "+Ne[O]Test" },
      { "<Leader>p", group = "+[P]lugins" },
      { "<Leader>Q", group = "+Sessions" },
      { "<Leader>r", group = "+[R]equests (http)" },
      { "<Leader>s", group = "+[S]essions" },
      { "<Leader>t", group = "+[T]oggles" },
      { "<Leader>x", group = "+[T]rouble" },
      { "<Leader>y", group = "+[Y]ank paths" },
      { "<Leader>yc", group = "Copy [Y]ank [C]wd" },
      { "<Leader>yC", group = "Copy [Y]ank [C]wd (full path)" },
    },
  },
}
