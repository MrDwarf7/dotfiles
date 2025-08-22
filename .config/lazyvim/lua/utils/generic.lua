--- If it's not already defined (ie: by snacks or elsewhere, define a dump function)
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

---
---@class MsgData: unknown|vim.SystemCompleted
---

---@class utils.Generic
local M = {}

M.__HAS_NVIM_011 = vim.fn.has("nvim-0.11") == 1
M.__IS_WIN = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
M.__USE_SNACKS = M.__IS_WIN

--- Short function to get the user's documents directory.
--- Handles both Windows and Unix-like systems.
---
local doc = function()
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

  if M.__IS_WIN then
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
local fast_event_aware_notify = function(msg, level, opts) --[[@cast msg string]] -- force cast to shut linter up
  if vim.in_fast_event() then
    vim.schedule(function()
      vim.notify(msg, level, opts)
    end)
  else
    vim.notify(msg, level, opts)
  end
end

function M.info(msg)
  -- fast_event_aware_notify(msg, vim.log.levels.INFO, { title = "Info" })
  fast_event_aware_notify(msg, vim.log.levels.INFO, {})
end

function M.warn(msg)
  -- fast_event_aware_notify(msg, vim.log.levels.WARN, { title = "Warning" })
  fast_event_aware_notify(msg, vim.log.levels.WARN, {})
end

function M.err(msg)
  -- fast_event_aware_notify(msg, vim.log.levels.ERROR, { title = "Error" })
  fast_event_aware_notify(msg, vim.log.levels.ERROR, {})
end

function M.is_root()
  return not M.__IS_WIN and vim.uv.getuid() == 0
end

function M.is_darwin()
  return vim.uv.os_uname().sysname == "Darwin"
end

function M.is_NetBSD()
  return vim.uv.os_uname().sysname == "NetBSD"
end

function M.is_iSH()
  return vim.uv.os_uname().release:match("%-ish$") ~= nil
end

function M.get_dev_dir()
  if vim.uv.fs_stat(DEV_DIR) then
    return vim.fn.expand(DEV_DIR)
  end
  return string.format("%s", vim.fn.expand(DEV_DIR))
end

function M.is_dev(path)
  return vim.uv.fs_stat(string.format("%s/%s", M.get_dev_dir(), path)) ~= nil
end

function M.have_compiler()
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

function M.cargo_has_nightly()
  local ok, res = pcall(function()
    return vim.system({ "cargo", "+nightly" }):wait()
  end)
  return ok and res.code == 0
end

function M.git_root(cwd, noerr)
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
      M.info(res)
    end
    return nil
  end
  return res.stdout:gsub("\n$", "")
end

function M.set_cwd(pwd)
  if not pwd then
    local parent = vim.fn.expand("%:h")
    -- pwd = M.git_root(parent, true) or parent
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
    M.info(("pwd set to %s"):format(vim.fn.shellescape(pwd)))
  else
    M.warn(("Unable to set pwd to %s, directory not accessible"):format(vim.fn.shellescape(pwd)))
  end
end

--- This will exit visual mode,
--- Use 'gv' to reselect the text
function M.get_visual_selection(nl_literal)
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

--- Pass "q" to find quickfix window
--- Pass "l" to find all loclist windows
---@param type QfTypes
function M.find_qf(type)
  local wininfo = vim.fn.getwininfo()
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
function M.open_qf()
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

function M.open_loclist_all()
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
---@param type QfTypes
function M.toggle_qf(type)
  local windows = M.find_qf(type)
  if #windows > 0 then
    -- hide all visible windows
    for _, win in ipairs(windows) do
      vim.api.nvim_win_hide(win.winid)
    end
  else
    -- no windows are vis, attempt to open
    if type == "l" then
      M.open_loclist_all()
    else
      M.open_qf()
    end
  end
end

--- Expand or minimize current buffer in a more natural direction (tmux-like)
--- ':resize <+-n>' or ':vert resize <+-n>' increases or decreases current
--- window horizontally or vertically.
--- When mapped to '<Leader><arrow>' this can get confusing as left might actually be right etc.
--- The below can be mapped to arrows and will work similar to the tmux binds
--- map to: "<cmd>lua require('utils.generic').resize(false, -5)<CR>" etc.
M.resize = function(vertical, margin)
  local cur_win = vim.api.nvim_get_current_win()
  -- go (possibly) right
  vim.cmd(string.format("wincmd %s", vertical and "l" or "j"))
  local new_win = vim.api.nvim_get_current_win()

  -- determine direction cond on increase and existing right-hand buf
  local not_last = not (cur_win == new_win)
  local sign = margin > 0
  -- go to prev window if required, otherwise flip sign
  if not_last == true then
    vim.cmd([[wincmd p]])
  else
    sign = not sign
  end

  local sign_str = sign and "+" or "-"
  local dir = vertical and "vertical " or "" -- NOTE THE SPACE!
  local cmd = dir .. "resize " .. sign_str .. math.abs(margin) .. "<CR>" -- NOTE THE SPACE HERE TOO!
  vim.cmd(cmd)
end

-- M.sudo_exec = function(cmd, print_output)
-- 	vim.fn.inputsave()
-- 	local password = vim.fn.inputsecret("Password: ")
-- 	vim.fn.inputrestore()
-- 	if not password or #password == 0 then
-- 		M.warn("Invalid password, sudo aborted.")
-- 		return false
-- 	end
-- 	local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
-- 	if vim.v.shell_error ~= 0 then
-- 		print("\r\n")
-- 		M.err(out)
-- 		return false
-- 	end
-- 	if print_output then print("\r\n", out) end
-- 	return true
-- end

--- Execute a command with sudo, prompting for password if necessary
---@param cmd string The command to execute with sudo
---@param print_output boolean? Whether to print the output of the command, defaults to false
M.sudo_exec = function(cmd, print_output)
	-- stylua: ignore start
	vim.fn.inputsave()
	local password = vim.fn.inputsecret("Password: ")
	vim.fn.inputrestore()
	if not password or #password == 0 then
		M.warn("Invalid password, sudo aborted.")
		return false
	end
	local ok, res = pcall(function()
		return vim.system({ "sh", "-c",
		string.format("echo '%s' | sudo -p '' -S %s", password, cmd) }):wait()
	end)
	if not ok or res.code ~= 0 then
		print("\r\n")
		M.err(not ok and res or res.stderr) ---@diagnostic disable-line: trailing-space, param-type-mismatch
		return false
	end
	if print_output then print("\r\n", res.stdout) end
	return true
  -- stylua: ignore end
end

--- Save the current buffer with sudo, using a temporary file
M.sudo_write = function(tmpfile, filepath)
	-- stylua: ignore start
	if not tmpfile then tmpfile = vim.fn.tempname() end
	if not filepath then filepath = vim.fn.expand("%") end
	if not filepath or #filepath == 0 then
		M.err("E32: No file name")
		return
	end
	-- `bs=1048576` is equiv. to `bs=1M` for GNU dd or `bs=1m` for BSD dd
	-- Both `bs=1M` and `bs=1m` are non-POXIS (lol.)
	local cmd = string.format("dd if=%s of=%s bs=1048576",
		vim.fn.shellescape(tmpfile),
		vim.fn.shellescape(filepath))

	-- no need to check err as this fails the entire op/func
	vim.api.nvim_exec2(string.format("write! %s", tmpfile), { output = true })
	if M.sudo_exec(cmd) then

		-- Using checktime will cause 2 things -
		-- 1. You will get a message (annoying af)
		-- 2. Because you're still in non-sudo editing, you'll have to ':qa!' to close and abandon changes.
		-- refresh the buffer and prints the "written" message.
		-- vim.cmd.checktime()

		-- Prefer edit lol
		vim.cmd("edit!")

		-- exit command mode
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(
			"<Esc>", true, false, true), "n", true)
	end
	vim.fn.delete(tmpfile)
  -- stylua: ignore end
end

--- Copy a string to the clipboard using OSC 52 (OSC 25)
--- Outputs the number of characters copied and the number of bytes sent
---@param ... string The string to copy to the clipboard
M.osc25printf = function(...)
  local str = string.format(...)
  local base64 = vim.base64.encode(str)
  local osc25str = string.format("\x1b]52;c;%s\x07", base64)
  local bytes = vim.fn.chansend(vim.v.stderr, osc25str)
  assert(bytes > 0)
  M.info(string.format("[OSC25] %d chars copies (%d bytes)", #str, bytes))
end

M.unload_modules = function(patterns)
  for _, p in ipairs(patterns) do
    if not p.mod and type(p[1]) == "string" then
      p = { mod = p[1], fn = p.fn }
    end
    local unloaded = false
    for m, _ in pairs(package.loaded) do
      if m:match(p.mod) then
        unloaded = true
        package.loaded[m] = nil
        M.info(string.format("UNLOADED module '%s'", m))
      end
    end
    if unloaded and p.fn then
      p.fn()
      M.warn(string.format("RELOADED module '%s'", p.mod))
    end
  end
end

M.reload_config = function()
  -- stylua: ignore start
	require("fzf-lua").deregister_ui_select()
	M.unload_modules({
		{ "^config\\.options$",
			fn = function()
				-- ignore events or gitsigns croacks on "OptionSet"
				-- OptionSet autocmds for "fileformat" : attempt to yield across C-call
				local save_ei = vim.o.eventignore
				vim.o.eventignore = "all"
				require("config.options")
				vim.o.eventignore = save_ei
			end
		},
		{ "^config\\.autocmds$",								fn = function() require("config.autocmds") end },
		{ "^config\\.keymaps$",									fn = function() require("config.keymaps") end },
		{ "^config\\.user_commands$",						fn = function() require("config.user_commands") end },
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
				M.warn("RESOURCED " .. vim.fn.fnamemodify(file, ":."))
				return s
			end
		end
		return false
	end, vim.fn.split(vim.fn.execute("scriptnames"), "\n"))
	-- remove last search hl
	vim.cmd("nohl")
  -- stylua: ignore end
end

M.win_is_float = function(winnr)
  local wincfg = vim.api.nvim_win_get_config(winnr)
  if wincfg and (wincfg.external or wincfg.relative and #wincfg.relative > 0) then
    return true
  end
  return false
end

--------------------

--------------------

function M.input(prompt)
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

function M.lsp_get_clients(opts)
	-- stylua: ignore start
	if M.__HAS_NVIM_011 then
		return vim.lsp.get_clients(opts)
	end
	local clients = opts.bufnr and vim.lsp.buf_get_clients(opts.bufnr) ---@diagnostic disable-line: deprecated
		or opts.id and { vim.lsp.get_client_by_id(opts.id) }
		or vim.lsp.get_clients(opts)
	return vim.tbl_map(function(client)
		return setmetatable({
			supports_method =	function(_, ...)		return client.supports_method(...)	end,
			request =					function(_, ...)		return client.request(...)					end,
			request_sync =		function(_, ...)		return client.request_sync(...)			end,
		}, { __index = client })
	end, clients)
  -- stylua: ignore end
end

---@return utils.Generic
return M
