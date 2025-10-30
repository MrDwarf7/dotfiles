--- Needed to create user commands for
--- both stripped and non-stripped filepaths

local Converter = require("utils.converter")

---@class utils.UserCommands: utils.Base
local UserCommands = {
  debugging = false,
}

---@class utils.UserCommands.setup.Opts
---@field commands utils.Sudo.register_user_commands._inline_create.Opts
---
---

--....
-- ---@field commands table<string, {command: string|fun(args: vim.api.keyset.create_user_command.command_args), opts: vim.api.keyset.user_command}>

--- Function to check for trailing '!' in command name
---@param name string
---@param bang_field boolean|nil
---@return string, boolean
function UserCommands.bang_check(name, bang_field)
  local bang_res = false
  if UserCommands.debugging then
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

  if UserCommands.debugging then
    vim.print("initial bang_field: " .. tostring(bang_field))
    vim.print("initial bang_res: " .. tostring(bang_res))
    vim.print("final name: " .. name)
  end

  return name, bang_res
end

--- Function to create user commands
---
--- The `args.user_cmd_opts.bang` parameter is inferred from the `args.name` parameter.
--- That is, if it has a trailing '!', then it's true, else false.
--- @param args utils.Sudo.register_user_commands._inline_create.Opts
function UserCommands._create(args)
  --- Validations START
  -- stylua: ignore start
  if not args then args = {} end
  -- if not args.name or string.len(args.name) == 0 then args.name = "SudoBROKEN" end
  -- if not args.register_fn then args.register_fn = function(x) return x end end -- returning the `x` here should basically do nothing
  if not args.inner_fn_opts then args.inner_fn_opts = {} end
  if not args.user_cmd_opts then args.user_cmd_opts = {} end
  -- stylua: ignore end

  -- check 'name' starts with an uppercase letter, if not
  -- uppercase the first letter.
  if string.len(args.name) > 0 and not args.name:match("^[A-Z]") then
    args.name = args.name:sub(1, 1):upper() .. args.name:sub(2)
  elseif string.len(args.name) == 0 then
    args.name = "BROKEN" .. tostring(UserCommands)
  end

  --- Set a generic description based on the args.name
  --- if none is provided
  if not args.user_cmd_opts.desc then
    args.user_cmd_opts.desc = tostring(UserCommands) .. " " .. "command: " .. args.name
  end

  local name, bang_res = UserCommands.bang_check(args.name, args.user_cmd_opts.bang)
  args.name = name
  args.user_cmd_opts.bang = bang_res

  if UserCommands.debugging then
    vim.print("\nname: " .. args.name .. ", bang: " .. tostring(args.user_cmd_opts.bang) .. "\n\n")
  end

  --- Validations END

  UserCommands.register(args.name, function(ctx)
    if type(ctx.register_fn) ~= "function" then
      return
    end

    if type(ctx.inner_fn_opts) == "table" and vim.tbl_isempty(ctx.inner_fn_opts) then
      ctx.register_fn()
    elseif type(ctx.inner_fn_opts) == "table" then
      ctx.register_fn(ctx.inner_fn_opts)
    else
      require("utils.output").err(
        "1. "
          .. tostring(UserCommands)
          .. ".user_cmd_fn (inline)"
          .. " :: _create(args). args.inner_fn_opts be a valid table. Assuming `Sudo.sudo_write()`."
      )
      -- return Sudo.sudo_write()
    end
  end, args.user_cmd_opts)
end

--- Registers a user command in Neovim
---@param command_name string The name of the command2
---@param command_fn string|fun(args: vim.api.keyset.create_user_command.command_args) The command to execute
---@param command_opts vim.api.keyset.user_command|nil Options for the command
function UserCommands.register(command_name, command_fn, command_opts)
  vim.api.nvim_create_user_command(command_name, command_fn, command_opts or {})
end

--- Takes a list of commands and registers them in Neovim
--- using `UserCommands.register`, which internally calls
--- `vim.api.nvim_create_user_command` with the provided parameters.
---@param opts utils.UserCommands.setup.Opts
function UserCommands.batch_register(opts)
  --
  opts = opts or {}

  if not opts.commands or #opts.commands == 0 then
    require("utils.output").warn("No user commands to register.")
    -- opts.commands = opts.commands or {}
    return
  end

  --

  local errors = {}

  for _, v in ipairs(opts.commands) do
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
          "1. "
            .. tostring(UserCommands)
            .. ".user_cmd_fn (inline)"
            .. " :: batch_register(opts). opts.commands be a valid table, and container `inner_fn_opts`. Assuming `Sudo.sudo_write()`."
        )
        table.insert(errors, v.name)
        -- return Sudo.sudo_write()
      end
    end

    UserCommands._create({
      name = v.name,
      register_fn = v.command or user_cmd_fn,
      inner_fn_opts = v.inner_fn_opts or {},
      user_cmd_opts = v.user_cmd_opts or {},
    })

    local ok, _ = pcall(function()
      UserCommands.register(v.name, user_cmd_fn, v.user_cmd_opts or {})
    end)

    -- local ok, _ = pcall(UserCommands.register, v.name, user_cmd_fn, v.user_cmd_opts or {})
    -- if not ok then
    --   table.insert(errors, v.name)
    -- end
  end

  if vim.tbl_isempty(errors) then
    return
  end

  if #errors > 0 then
    local errors_str = ""
    for _, cmd_name in ipairs(errors) do
      errors_str = errors_str .. cmd_name .. ", "
    end

    require("utils.output").err(
      "2. "
        .. tostring(UserCommands)
        .. " :: batch_register"
        .. " :: Failed to register the following commands: "
        .. errors_str
    )
  end

  --
end

--- Setup function for utils.UserCommands module.
---@param opts utils.UserCommands.setup.Opts|nil Options for setting up user commands
function UserCommands.setup(opts)
  opts = opts or {}

  -- set early so we can reutrn whenever further down in the fn
  UserCommands = setmetatable(UserCommands, {
    __tostring = function()
      return "utils.UserCommands"
    end,
  })

  if not opts.commands then
    return UserCommands
  end

  UserCommands.batch_register(opts)

  return UserCommands
end

---@return utils.UserCommands
return UserCommands.setup()
