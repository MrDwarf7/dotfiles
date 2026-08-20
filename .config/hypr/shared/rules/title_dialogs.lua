--- Title-based dialog float rules.
--- All follow the same pattern: match title regex, float, center.

local list = require("utils.lst")

---@type RegexStr[]
local dialogs = {
  "^(Open File)(.*)$",
  "^(Select a File)(.*)$",
  "^(Choose wallpaper)(.*)$",
  "^(Open Folder)(.*)$",
  "^(Save As)(.*)$",
  "^(Save File)(.*)$",
  "^(Library)(.*)$",
  "^(File Upload)(.*)$",
  "^(.*)(wants to save)$",
  "^(.*)(wants to open)$",
}

--- Creates a float rule for a given title. This is a helper function to reduce boilerplate.
---@param title RegexStr
---@return HyprConfig.HL.WindowRuleSpec
local make_float = function(title)
  return {
    name = "float-dialog-" .. title,
    match = { title = title },
    center = true,
    float = true,
  }
end

--- 'Dummy' helper to clean up the list.map call
---@param title RegexStr
local window_rule_float = function(title)
  hl.window_rule(make_float(title))
end

list.map(dialogs, window_rule_float)
