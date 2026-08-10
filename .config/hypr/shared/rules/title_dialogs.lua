--- Title-based dialog float rules.
--- All follow the same pattern: match title regex, float, center.

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

---@type string
for _, title in ipairs(dialogs) do
  hl.window_rule(make_float(title))
end
