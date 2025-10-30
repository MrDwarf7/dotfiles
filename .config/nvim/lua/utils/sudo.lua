--
---@class utils.Sudo
local Sudo = {
  debugging = false,
}

-- local debugging = false

---@class utils.Sudo.user_command.Opts: vim.api.keyset.create_user_command.command_args|nil
---@field args? utils.Sudo.register_user_commands._inline_create.Opts Options to pass to the `Sudo.sudo_write` function

---@class utils.Sudo.register_user_commands._inline_create.Opts
---@field name string The name of the command to create
---@field register_fn function The function to execute when the command is called
---@field inner_fn_opts table|nil Options to pass to the register function
---@field user_cmd_opts? vim.api.keyset.user_command Options to pass to the user
-- vim.api.keyset.create_user_command.command_args|nil Options to pass to the user

function Sudo.sudo_exec(opts)
  -- cmd, print_output
  opts = opts or {}
  opts.cmd = opts.cmd or ""
  opts.print_output = opts.print_output or false

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
      string.format("echo '%s' | sudo -p '' -S %s", password, opts.cmd) }):wait()
  end)
  if not ok or res.code ~= 0 then
    print("\r\n")
    require("utils.output").err(not ok and res or res.stderr) ---@diagnostic disable-line: trailing-space, param-type-mismatch
    return false
  end
  if opts.print_output then print("\r\n", res.stdout) end
  return true
  -- stylua: ignore end
end

function Sudo.sudo_write(opts)
  -- tmpfile, filepath
  opts = opts or {}
  opts.tmpfile = opts.tmpfile or nil
  opts.filepath = opts.filepath or nil

  -- stylua: ignore start
  if not opts.tmpfile then opts.tmpfile = vim.fn.tempname() end
  if not opts.filepath then opts.filepath = vim.fn.expand("%") end
  if not opts.filepath or #opts.filepath == 0 then
    require("utils.output").err("E32: No file name")
    return
  end
  -- `bs=1048576` is equiv. to `bs=1M` for GNU dd or `bs=1m` for BSD dd
  -- Both `bs=1M` and `bs=1m` are non-POXIS (lol.)
  local exec_opts = {
    cmd = string.format("dd if=%s of=%s bs=1048576",
      vim.fn.shellescape(opts.tmpfile),
      vim.fn.shellescape(opts.filepath)),
    print_output = false
  }

  -- no need to check err as this fails the entire op/func
  vim.api.nvim_exec2(string.format("write! %s", opts.tmpfile), { output = true })
  if Sudo.sudo_exec(exec_opts) then
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
  vim.fn.delete(opts.tmpfile)
  -- stylua: ignore end
end

-- BUG: something is registering them, but not the underlying function??
function Sudo.register_user_commands(opts)
  --- Inline function to create user commands
  ---
  --- The `args.user_cmd_opts.bang` parameter is inferred from the `args.name` parameter.
  --- That is, if it has a trailing '!', then it's true, else false.
  --- @param args utils.Sudo.register_user_commands._inline_create.Opts
  local create = function(args)
    --- Inline function to check for trailing '!' in command name
    ---@param name string
    ---@param bang_field boolean|nil
    ---@return string, boolean
    local bang_check = function(name, bang_field)
      local bang_res = false
      if Sudo.debugging then
        vim.print("name entred: " .. name)
      end

      -- 2 part operation

      -- first part:
      -- check if the name has a '!' in it
      -- if it does, update bang_res to true
      -- and then remove the '!' from the name

      if name:sub(-1) == "!" then
        bang_res = true
        name = name:sub(1, -2)
      end

      if Sudo.debugging then
        vim.print("initial bang_field: " .. tostring(bang_field))
        vim.print("initial bang_res: " .. tostring(bang_res))
        vim.print("final name: " .. name)
      end

      return name, bang_res
    end

    --- Validations START
    -- stylua: ignore start
    if not args then args = {} end
    -- if not args.name or string.len(args.name) == 0 then args.name = tostring(Sudo) .. "BROKEN" end
    -- if not args.register_fn then args.register_fn = function(x) return x end end -- returning the `x` here should basically do nothing
    if not args.inner_fn_opts then args.inner_fn_opts = {} end
    if not args.user_cmd_opts then args.user_cmd_opts = {} end
    -- stylua: ignore end

    -- check 'name' starts with an uppercase letter, if not
    -- uppercase the first letter.
    if string.len(args.name) > 0 and not args.name:match("^[A-Z]") then
      args.name = args.name:sub(1, 1):upper() .. args.name:sub(2)
    elseif string.len(args.name) == 0 then
      args.name = "BROKEN" .. tostring(Sudo)
    end

    --- Set a generic description based on the args.name
    --- if none is provided

    if not args.user_cmd_opts.desc then
      args.user_cmd_opts.desc = tostring(Sudo) .. " " .. "command: " .. args.name
    end

    local name, bang_res = bang_check(args.name, args.user_cmd_opts.bang)
    args.name = name
    args.user_cmd_opts.bang = bang_res

    if Sudo.debugging then
      vim.print("\nname: " .. args.name .. ", bang: " .. tostring(args.user_cmd_opts.bang) .. "\n\n")
    end

    --- Validations END

    ---@param ctx utils.Sudo.register_user_commands._inline_create.Opts
    local user_cmd_fn = function(ctx)
      if type(ctx.register_fn) ~= "function" then
        return
      end

      if type(ctx.inner_fn_opts) == "table" and vim.tbl_isempty(ctx.inner_fn_opts) then
        ctx.register_fn()
      elseif type(ctx.inner_fn_opts) == "table" then
        ctx.register_fn(ctx.inner_fn_opts)
      else
        require("utils.output").err(
          "Sudo.register_user_commands :: _create(args) must take a valid table as inner_fn_opts. Assuming `Sudo.sudo_write()`."
        )
        return Sudo.sudo_write()
      end
    end

    vim.api.nvim_create_user_command(args.name, user_cmd_fn, args.user_cmd_opts or {})
  end

  --- Validations/Defaults START
  opts = opts or {}
  opts.args = opts.args or {} -- maybe stupid not to set as nil ??

  if not opts.args.user_cmd_opts then
    opts.args.user_cmd_opts = {}
  end
  --- Validations/Defaults END

  local update = function(tbl, field, new_value)
    return setmetatable({
      [field] = new_value,
    }, {
      __index = tbl,
      __metatable = {},
    })
  end

  local base = vim.tbl_deep_extend("force", {}, opts.args or {}, {
    name = "W",
    register_fn = Sudo.sudo_write,
    user_cmd_opts = {
      -- bang = false,
      desc = "Write the current buffer with sudo permissions",
    },
  })

  local write = base
  local write_force = update(write, "name", "W!")

  local sudo = update(write, "name", "SudoWrite")
  local sudo_force = update(write_force, "name", "SudoWrite!")

  local tables_list = {
    write,
    write_force,
    sudo,
    sudo_force,
  }

  -- TODO: Move the user command registration to `utils.user_commands`
  -- bit of spaghetti code here though tbh

  --  -- local uc = require("utils.user_commands")
  --  -- uc.setup({
  --  --   commands = tables_list,
  --  -- })

  --  -- uc.batch_register({
  --  --   commands = tables_list,
  --  -- })

  for _, v in ipairs(tables_list) do
    create(v)
  end

  -- create(write)
  -- create(write_force)
  -- create(sudo)
  -- create(sudo_force)

  if Sudo.debugging then
    vim.print("write_values: " .. vim.inspect(write) .. "\n\n")
    vim.print("write_force_values: " .. vim.inspect(write_force) .. "\n\n")

    vim.print("sudo_values: " .. vim.inspect(sudo) .. "\n\n")
    vim.print("sudo_force_values: " .. vim.inspect(sudo_force) .. "\n\n")
  end
end

function Sudo.setup()
  Sudo.register_user_commands()
  -- return setmetatable(Sudo, {
  --   __tostring = function()
  --     return "utils.Sudo"
  --   end,
  -- })
  return Sudo
end

---@return utils.Sudo
return Sudo.setup()
