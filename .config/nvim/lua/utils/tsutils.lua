---
---@class utils.TsUtils
local TsUtils = {}

-- we want to do a couple of things here:
-- 1. Add the original position to both the:
--  a) tag stack (so <C-t> always takes us back to our starting file (in our own code))
--  b) add the place we jumped FROM to the FIRST entry in the quickfix or loclist, whichever is opened during the op
--
-- 2. Ignore things that start with a comment string syntax
-- for whatever the language is. THIS MUST BE LANGUAGE AWARE VIA THE LSP SERVER!!!!!!!!!!!!!!
--
-- 3. Automatically jump if there's only a single item in the list

---@param opts config.LSP.handle_builtins.Opts
function TsUtils.handle_builtins(opts)
  opts = opts or {}

  local lists = require("utils.list")

  local function is_in_comment(item)
    local filename = item.filename
    local item_bufnr = vim.fn.bufadd(filename)
    vim.fn.bufload(item_bufnr)
    if vim.bo[item_bufnr].filetype == "" then
      vim.bo[item_bufnr].filetype = vim.bo.filetype
    end
    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if not ok then
      return false
    end
    local lang = parsers.ft_to_lang(vim.bo[item_bufnr].filetype)
    local parser = parsers.get_parser(item_bufnr, lang)
    if not parser then
      return false
    end
    local tree = parser:parse()[1]
    if not tree then
      return false
    end
    local node = tree:root():descendant_for_range(item.lnum - 1, item.col - 1, item.lnum - 1, item.col - 1)
    if not node then
      return false
    end
    local cur = node
    while cur do
      if cur:type():match("^[cC]omment") then
        return true
      end
      cur = cur:parent()
    end
    return false
  end

  if opts.method then
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients == 0 then
      require("utils.output").info("No LSP client found")
      return
    end
    local offset_encoding = clients[1].offset_encoding or "utf-16"
    local params = vim.lsp.util.make_position_params(0, offset_encoding)
    vim.lsp.buf_request_all(0, opts.method, params, function(responses)
      local all_results = {}
      local all_errs = {}
      for _, resp in pairs(responses) do
        if resp.err then
          table.insert(all_errs, resp.err)
        end
        if resp.result then
          local result = resp.result
          if not vim.islist(result) then
            result = { result }
          end
          vim.list_extend(all_results, result)
        end
      end
      if #all_results == 0 then
        if #all_errs > 0 then
          require("utils.output").warn(vim.inspect(all_errs))
        else
          require("utils.output").info("No results found")
        end
        return
      end
      local items = vim.lsp.util.locations_to_items(all_results, offset_encoding)
      local filtered = {}
      for _, item in ipairs(items) do
        if not is_in_comment(item) then
          table.insert(filtered, item)
        end
      end
      if #filtered == 0 then
        require("utils.output").info("No non-comment results found")
        return
      end
      local orig_pos = {
        filename = vim.api.nvim_buf_get_name(bufnr),
        lnum = vim.fn.line("."),
        col = vim.fn.col("."),
        text = "Original position",
      }
      local function add_to_tagstack()
        local from = { bufnr, orig_pos.lnum, orig_pos.col, 0 }
        local tag_item = { tagname = opts.method, from = from }
        vim.fn.settagstack(vim.fn.winnr(), { items = { tag_item } }, "a")
      end
      local is_references = opts.method == "textDocument/references"
      local use_loclist = not is_references
      local setlist_fn = use_loclist and vim.fn.setloclist or vim.fn.setqflist
      local open_cmd = use_loclist and "lopen" or "copen"
      local title = opts.method:gsub("textDocument/", "")
      if #filtered == 1 then
        add_to_tagstack()
        vim.lsp.util.jump_to_location(filtered[1], offset_encoding, true)
      else
        table.insert(filtered, 1, orig_pos)
        setlist_fn(0, {}, " ", { title = title, items = filtered })
        add_to_tagstack()
        vim.cmd(open_cmd)
      end
    end)
  else
    local maybe_qf = lists.find_qf("q") or {}
    local maybe_loc = lists.find_qf("l") or {}
    local ok, ret = pcall(opts.operation)
    if not ok then
      -- require("utils.output").warn(ret)
      return
    end
    local qf_after = lists.find_qf("q") or {}
    local loc_after = lists.find_qf("l") or {}
    if #qf_after == 1 and #maybe_qf == 0 then
      vim.cmd("cfirst")
    elseif #loc_after == 1 and #maybe_loc == 0 then
      vim.cmd("lfirst")
    end
  end
end

function TsUtils.setup()
  return TsUtils
end

return TsUtils

-- opts = opts or {}
-- local list = require("utils.list")
--
-- local function is_in_comment(item)
--   local filename = item.filename
--   local item_bufnr = vim.fn.bufadd(filename)
--
--   vim.fn.bufload(item_bufnr)
--   if vim.bo[item_bufnr].filetype == "" then
--     vim.bo[item_bufnr].filetype = vim.bo.filetype
--   end
--   local ok, parsers = pcall(require, "nvim-treesitter.parsers")
--   if not ok then
--     return false
--   end
--
--   local lang = parsers.ft_to_lang(vim.bo[item_bufnr].filetype)
--   local parser = parsers.get_parser(item_bufnr, lang)
--   if not parser then
--     return false
--   end
--   local tree = parser:parse()[1]
--   if not tree then
--     return false
--   end
--   local node = tree:root().descendant_for_range(item.lnum - 1, item.col - 1, item.lnum - 1, item.col - 1)
--   if not node then
--     return false
--   end
--
--   local cur = node
--   while cur do
--     if cur:type():match("^[cC]omment") then
--       return true
--     end
--     cur = cur:parent()
--   end
--   return false
-- end
--
-- if opts.method then
--   local bufnr = vim.api.nvim_get_current_buf()
--   local clients = vim.lsp.get_clients({ bufnr = bufnr })
--   if #clients == 0 then
--     return
--   end
--   local client = clients[1]
--   local params = vim.lsp.util.make_position_params()
--   local function custom_handler(err, result, ctx)
--     if err then
--       require("utils.output").err(err)
--       return
--     end
--
--     if not result then
--       return
--     end
--     if not vim.islist(result) then
--       result = { result }
--     end
--     if #result == 0 then
--       require("utils.output").info("No results found")
--       return
--     end
--
--     local encoding = client.offset_encoding or "utf-16"
--     local items = vim.lsp.util.locations_to_items(result, encoding)
--     local filtered = {}
--     for _, item in ipairs(items) do
--       if not is_in_comment(item) then
--         table.insert(filtered, item)
--       end
--     end
--     if #filtered == 0 then
--       require("utils.output").info("No non-comment results found")
--       return
--     end
--     local orig_pos = {
--       filename = vim.api.nvim_buf_get_name(bufnr),
--       lnum = vim.fn.line("."),
--       col = vim.fn.col("."),
--       text = "Original Position",
--     }
--     local function add_to_tagstack()
--       local from = { bufnr, orig_pos.lnum, orig_pos.col, 0 }
--       local tag_item = { tagname = opts.method, from = from }
--       vim.fn.settagstack(vim.fn.winnr(), { items = { tag_item } }, "a")
--     end
--
--     local is_reference = opts.method == "textDocument/references"
--     local use_loclist = not is_reference
--     local setlist_fn = use_loclist and vim.fn.setloclist or vim.fn.setqflist
--     local open_cmd = use_loclist and "lopen" or "copen"
--     local title = opts.method:gsub("textDocument/", "")
--     if #filtered == 1 then
--       add_to_tagstack()
--       vim.lsp.util.jump_to_location(filtered[1], encoding, true)
--     else
--       table.insert(filtered, 1, orig_pos)
--       setlist_fn(0, {}, " ", { title = title, items = filtered, context = ctx })
--       add_to_tagstack()
--       vim.cmd(open_cmd)
--     end
--   end
--
--   client.request(opts.method, params, custom_handler, bufnr)
-- else
--   local maybe_qf = list.find_qf("q") or {}
--   local maybe_loc = list.find_qf("l") or {}
--   local ok, ret = pcall(opts.operation)
--   if not ok then
--     require("utils.output").warn(ret)
--     return
--   end
--   local qf_after = list.find_qf("q") or {}
--   local loc_after = list.find_qf("l") or {}
--   if #qf_after == 1 and #maybe_qf == 0 then
--     vim.cmd("cfirst")
--   elseif #loc_after == 1 and #maybe_loc == 0 then
--     vim.cmd("lfirst")
--   end
-- end
