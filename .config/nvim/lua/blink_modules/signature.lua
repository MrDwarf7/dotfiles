---@class BlinkModules.Signature : blink.cmp.SignatureConfigPartial

---@private
---@return blink.cmp.SignatureWindowConfigPartial
local function window()
  ---@type blink.cmp.SignatureWindowConfigPartial
  return {
    -- min_width = 1,
    -- max_width = 100,
    -- max_height = 10,
    border = "single",
    show_documentation = false, -- ############## This is the little one
  }
end

---@return BlinkModules.Signature
---@type blink.cmp.SignatureConfigPartial
return {
  -- signature.enabled = true will show a little 'mini' function signature above/next to completion as you enter (__) <- this space
  -- but this is a LOT when the docs flyout is there AS WELL
  enabled = false, -- defaults to off (same as docs)
  trigger = {
    enabled = true,
  },
  -- DOC BORDER
  window = window(),
}
