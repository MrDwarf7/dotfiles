---@class CommentSwapDefaults
---@field normalize_ws boolean collapse comment-prefix gap (fixes `--       foo`); indent is always preserved
---@field yank_line_detection boolean clone+comment the target when its leading token differs from current
---@field move_cursor boolean land the cursor on the target line afterwards

---@class CommentSwapComputed : CommentSwapDefaults
---@field direction CommentSwapDirectionEnum The direction we're swapping in
---@field comment_prefix string = (vim.bo.commentstring):match("^(.*)%%s") or vim.bo.commentstring,
---@field target_row integer CommentSwapDirectionEnum.above and row - 1 or row + 1,
---@field line_target string The content of the target line (above/below)

---@class CommentSwapOpts : CommentSwapDefaults
---@field direction CommentSwapDirectionEnum  sibling line to swap with (above/below)
---@field yank_line_detection boolean  when true, a target whose leading token differs from the current line is copied+commented instead of toggled, so you can "swap" between two similar but distinct statements
---@field normalize_ws boolean  collapse the gap between the comment prefix and the body, fixing `--       foo` space growth. Leading indentation is ALWAYS preserved regardless of this flag.
---@field move_cursor boolean  move the cursor onto the target line after the operation

---@enum CommentSwapDirectionEnum
local CommentSwapDirectionEnum = {
  above = "above",
  below = "below",
}

---@class CommentSwapModule
---@field CommentSwapDirectionEnum table
---@field direction CommentSwapDirectionEnum|"above"|"below"
---@field CommentSwapDefaults CommentSwapDefaults
---@field handle_comment_swap fun(opts: CommentSwapOpts)
local M = {}

M.CommentSwapDefaults = {
  normalize_ws = true,
  yank_line_detection = false,
  move_cursor = false,
}
M.defaults = M.CommentSwapDefaults
M.CommentSwapDirectionEnum = CommentSwapDirectionEnum

---@param opts CommentSwapOpts
local handle_comment_swap = function(opts)
  -- Known defaults for the optional feature flags. Anything passed in `opts`
  -- overrides these when merged below (tbl_deep_extend "force").

  ---@type CommentSwapDefaults
  -- local defs = {
  --   normalize_ws = true, -- collapse comment-prefix gap (fixes `--       foo`); indent is always preserved
  --   yank_line_detection = false, -- clone+comment the target when its leading token differs from current
  --   move_cursor = false, -- land the cursor on the target line afterwards
  -- }

  local defs = M.CommentSwapDefaults

  local o = vim.tbl_deep_extend("force", defs, opts or {}) ---@cast o CommentSwapOpts

  local direction = o.direction
  if direction ~= CommentSwapDirectionEnum.above and direction ~= CommentSwapDirectionEnum.below then
    error("Invalid direction: " .. tostring(direction))
    return
  end

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1], cursor_pos[2]

  local line_current = vim.api.nvim_get_current_line()

  --- Computed/derived state. Missing keys fall through to the merged opts (`o`)
  --- via the metatable, so options and derived values share one handle.
  ---@type CommentSwapComputed
  local computed = {
    direction = direction,
    comment_prefix = (vim.bo.commentstring):match("^(.*)%%s") or vim.bo.commentstring,
    target_row = direction == CommentSwapDirectionEnum.above and row - 1 or row + 1,
  }
  setmetatable(computed, { __index = o })

  ---@param target_row integer
  ---@return string
  local get_line = function(target_row)
    return vim.api.nvim_buf_get_lines(0, target_row - 1, target_row, false)[1] or ""
  end

  computed.line_target = get_line(computed.target_row)

  --- Split into (indent, body). Indent is the leading whitespace we never
  --- mutate; body is everything after it. Splitting first is what lets us
  --- detect the leading token and toggle without disturbing alignment.
  ---@param line_state string
  ---@return string indent
  ---@return string body
  local split_indent = function(line_state)
    return line_state:match("^(%s*)(.*)$")
  end

  ---@param line_state string
  ---@return boolean
  local is_commented = function(line_state)
    local _, body = split_indent(line_state)
    return body:find("^" .. vim.pesc(computed.comment_prefix)) ~= nil
  end

  --- Toggle one line's comment state, preserving indent. With normalize_ws
  --- the prefix->body gap is fully collapsed; otherwise only one space is
  --- dropped (legacy behaviour).
  ---@param line_state string
  ---@return string
  local toggle_line = function(line_state)
    local indent, body = split_indent(line_state)
    if is_commented(line_state) then
      local pat = "^" .. vim.pesc(computed.comment_prefix) .. (computed.normalize_ws and "%s*" or "%s?")
      return indent .. body:gsub(pat, "", 1)
    end
    return indent .. computed.comment_prefix .. body
  end

  --- First non-space token of a line's *content* (prefix stripped), used to
  --- decide same vs different statement. Must look past the comment prefix so a
  --- commented `brightness` matches an uncommented `brightness`.
  ---@param line_state string
  ---@return string?
  local leading_token = function(line_state)
    local _, body = split_indent(line_state)
    body = body:gsub("^" .. vim.pesc(computed.comment_prefix) .. "%s*", "")
    return body:match("%S+")
  end

  ---@param line_num integer
  ---@param content string
  local update_line = function(line_num, content)
    vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { content })
  end

  if computed.yank_line_detection and leading_token(computed.line_target) ~= leading_token(line_current) then
    -- Different statement: clone the current line (commented) into target,
    -- leave current untouched. Next press the two match -> normal swap.
    update_line(computed.target_row, toggle_line(line_current))
  else
    -- Same statement (or detection off): toggle-swap both lines.
    update_line(row, toggle_line(line_current))
    update_line(computed.target_row, toggle_line(computed.line_target))
  end

  if computed.move_cursor then
    vim.api.nvim_win_set_cursor(0, { computed.target_row, col })
  end
end

setmetatable(M, {
  __index = function(_, key)
    local lkey = string.lower(key)
    if lkey == "commentswapdefaults" or lkey == "defaults" then
      return M.CommentSwapDefaults
    elseif lkey == "direction" then
      return M.CommentSwapDirectionEnum
    else
      if not rawget(M, key) then
        error("Attempt to access undefined key: " .. tostring(key))
      end
      return rawget(M, key)
    end
  end,
  __call = function(_, opts)
    return handle_comment_swap(opts)
  end,
})

M.handle_comment_swap = handle_comment_swap

---@return CommentSwapModule
return M
