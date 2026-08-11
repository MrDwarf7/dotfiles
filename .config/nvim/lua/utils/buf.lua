---@class utils.Buf
local Buf = {
  debugging = false,
}

function Buf.delete(opts)
  ---@cast opts utils.Buf.delete.Opts|nil
  opts = opts or {}
  opts = type(opts) == "number" and { buf = opts } or opts
  opts = type(opts) == "function" and { filter = opts } or opts

  if type(opts.filter) == "function" then
    for _, b in ipairs(vim.tbl_filter(opts.filter, vim.api.nvim_list_bufs())) do
      if vim.bo[b].buflisted then
        Buf.delete(vim.tbl_extend("force", {}, opts, { buf = b, filter = false }))
      end
    end
    return
  end

  local buf = opts.buf or 0
  if opts.file then
    buf = vim.fn.bufnr(opts.file)
    if buf == -1 then
      return
    end
  end
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  -- Check if the buffer is modified
  if vim.bo[buf].modified and not opts.force then
    local ok, choice = pcall(vim.fn.confirm, ("Save changes to %q?"):format(vim.fn.bufname(buf)), "&Yes\n&No\n&Cancel")
    if not ok or choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    elseif choice == 1 then -- Yes
      vim.api.nvim_buf_call(buf, vim.cmd.write)
    end
  end

  -- Get the most recently used listed buffer that is not the one being deleted,
  local info = vim.fn.getbufinfo({ buflisted = 1 })
  ---@param b vim.fn.getbufinfo.ret.item
  info = vim.tbl_filter(function(b)
    return b.bufnr ~= buf
  end, info)
  table.sort(info, function(a, b)
    return a.lastused > b.lastused
  end)

  local new_buf = info[1] and info[1].bufnr or vim.api.nvim_create_buf(true, false)

  -- replace the buffer in all windows showing it,
  -- trying to use the alternate buffer if possible
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    local win_buf = new_buf
    vim.api.nvim_win_call(win, function() -- Try using alternate buffer
      local alt = vim.fn.bufnr("#")
      win_buf = alt >= 0 and alt ~= buf and vim.bo[alt].buflisted and alt or win_buf
    end)
    vim.api.nvim_win_set_buf(win, win_buf)
  end

  if vim.api.nvim_buf_is_valid(buf) then
    ---@diagnostic disable-next-line: param-type-mismatch
    pcall(vim.cmd, (opts.wipe and "bwipeout! " or "bdelete! ") .. buf)
  end

  return Buf
end

function Buf.all(opts)
  return Buf.delete(vim.tbl_extend("force", {}, opts or {}, {
    filter = function()
      return true
    end,
  }))
end

function Buf.other(opts)
  return Buf.delete(vim.tbl_extend("force", {}, opts or {}, {
    filter = function(b)
      return b ~= vim.api.nvim_get_current_buf()
    end,
  }))
end

function Buf.is_valid(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or opts.buf or vim.api.nvim_get_current_buf() or 0

  -- stylua: ignore start
  local bufisvalid = vim.api.nvim_buf_is_valid(bufnr)             -- bool: true if the buffer is valid (exists and is loaded)
  local lc_gt_one = vim.api.nvim_buf_line_count(bufnr) > 1        -- bool: true if the buffer has more than 1 line

  local bufname = vim.api.nvim_buf_get_name(bufnr)                -- string: returns whatever the buffer name is (empty string if no name)
  local bufname_len = string.len(bufname) or #bufname             -- integer: length of the buffer name string
  local bufname_not_empty = bufname_len > 0 and bufname ~= ""     -- bool: true if the buffer has a name (not empty string)
  -- stylua: ignore end

  return bufisvalid and (lc_gt_one or bufname_not_empty)
  -- all conditions must be true for the buffer to be considered 'valid'
end

function Buf.setup()
  return setmetatable(Buf, {
    __call = function(t, ...)
      return t.delete(...)
    end,
    __index = Buf,
  })
end

---@return utils.Buf
return Buf.setup()
