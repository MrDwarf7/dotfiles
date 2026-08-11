---@type HL.GestureSpec[]
local gestures = {
  {
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
  },
}

for _, gesture in ipairs(gestures) do
  hl.gesture(gesture)
end
