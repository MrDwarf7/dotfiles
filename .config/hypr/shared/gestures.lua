local list = require("utils.lst")

---@type HL.GestureSpec[]
local gestures = {
  {
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
  },
}

list.map(gestures, hl.gesture)
