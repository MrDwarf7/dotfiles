local M = {}

M.align_selection_by_char = function()
  -- Ensure we are in visual mode
  if not vim.tbl_contains({ "v", "V", "\22" }, vim.fn.mode()) then
    require("utils").output.warn("Align by char can only be used in visual mode")
    return
  end

  local sep = vim.fn.input("Enter table separator: ")
  if sep == "" then
    sep = "&"
  end

  -- Get positions of the selection
  local s_pos = vim.fn.getpos("v")
  local e_pos = vim.fn.getpos(".")

  local s_row, e_row = s_pos[2], e_pos[2]
  if s_row > e_row then
    s_row, e_row = e_row, s_row
  end

  -- Get selected lines from the buffer (0-based indexing)
  ---@alias lines string[]
  local lines = vim.api.nvim_buf_get_lines(0, s_row - 1, e_row, false)
  if not lines or #lines == 0 then
    require("utils").output.warn("No lines selected")
    return
  end

  local split_lines, col_widths, indents = {}, {}, {}

  -- local indent = nil

  ---@param line string
  for _, line in ipairs(lines) do
    -- Detect indentation (spaces or tabs)
    local indent = line:match("^%s*") or ""
    table.insert(indents, indent)

    -- Remove indentation before splitting
    local stripped = line:sub(#indent + 1)
    local cols = vim.split(stripped, sep, { trimempty = true })
    table.insert(split_lines, cols)

    -- Compute max width for each column
    for i, col in ipairs(cols) do
      local width = vim.fn.strdisplaywidth(vim.trim(col))
      col_widths[i] = math.max(col_widths[i] or 0, width)
    end
  end

  -- Rebuild aligned lines
  local aligned_lines = {}
  for idx, cols in ipairs(split_lines) do
    local aligned = {}
    for i, col in ipairs(cols) do
      local txt = vim.trim(col)
      local pad = col_widths[i] - vim.fn.strdisplaywidth(txt)
      -- need to remove the space between last char on the line, and 'free' spaces that aren't
      -- actually doing anything, and are just padding the line out to the right

      table.insert(aligned, txt .. string.rep(" ", pad))
    end
    table.insert(aligned_lines, indents[idx] .. table.concat(aligned, " " .. sep .. " "))
  end

  -- Replace the original lines in the buffer with aligned ones
  vim.api.nvim_buf_set_lines(0, s_row - 1, e_row, false, aligned_lines)
end

return M
