--
---@class utils.Sudo
local Sudo = {}

--- Execute a command with sudo, prompting for password if necessary
---@param cmd string The command to execute with sudo
---@param print_output boolean? Whether to print the output of the command, defaults to false
function Sudo.sudo_exec(cmd, print_output)
	-- stylua: ignore start
	vim.fn.inputsave()
	local password = vim.fn.inputsecret("Password: ")
	vim.fn.inputrestore()
	if not password or #password == 0 then
		require("utils.output").warn("Invalid password, sudo aborted.")
		return false
	end
	local ok, res = pcall(function()
		return vim.system({ "sh", "-c",
		string.format("echo '%s' | sudo -p '' -S %s", password, cmd) }):wait()
	end)
	if not ok or res.code ~= 0 then
		print("\r\n")
		require("utils.output").err(not ok and res or res.stderr) ---@diagnostic disable-line: trailing-space, param-type-mismatch
		return false
	end
	if print_output then print("\r\n", res.stdout) end
	return true
  -- stylua: ignore end
end

--- Save the current buffer with sudo, using a temporary file
function Sudo.sudo_write(tmpfile, filepath)
	-- stylua: ignore start
	if not tmpfile then tmpfile = vim.fn.tempname() end
	if not filepath then filepath = vim.fn.expand("%") end
	if not filepath or #filepath == 0 then
		require("utils.output").err("E32: No file name")
		return
	end
	-- `bs=1048576` is equiv. to `bs=1M` for GNU dd or `bs=1m` for BSD dd
	-- Both `bs=1M` and `bs=1m` are non-POXIS (lol.)
	local cmd = string.format("dd if=%s of=%s bs=1048576",
		vim.fn.shellescape(tmpfile),
		vim.fn.shellescape(filepath))

	-- no need to check err as this fails the entire op/func
	vim.api.nvim_exec2(string.format("write! %s", tmpfile), { output = true })
	if Sudo.sudo_exec(cmd) then

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


---@return utils.Sudo
return Sudo
