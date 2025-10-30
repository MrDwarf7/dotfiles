--
---@class utils.List
local List = {}

--- Pass "q" to find quickfix window
--- Pass "l" to find all loclist windows
---@param type QfTypes
---@return WinTable[]?
function List.find_qf(type)
  local wininfo = vim.fn.getwininfo()

  ---@type WinTable[]
  local win_tbl = {}

  -- direct indexing into a variable makes life fun. Trust me bro

  for _, win in pairs(wininfo) do
    local found = false
    if type == "l" and win["loclist"] == 1 then
      found = true
    end

    -- loclist window has 'quickfix' set, eliminate those
    if type == "q" and win["quickfix"] == 1 and win["loclist"] == 0 then
      found = true
    end
    if found then
      table.insert(win_tbl, { winid = win["winid"], bufnr = win["bufnr"] })
    end
  end
  return win_tbl
end

--- Open quickfix if not empty
function List.open_qf()
  -- stylua: ignore start
  local qf_name = "quickfix"
  local qf_empty = function() return vim.tbl_isempty(vim.fn.getqflist()) end

  if not qf_empty() then
    vim.cmd("copen")
    vim.cmd("wincmd J")
  else
    print(string.format("%s is empty.", qf_name))
  end
  -- stylua: ignore end
end

function List.open_loclist_all()
  -- stylua: ignore start
  local wininfo = vim.fn.getwininfo()
  local qf_name = "loclist"
  local qf_empty = function(winnr) return vim.tbl_isempty(vim.fn.getloclist(winnr)) end
  for _, win in pairs(wininfo) do
    if win["quickfix"] == 0 then
      if not qf_empty(win["winnr"]) then
        -- switch active window before ':lopen'
        vim.api.nvim_set_current_win(win["winid"])
        vim.cmd("lopen")
      else
        print(string.format("%s is empty.", qf_name))
      end
    end
  end
  -- stylua: ignore end
end

--- Toggle's quickfix/loclist on/off
--- Pass "q" to find quickfix window
--- Pass "l" to find all loclist windows
---@param type QfTypes
function List.toggle_qf(type)
  local windows = List.find_qf(type)
  if #windows > 0 then
    -- hide all visible windows
    for _, win in ipairs(windows) do
      vim.api.nvim_win_hide(win.winid)
    end
  else
    -- no windows are vis, attempt to open
    if type == "l" then
      List.open_loclist_all()
    else
      List.open_qf()
    end
  end
end

function List.setup()
  return List
end

---@return utils.List
return List.setup()
