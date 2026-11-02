----------- for now we just do it the naive way

-- rex.unbind()

require("label")
require("copy_mode")

local map = rex.bind
local leader = "ctrl+a>"

local map_leader = function(key, ...)
  leader = leader or "ctrl+a>" -- TODO: normalize on external leader combo not needing the trailing `>` thing and handle it internally here
  local args = { ... }
  return map(leader .. key, unpack(args))
end

local del_leader = function(key, ...)
  leader = leader or "ctrl+a>" -- TODO: normalize on external leader combo not needing the trailing `>` thing and handle it internally here
  local args = { ... }
  return rex.unbind(leader .. key, unpack(args))
end

rex.unbind("cmd+enter")
rex.unbind("cmd+shift+enter")
rex.unbind("cmd+d")
rex.unbind("cmd+shift+d")
rex.unbind("cmd+shift+right")
rex.unbind("cmd+shift+down")

map_leader("r", "client.config.reload")
map_leader("shift+r", "client.tab.rename")
map_leader("b", "client.sidebar.toggle")

map_leader("y", "copy_mode")

map_leader("shift+;", "client.palette.toggle")

-- mapleader("g", "client.tab_style.toggle")

map_leader("s", "session.switch")

-- mapleader("s", "session.select", { session_id, window_id? })

map_leader("shift+o", "session.new")
map_leader("shift+d", "session.close")
map_leader("shift+s", "session.rename")

map_leader("c", "client.tab.new")
map_leader("d", "client.tab.close")

map_leader("n", "client.tab.next")
map_leader("p", "client.tab.previous")

-- client.tab.move

map_leader(",", "client.tab.move", { direction = "backward" })
map_leader(".", "client.tab.move", { direction = "forward" })

for i = 1, 9 do
  -- rex.unbind("cmd+" .. tostring(i))
  map_leader(tostring(i), "client.tab.goto", { index = i })
end

map_leader("shift+6", "client.tab.goto", { index = 1 })
map_leader("shift+4", "client.tab.goto", { index = -1 })

-- TODO: Find a way to bind N and P as +2 // -2

map_leader("z", "pane.zoom")
map_leader("f", "pane.float")

-- rex.action({
--   name = "float_center",
--   title = "Float Centered",
--   run = function(ctx, args)
--     rex.session.new_window({
--       layout = rex.layout.block({
--         flavor = "com.superlogical.terminal.shell",
--         float = true,
--         position = "center",
--       }),
--     })
--   end,
-- })

-- map_leader("shift+f", "float_center")

map_leader("e", "pane.balance")

map_leader("\\", "pane.split", { direction = "right" })
map_leader("-", "pane.split", { direction = "down" })

map_leader("h", "pane.focus", { direction = "left" })
map_leader("j", "pane.focus", { direction = "down" })
map_leader("k", "pane.focus", { direction = "up" })
map_leader("l", "pane.focus", { direction = "right" })

map_leader("shift+h", "pane.move", { direction = "left" })
map_leader("shift+j", "pane.move", { direction = "down" })
map_leader("shift+k", "pane.move", { direction = "up" })
map_leader("shift+l", "pane.move", { direction = "right" })

-- pane.resize                      Resize Pane                direction, amount?

map("ctrl+left", "pane.resize", { direction = "left", amount = 8 })
map("ctrl+down", "pane.resize", { direction = "down", amount = 4 })
map("ctrl+up", "pane.resize", { direction = "up", amount = 4 })
map("ctrl+right", "pane.resize", { direction = "right", amount = 8 })

-- pane.move_to_new_tab             Move Pane to New Tab
map_leader("shift+1", "pane.move_to_new_tab")

-- pane.move_to_tab                 Move Pane to Tab…

-- rex.action({
--   name = "scratch",
--   title = "Open Scratch Window",
--   run = function(ctx, args)
--     rex.session.new_window({
--       layout = rex.layout.block({
--         flavor = "com.superlogical.terminal.shell",
--       }),
--     })
--   end,
-- })
--
-- map_leader("g", "scratch")
