return {
  -- Enhances the gf, gF, and gx commands
  --
  -- gf: Opens the next valid file after the cursor. Use [count]gf to jump to the count'th file.
  -- gF: Opens the next file and places the cursor at the count'th line.
  -- gx: Opens the next valid URL after the cursor. Use [count]gx to jump to the count'th URL.
  -- Examples:
  --
  --     2gf → Opens the second valid file after the cursor.
  --     10gF → Opens the next valid file after the cursor at line 10.
  --     eval.c:20 → Opens eval.c at line 20 when used with gF.
  "HawkinsT/pathfinder.nvim",
}
