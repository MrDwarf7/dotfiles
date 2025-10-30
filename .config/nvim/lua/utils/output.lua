--
-- local dbg_fn = function(...)
if type(_G.dump) ~= "function" then
  --- Dump the given objects to stdout, using vim.inspect
  ---@param ... any
  ---@return nil
  ---@diagnostic disable-next-line: unused-function, duplicate-set-field
  function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
  end
end
-- end

-- dbg_fn()

--------------------
-- TODO: @split -- would do well to split this out
--  keeping only the output stuff here, and splitting others
--------------------

---@class utils.Output
local Output = {
  debugging = false,
}

Output.__HAS_NVIM_011 = vim.fn.has("nvim-0.11") == 1
-- Output.__IS_WIN = require("utils.arch").__IS_WIN
-- vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
-- Output.__USE_SNACKS = Output.__IS_WIN

--- Short function to get the user's documents directory.
--- Handles both Windows and Unix-like systems.
---
local function doc()
  local win_doc, unix_doc
  if require("utils.arch").get_os() == "Windows_NT" then
    win_doc = "$HOME/Documents"
  end

  local maybe_doc = "$HOME/Documents"
  if vim.fn.isdirectory(maybe_doc) == 1 then
    unix_doc = maybe_doc
  end

  maybe_doc = "$HOME/documents"
  if vim.fn.isdirectory(maybe_doc) == 1 then
    unix_doc = maybe_doc
  end

  if require("utils.arch").__IS_WIN then
    return win_doc
  end
  return unix_doc
end

--- The name of the dev environment directory
local DEV_DIR_NAME = "nvim_dev"

--- The dev environment directory, handles Windows, and corrects for [Dd]ocuments
local DEV_DIR = "$HOME/" .. string.format("%s/%s", doc() or "Documents", DEV_DIR_NAME)

--- Function to notify messages, aware of fast events
---@param msg MsgData|string The message to notify
---@param level number The log level (e.g., vim.log.levels.INFO)
---@param opts table? Additional options for the notification
local function fast_event_aware_notify(msg, level, opts) --[[@cast msg string]]
  -- force cast to shut linter up
  if vim.in_fast_event() then
    vim.schedule(function()
      vim.notify(msg, level, opts)
    end)
  else
    vim.notify(msg, level, opts)
  end
end

function Output.info(msg)
  -- fast_event_aware_notify(msg, vim.log.levels.INFO, { title = "Info" })
  fast_event_aware_notify(msg, vim.log.levels.INFO, {})
end

function Output.warn(msg)
  -- fast_event_aware_notify(msg, vim.log.levels.WARN, { title = "Warning" })
  fast_event_aware_notify(msg, vim.log.levels.WARN, {})
end

function Output.err(msg)
  -- fast_event_aware_notify(msg, vim.log.levels.ERROR, { title = "Error" })
  fast_event_aware_notify(msg, vim.log.levels.ERROR, {})
end

function Output.is_root()
  return not require("utils.arch").__IS_WIN and vim.uv.getuid() == 0
end

function Output.get_dev_dir()
  if vim.uv.fs_stat(DEV_DIR) then
    return vim.fn.expand(DEV_DIR)
  end
  return string.format("%s", vim.fn.expand(DEV_DIR))
end

function Output.is_dev(path)
  return vim.uv.fs_stat(string.format("%s/%s", Output.get_dev_dir(), path)) ~= nil
end

function Output.have_compiler()
  if
    vim.fn.executable("cc") == 1
    or vim.fn.executable("gcc") == 1
    or vim.fn.executable("clang") == 1
    or vim.fn.executable("cl") == 1
    or vim.fn.executable("zig") == 1
  then
    return true
  end
  return false
end

function Output.cargo_has_nightly()
  local ok, res = pcall(function()
    return vim.system({ "cargo", "+nightly" }):wait()
  end)
  return ok and res.code == 0
end

function Output.git_root(cwd, noerr)
  local cmd = { "git", "rev-parse", "--show-toplevel" }
  if cwd then
    table.insert(cmd, 2, "-C")
    table.insert(cmd, 3, vim.fn.expand(cwd))
  end

  local ok, res = pcall(function()
    return vim.system(cmd):wait()
  end)
  if not ok or not res then
    if not noerr then
      Output.info(res)
    end
    return nil
  end
  return res.stdout:gsub("\n$", "")
end

-- TODO: Can be used for eg: fzf-lua stuff
function Output.set_cwd(pwd)
  if not pwd then
    local parent = vim.fn.expand("%:h")
    -- pwd = Output.git_root(parent, true) or parent
    local lsp_util = require("lspconfig.util")
    pwd = lsp_util.root_pattern({
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      ".git",
    })(parent) or parent
  end

  if pwd and vim.uv.fs_stat(pwd) then
    vim.cmd("cd " .. pwd)
    Output.info(("pwd set to %s"):format(vim.fn.shellescape(pwd)))
  else
    Output.warn(("Unable to set pwd to %s, directory not accessible"):format(vim.fn.shellescape(pwd)))
  end
end

--- This will exit visual mode,
--- Use 'gv' to reselect the text
function Output.get_visual_selection(nl_literal)
  -- Otherwise the function doubles in size lmao
  -- stylua: ignore start
  local _, csrow, cscol, cerow, cecol

  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "" then
    -- If we're in visual mode, use the live pos
    _, csrow, cscol, _ = unpack(vim.fn.getpos("."))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("v"))

    if mode == "V" then
      -- visual line doesn't provide column(s)/info
      cscol, cecol = 0, 999
    end
  else
    -- otherwis, use the last known visual pos
    _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  end

  -- swap vars if needed
  if cerow < csrow then csrow, cerow = cerow, csrow end
  if cecol < cscol then cscol, cecol = cecol, cscol end

  local lines = vim.fn.getline(csrow, cerow)
  -- local n = cerow-csrow+1
  local n = #lines
  if n <= 0 then return "" end
  lines[n] = string.sub(lines[n], 1, cecol)
  lines[1] = string.sub(lines[1], cscol)
  -- Not sure if we need, or should be doing this tbh.... but it prevents the type checker from complaining
  if type(lines) == "string" then
    lines = { lines }
  end
  return table.concat(lines, nl_literal and "\\n" or "\n")
  -- stylua: ignore end
end

--- Copy a string to the clipboard using OSC 52 (OSC 25)
--- Outputs the number of characters copied and the number of bytes sent
---@param ... string The string to copy to the clipboard
function Output.osc25printf(...)
  local str = string.format(...)
  local base64 = vim.base64.encode(str)
  local osc25str = string.format("\x1b]52;c;%s\x07", base64)
  local bytes = vim.fn.chansend(vim.v.stderr, osc25str)
  assert(bytes > 0)
  Output.info(string.format("[OSC25] %d chars copies (%d bytes)", #str, bytes))
end

function Output.unload_modules(patterns)
  for _, p in ipairs(patterns) do
    if not p.mod and type(p[1]) == "string" then
      p = { mod = p[1], fn = p.fn }
    end
    local unloaded = false
    for m, _ in pairs(package.loaded) do
      if m:match(p.mod) then
        unloaded = true
        package.loaded[m] = nil
        Output.info(string.format("UNLOADED module '%s'", m))
      end
    end
    if unloaded and p.fn then
      p.fn()
      Output.warn(string.format("RELOADED module '%s'", p.mod))
    end
  end
end

Output.reload_config = function()
  -- stylua: ignore start
  require("fzf-lua").deregister_ui_select()
  Output.unload_modules({
    {
      "^config\\.options$",
      fn = function()
        -- ignore events or gitsigns croacks on "OptionSet"
        -- OptionSet autocmds for "fileformat" : attempt to yield across C-call
        local save_ei = vim.o.eventignore
        vim.o.eventignore = "all"
        require("config.options")
        vim.o.eventignore = save_ei
      end
    },
    { "^config\\.autocmds$",         fn = function() require("config.autocmds") end },
    { "^config\\.keymaps$",          fn = function() require("config.keymaps") end },
    -- { "^config\\.user_commands$",    fn = function() require("config.user_commands") end },
    { "^utils\\.arch$" },
    { "^utils\\.autoformatter$" },
    { "^utils\\.filepath_converter$" },
    { "^utils\\.folding$" },
    { "^utils\\.lsp_servers$" },
    { "^utils\\.types$" },
    -- {
    -- 	mod = "snacks",
    -- 	fn = function()
    -- 		require("plugins.snacks").init()
    -- 		require("plugins.snacks").config()
    -- 	end
    -- },
  })

  -- resource all language specific settings, scans all runtime files under
  -- '/usr/share/nvim/runtime/(indent|syntax)' and 'after/ftplugin'

  local ft = vim.bo.filetype
  vim.tbl_filter(function(s)
    for _, e in ipairs({ "vim", "lua" }) do
      if ft and #ft > 0 and vim.fs.normalize(s):match(("/%s.%s"):format(ft, e)) then
        local file = vim.fn.expand(s:match("[^: ]*$"))
        vim.cmd.source(file)
        Output.warn("RESOURCED " .. vim.fn.fnamemodify(file, ":."))
        return s
      end
    end
    return false
  end, vim.fn.split(vim.fn.execute("scriptnames"), "\n"))
  -- remove last search hl
  vim.cmd("nohl")
  -- stylua: ignore end
end

function Output.win_is_float(winnr)
  local wincfg = vim.api.nvim_win_get_config(winnr)
  if wincfg and (wincfg.external or wincfg.relative and #wincfg.relative > 0) then
    return true
  end
  return false
end

--------------------

--------------------

function Output.input(prompt)
  local ok, res
  if vim.ui then
    ok, _ = pcall(vim.ui.input, { prompt = prompt }, function(input)
      res = input
    end)
  else
    ok, res = pcall(vim.fn.input, { prompt = prompt, cancelreturn = 3 })
    if res == 3 then
      ok, res = false, nil
    end
  end
  return ok and res or nil
end

function Output.lsp_get_clients(opts)
  -- stylua: ignore start
  if Output.__HAS_NVIM_011 then
    return vim.lsp.get_clients(opts)
  end
  local clients = opts.bufnr and vim.lsp.get_clients(opts.bufnr) ---@diagnostic disable-line: deprecated
      or opts.id and { vim.lsp.get_client_by_id(opts.id) }
      or vim.lsp.get_clients(opts)
  return vim.tbl_map(function(client)
    return setmetatable({
      supports_method = function(_, ...) return client:supports_method(...) end,
      request = function(_, ...) return client.request(...) end,
      request_sync = function(_, ...) return client.request_sync(...) end,
    }, { __index = client })
  end, clients)
  -- stylua: ignore end
end

--- Uses a global/file-level debug flag to print debug messages
--- If the flag is false/nil it
--- does nothing and returns immediately.
---
--- If the flag is true, prints the section,
--- message, and data (if any) to stdout.
---
---
---@param primary_section? string
---@param section string
---@param msg string
---@param data? table|any|nil
---@return void
-- ---@param ...? boolean|table Optional debug flag or table containing debug flag
function Output.d(primary_section, section, msg, data)
  print("output module: " .. type(primary_section))
  if type(primary_section) ~= "string" or type(primary_section) == "nil" then
    return
  end

  primary_section = primary_section or "Output_Generic"

  if data == nil then
    data = {}
  end

  if type(data) ~= "table" then
    data = { data }
  end

  if type(section) ~= "string" then
    section = tostring(section)
  end

  if type(msg) ~= "string" then
    msg = tostring(msg)
  end

  local print_data = tostring(
    string.format("%s", primary_section)
      .. " :: "
      .. string.format("%s", section)
      .. " :: "
      .. string.format("%s", msg)
      .. " :: : "
      .. vim.print(vim.inspect(data))
  )
  _G.dump(print_data)
end

function Output.setup()
  return Output
end

---@return utils.Output
return Output.setup()
