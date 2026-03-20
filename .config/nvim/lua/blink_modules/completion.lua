---@class BlinkModules.Completion : blink.cmp.CompletionConfigPartial

-- local menus = require("blink_modules.comp_menu_types")

---@private
---@return blink.cmp.CompletionMenuConfigPartial
local function menu()
  ---@type blink.cmp.CompletionMenuConfigPartial
  return {
    auto_show = true,
    min_width = 10,
    -- max_width = 100, -- 80 is default in blink docs
    max_height = 40, -- default is 20, (or does it use LazyVim's options.pumheight setting? -- changing it here overrides it anyway)
    border = "single",
    -- draw = require("blink_modules.comp_menu_types").colorful,
    draw = require("blink_modules.comp_menu_types").colorful, -- menu_type
  }
end

---@private
---@return blink.cmp.CompletionDocumentationConfigPartial
local function documentation()
  ---@type blink.cmp.CompletionDocumentationConfigPartial
  return {
    auto_show = true,
    auto_show_delay_ms = 100,
    -- DOC BORDER
    window = {
      border = "single",
    },
  }
end

---@private
---@return blink.cmp.CompletionGhostTextConfigPartial
local function ghost_text()
  ---@type blink.cmp.CompletionGhostTextConfigPartial
  return {
    enabled = true,
    show_with_menu = true,
  }
end

---@return BlinkModules.Completion

return { ---@type blink.cmp.CompletionConfigPartial
  menu = menu(), -- menu_type
  documentation = documentation(),
  ghost_text = ghost_text(),
}
