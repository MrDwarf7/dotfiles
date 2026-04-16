-- local notify_enabled = function()
--   if package.loaded["snacks"] then
--     if package.loaded["snacks.notify"] then
--       return false
--     else
--       return true
--     end
--   end
-- end
--
-- local should_enable = notify_enabled()

return {
  "folke/noice.nvim",
  enabled = true,
  -- event = "VeryLazy",
  lazy = false,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    { "MunifTanjim/nui.nvim", lazy = false },
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    { "rcarriga/nvim-notify", lazy = false },
  },
  keys = {
    -- stylua: ignore start
    { "<Leader>na", function() vim.cmd("NoiceAll") end,     desc = "Noice [a]ll" },
    { "<Leader>nl", function() vim.cmd("NoiceLast") end,    desc = "Noice [l]ast" },
    { "<Leader>nh", function() vim.cmd("NoiceHistory") end, desc = "Noice [h]istory" },
    { "<Leader>ns", function() vim.cmd("NoiceSuspend") end, desc = "Noice [s]uspend" },
    { "<Leader>nn", function() vim.cmd("NoiceDismiss") end, desc = "Noice [n]o/dismiss" },
    { "<Leader>np", function() vim.cmd("NoicePick") end, desc = "Noice [p]icker" },
    -- stylua: ignore end
  },
  opts = {
    -- Might be able to get away with _just_ the opts.notify.enabled = true and not have to set up the route?
    routes = {
      {
        filter = { event = "notify" },
        view = "notify",
        opts = {
          backend = "snacks",
        },
      },
    },
    notify = {
      enabled = false,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        -- ["cmp.entry.get_documentation"] = true,
      },
      -- cmdline = {
      --   format = {
      --     -- lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      --     -- help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      --     lua = false,
      --     help = { pattern = { false }, icon = "" },
      --   },
      -- },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
      inc_rename = true,
    },
  },
}
