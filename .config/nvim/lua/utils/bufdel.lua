---@class utils.BufDel
local BufDel = {
  debugging = false,
}
-- local BufDel = setmetatable({}, {
--   __call = function(t, ...)
--     return t.delete(...)
--   end,
-- })

function BufDel.delete(opts)
  ---@cast opts utils.BufDel.Opts|nil
  opts = opts or {}
  opts = type(opts) == "number" and { buf = opts } or opts
  opts = type(opts) == "function" and { filter = opts } or opts

  if type(opts.filter) == "function" then
    for _, b in ipairs(vim.tbl_filter(opts.filter, vim.api.nvim_list_bufs())) do
      if vim.bo[b].buflisted then
        BufDel.delete(vim.tbl_extend("force", {}, opts, { buf = b, filter = false }))
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
    local ok, choice =
        pcall(vim.fn.confirm, ("Save changes to %q?"):format(vim.fn.bufname(buf)), "&Yes\n&No\n&Cancel")
    if not ok or choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    elseif choice == 1 then                    -- Yes
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
    pcall(vim.cmd, (opts.wipe and "bwipeout! " or "bdelete! ") .. buf)
  end

  return BufDel
end

function BufDel.all(opts)
  return BufDel.delete(vim.tbl_extend("force", {}, opts or {}, {
    filter = function()
      return true
    end,
  }))
end

function BufDel.other(opts)
  return BufDel.delete(vim.tbl_extend("force", {}, opts or {}, {
    filter = function(b)
      return b ~= vim.api.nvim_get_current_buf()
    end,
  }))
end

function BufDel.setup()
  return setmetatable(BufDel, {
    -- __call = function(t, ...)
    --   return t.delete(...)
    -- end,
    __call = BufDel.delete,
    __index = BufDel,
  })
  -- return BufDel
end

---@return utils.BufDel
return BufDel.setup()
