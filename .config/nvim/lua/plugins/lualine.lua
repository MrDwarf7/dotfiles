local reg_component = function()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return "Recording @" .. reg
end

local wk_hook_for_op_pending = function()
  local wk_state = require("which-key.state") -- .safe()
  local state, reason = wk_state.safe()
  if not state then
    vim.notify("which-key: could not get state: " .. reason, vim.log.levels.ERROR)
    return
  else
    dd(state)
  end
end

return {
  -- { "AndreM222/copilot-lualine" },
  "nvim-lualine/lualine.nvim",
  -- enabled = false,
  lazy = true,
  -- event = "CursorMoved",
  event = "UiEnter",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", lazy = true },
    -- { "AndreM222/copilot-lualine" },
  },

  opts = function(_, opts)
    local symbols = require("trouble").statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      hl_group = "lualine_c_normal",
    })

    return vim.tbl_deep_extend(
      "force",
      {},
      -- opts or {},
      {
        theme = "tokyonight",
        sections = {
          lualine_c = {
            -- 1 is only the current file, 2 expands EVERYTHING, 3 expands but maintains things like `~`,
            { "filename", file_status = true, path = 3 },
            { symbols.get, cond = symbols.has }, -- struture symbols/tree
          },
          lualine_x = {
            -- { symbols.get, cond = symbols.has },
            -- { "filename", file_status = true, path = 3 },
            -- "'@'vim.fn.reg_recording()",
            -- "reg_component",
            { wk_hook_for_op_pending },
            { reg_component },
            "selectioncount",
            "encoding",
            "fileformat",
            "filetype",
          },
        },
      }
    )
  end,
}
