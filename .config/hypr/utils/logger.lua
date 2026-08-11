---@class HyprConfig.Logger
---@field log_file? string Optional path to the log file. If not provided, defaults to "$HOME/MY_hyprland_debug.log" if HOME env var is set, otherwise logs will not be written to a file.
---@field prefix string Optional prefix for log messages. Defaults to "[hyprland_lua] ".
---@field _inspect? any Optional field to hold the inspect module if loaded, used for pretty-printing tables in logs.
---@field new fun(opts?: HyprConfig.Logger): HyprConfig.Logger Constructor for the Logger class. Takes an optional table of settings to configure the logger (log_file and prefix).
---@field log fun(self: HyprConfig.Logger, message: string): void Logs a message to the configured log file with a timestamp and prefix. If the log file cannot be opened, prints an error to the console.
---@field override_global_print fun(self: HyprConfig.Logger): void Overrides the global print function
local logger = {
  --- os.getenv("HOME") .. "/MY_hyprland_debug.log",
  log_file = nil,
  enabled = true,
  prefix = "[hyprland_lua] ",
}

local log_filename = "MY_hyprland_debug"

local blank = function()
  -- stylua: ignore start
  return setmetatable({}, {
    __index = function() return function() end end, -- noop for all methods
    __tostring = function() return "Logger(DISABLED)" end,
    __len = function() return 0 end,
    __call = function(cls, ...)
      return cls.new(...)
    end,
  })
  -- stylua: ignore end
end

--- Optionally takes a handful of settings to configure the Logger.
--- `opts` are checked individually and defaults are set for missing sections/values.
---
---@param opts? HyprConfig.Logger
---@return HyprConfig.Logger
logger.new = function(opts)
  opts = opts or {}

  if opts.enabled == false then
    local b = blank()
    ---@cast b HyprConfig.Logger
    return b
  end

  local obj = {}

  obj = blank() -- start with a blank logger, then override the noop methods with real ones as needed
  obj.enabled = opts.enabled ~= false -- default to true if not explicitly set to false
  obj = setmetatable(obj, {
    __index = logger,
    __tostring = function()
      return string.format("Logger(log_file=%s, prefix=%s)", obj.log_file or "nil", obj.prefix or "nil")
    end,
    __len = function() -- get the line count for the current log file (or 0 if not)
      local lc = 0
      if obj.log_file then
        local file = io.open(obj.log_file, "r")
        if file then
          for _ in file:lines() do
            lc = lc + 1
          end
          file:close()
        end
      end
      return lc
    end,
    __call = function(cls, ...)
      return cls.new(...)
    end,
  })

  local filename_as_path = string.format("/%s.log", log_filename)

  if opts.log_file then
    obj.log_file = opts.log_file
  else
    local home = os.getenv("HOME")
    if home then
      print("[hyprland] Logger initialized. Log file: " .. home .. filename_as_path)
      obj.log_file = home .. filename_as_path
    else
      print("[hyprland] WARNING: HOME environment variable not set. Logger will not write to file.")
      obj.log_file = nil
    end
  end

  if opts.prefix then
    obj.prefix = opts.prefix
  else
    obj.prefix = "[hyprland_lua] "
  end

  ---@cast obj HyprConfig.Logger
  return obj
end

--- Loads the 'inspect' module from utils.inspect and stores it in Logger._inspect for later use.
--- If loading fails, logs an error and sets _inspect to nil.
---@param self HyprConfig.Logger The logger instance.
---@return bool A boolean indicating whether the inspect module was successfully loaded.
logger.load_inspect = function(self)
  local err, inspect = pcall(require, "utils.inspect")
  if err then
    self:log("Logger:inspect() failed to load inspect module: " .. tostring(inspect))
    return false
  end

  logger._inspect = inspect

  return true
end

---@param self HyprConfig.Logger The logger instance.
logger.inspect = function(self, value)
  if not logger._inspect or self._inspect == nil then
    local loaded = self:load_inspect()
    if not loaded then
      return tostring(value)
    end
  end

  return logger._inspect(value)
end

-- TODO: Need to probably move the `log` function itself to a sub-table
-- same as the `:override_global_print` fn, and have them be look'ed up via a metatable function.
-- means we can then override the entire logging system for those 2 functions with either the built-in one (like current)
-- OR
-- _if_ we can load the utils.inspect module, then we can use that to log tables in a more readable way.
--

---@param self HyprConfig.Logger The logger instance.
---@param message string The message to log. Can be any type; if not a string, it will be converted to a string.
---@return void
logger.log = function(self, message)
  if (not self.enabled or self.enabled == false) or logger.enabled == false then
    return
  end

  if not message then
    message = "nil"
  end
  self.prefix = self.prefix or "[hyprland_lua] " -- mostly redundant tbh

  if not self.log_file then
    print(string.format("%s%s", self.prefix, "[hyprland_lua] ERROR: Logger has no log file specified."))
    return
  end

  local file = io.open(self.log_file, "a")
  if not file then
    -- create it
    file = io.open(self.log_file, "w")
    if file then
      file:write("\n\0")
      file:close()
    end
  end
  local timestamp = os.date("[%Y-%m-%d %H:%M:%S]")
  message = string.format("%s %s :: %s", self.prefix, timestamp, message)
  if file then
    file:write(message .. "\n")
    file:close()
  else
    print(string.format("%s %s", self.prefix, "ERROR: Failed to open log file for writing."))
  end
end

---@param self HyprConfig.Logger The logger instance.
---@return void
logger.override_global_print = function(self)
  print = function(...)
    local args = { ... }
    local message_parts = {}
    for _, arg in ipairs(args) do
      if type(arg) == "table" then
        local success, result = pcall(function()
          return require("utils.tbl_mod").to_string(arg)
        end)
        if success then
          table.insert(message_parts, result)
        else
          table.insert(message_parts, tostring(arg))
        end
      else
        table.insert(message_parts, tostring(arg))
      end
    end
    local message = table.concat(message_parts, " ")
    self:log(message)
  end
end

if not _G.logger then
  _G.logger = logger:new()
end

---@type HyprConfig.Logger
---@return HyprConfig.Logger
return logger
