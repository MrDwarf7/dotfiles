-- Little module for managing autoformatting in LazyVim

---@alias void nil

---@class AutoFormat
---@field formatters_reset fun(): void
---@field toggle_autoformat fun(effect_global?: boolean, bufnr?: number): void
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyVim.format[k] then
      return LazyVim.format[k]
    end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("lazyvim.util.format." .. k)
    return t[k]
  end,
})

--- Resets both (Global | Buffer) to true
M.formatters_reset = function()
  LazyVim.format.enable(true, true) -- Enable?  |  Buffer scoped/only?
end

--- Toggles the autofromatting state for either buffer or global
---@param effect_global? boolean
---@param bufnr? number
M.toggle_autoformat = function(effect_global, bufnr)
  -- ensure `effect_global` is a boolean or nil
	-- stylua: ignore start
  assert( type(effect_global) == "boolean" or type(effect_global) == "nil", "toggle_autoformat requires param 'effect_global' to be nil or a boolean")
  -- ensure `bufnr` is a number or nil
  assert( type(bufnr) == "number" or type(bufnr) == "nil", "toggle_autoformat requires param 'bufnr' to be nil or a number")
  -- stylua: ignore end

  -- truth|false check sets -
  -- bufnr must be either type("nil") or type("number"), otherwise						-- default = nvim_get_current_buf()
  bufnr = (bufnr == nil or bufnr == 0) and vim.api.nvim_get_current_buf() or bufnr
  -- effect_global must be either type("nil") or type("boolean"), otherwise		-- default = true
  effect_global = (effect_global == nil) and true or (effect_global == true) or effect_global

  assert(type(bufnr) == "number", "bufnr must be a number or nil")

  LazyVim.format.enable(
    -- enable?
    not LazyVim.format.enabled(bufnr), -- swap based on current 'enabled' state
    not effect_global -- "Change buffer only?" -- if we passed `affect_global`, then we are asking the invert question for the LazyVim fn
  )
end

-- Dot notation (self.thing()) will basically reference the item in the table ( lookup )
-- where as self:thing() will actually attempt to call it ( method call )

--- Turns off autoformatting for the current buffer
---Writes the current buffer only, and quits/closes the current buffer
---@return void
function M:fmt_quit_buf()
  self:formatters_reset() -- reset to ensure when we call next it's always correct
  self.toggle_autoformat(false) -- GLOBAL change = no     toggle them, ONLY changing the currently selected buffer formatter
  vim.cmd([[w!]]) -- flush to disk
  self:formatters_reset() -- reset them again - so next launch isn't different to normal
  vim.cmd([[q!]]) -- quit nvim
end

--- Turns off autoformatting for globally and current buffer
--- writes ALL buffers, and quits/closes nvim
function M:fmt_quit_global()
  self:formatters_reset() -- reset to ensure when we call next it's always correct
  self.toggle_autoformat(true) -- GLOBAL change = yes     toggle them, changing the global formatter as well
  vim.cmd([[wa!]]) -- flush to disk
  self:formatters_reset() -- reset them again - so next launch isn't different to normal
  vim.cmd([[qa!]]) -- quit nvim
end

return M
