local Logger = {
  --- os.getenv("HOME") .. "/MY_hyprland_debug.log",
  log_file = nil,
}

function Logger:new(file_location)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self
  if file_location then
    obj.log_file = file_location
  else
    local home = os.getenv("HOME")
    if home then
      print("[hyprland] Logger initialized. Log file: " .. home .. "/hyprland_debug.log")
      obj.log_file = home .. "/hyprland_debug.log"
    else
      print("[hyprland] WARNING: HOME environment variable not set. Logger will not write to file.")
      obj.log_file = nil
    end
  end
  return obj
end

function Logger:log(message)
  if not message then
    message = "nil"
  end
  if not self.log_file then
    print("[hyprland] ERROR: Logger has no log file specified.")
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
  if file then
    file:write(message .. "\n")
    file:close()
  else
    print("[hyprland] ERROR: Unable to open log file: " .. self.log_file)
  end
end

return Logger
