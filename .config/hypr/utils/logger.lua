local Logger = {}

function Logger:log(message)
  local log_file = os.getenv("HOME") .. "/MY_hyprland_debug.log"
  local file = io.open(log_file, "a")
  if not file then
    -- create it
    file = io.open(log_file, "w")
    if file then
      file:write("\n\0")
      file:close()
    end
  end
  if file then
    file:write(message .. "\n")
    file:close()
  else
    print("[hyprland] ERROR: Unable to open log file: " .. log_file)
  end
end

return Logger
