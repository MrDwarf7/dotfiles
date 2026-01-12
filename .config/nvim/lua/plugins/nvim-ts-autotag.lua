return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter", lazy = true },
  setup = function(opts) -- -- thanks, I hate it. Just use the `opts` table and keep it compatible instead of moving _AWAY_ from the standard??????????????
    opts = vim.tbl_deep_extend("force", opts, {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
    })

    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    local per_filetype = {
      ["html"] = {
        enable_close = false,
      },
    }

    require("nvim-ts-autotag").setup({
      opts = opts,
      per_filetype = per_filetype,
    })
  end,
  -- opts = {
  --   enable_close = true, -- Auto close tags
  --   enable_rename = true, -- Auto rename pairs of tags
  --   enable_close_on_slash = false, -- Auto close on trailing
  -- },

  -- Example docs have it out here????
  -- per_filetype = {
  -- }
}
