--
---@class utils.AutoFmt
---@field formatters_reset fun(): void
---@field toggle_autoformat fun(effect_global?: boolean, bufnr?: number): void
local Autofmt = {}

function Autofmt.setup()
  require("utils.output").warn("Autofmt setup called. Implementation not complete.")
  return Autofmt
end

-- return AutoFmt
return Autofmt
