local M = {}

local utils = require("config.utils")

--- Placeholders for keeping track of most recent and previous buffer
M.current_buf, M.last_buf = nil, nil

--- Check if a buffer is valid
---@param bufnr number? The buffer to check, default to current buffer
---@return boolean # Whether the buffer is valid or not
function M.is_valid(bufnr)
  if not bufnr then
    bufnr = 0
  end
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

--- Close the current tab
function M.close_tab()
  if #vim.api.nvim_list_tabpages() > 1 then
    vim.t.bufs = nil
    utils.event("BufsUpdated")
    vim.cmd.tabclose()
  end
end

--- Close all buffers
---@param keep_current? boolean Whether or not to keep the current buffer (default: false)
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close_all(keep_current, force)
  if keep_current == nil then
    keep_current = false
  end
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.t.bufs) do
    if not keep_current or bufnr ~= current then
      M.close(bufnr, force)
    end
  end
end

--- A table of buffer comparator functions
M.comparator = {}

local fnamemodify = vim.fn.fnamemodify
local function bufinfo(bufnr)
  return vim.fn.getbufinfo(bufnr)[1]
end
local function unique_path(bufnr)
  return require("astronvim.utils.status.provider").unique_path()({ bufnr = bufnr })
      .. fnamemodify(bufinfo(bufnr).name, ":t")
end

--- Comparator of two buffer numbers
---@param bufnr_a integer buffer number A
---@param bufnr_b integer buffer number B
---@return boolean comparison true if A is sorted before B, false if B should be sorted before A
function M.comparator.bufnr(bufnr_a, bufnr_b)
  return bufnr_a < bufnr_b
end

--- Comparator of two buffer numbers based on the file extensions
---@param bufnr_a integer buffer number A
---@param bufnr_b integer buffer number B
---@return boolean comparison true if A is sorted before B, false if B should be sorted before A
function M.comparator.extension(bufnr_a, bufnr_b)
  return fnamemodify(bufinfo(bufnr_a).name, ":e") < fnamemodify(bufinfo(bufnr_b).name, ":e")
end

--- Comparator of two buffer numbers based on the full path
---@param bufnr_a integer buffer number A
---@param bufnr_b integer buffer number B
---@return boolean comparison true if A is sorted before B, false if B should be sorted before A
function M.comparator.full_path(bufnr_a, bufnr_b)
  return fnamemodify(bufinfo(bufnr_a).name, ":p") < fnamemodify(bufinfo(bufnr_b).name, ":p")
end

--- Comparator of two buffers based on their unique path
---@param bufnr_a integer buffer number A
---@param bufnr_b integer buffer number B
---@return boolean comparison true if A is sorted before B, false if B should be sorted before A
function M.comparator.unique_path(bufnr_a, bufnr_b)
  return unique_path(bufnr_a) < unique_path(bufnr_b)
end

--- Comparator of two buffers based on modification date
---@param bufnr_a integer buffer number A
---@param bufnr_b integer buffer number B
---@return boolean comparison true if A is sorted before B, false if B should be sorted before A
function M.comparator.modified(bufnr_a, bufnr_b)
  return bufinfo(bufnr_a).lastused > bufinfo(bufnr_b).lastused
end

return M
