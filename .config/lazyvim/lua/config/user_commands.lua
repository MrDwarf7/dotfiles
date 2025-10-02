if not vim.g.vscode then
  return {}
end

---@type NuiInput|fun(popup_options: nui_popup_options, options: nui_input_options):NuiInput
local Input = require("nui.input")

---@alias SecretInput NuiInput|fun(popup_options: nui_popup_options, options: nui_input_options):NuiInput

---@class UserCommands
---@field setup fun(): UserCommands
---@field sudo_save fun(): nil
---@field __has_init boolean
local M = {}

M.__has_init = false

function M.setup()
  -- vim.notify("Entering setup")
  if M.__has_init then
    return M
  end
  -- vim.notify("Initial has_init block finished.")

  vim.api.nvim_create_user_command("W", M.sudo_save, {
    desc = "Save file with sudo permissions",
    force = true,
  })
  -- vim.notify("Created user commands")

  M.__has_init = true
  -- vim.notify("Has init set")
  return M
end

---@class NuiInput
---@field _. nui_input_internal
---@field _mounted boolean
---@field conceal_char string
---@field extend fun(self: NuiInput, name: string): NuiInput

---@class SecretInput: nui_input_internal
---@field super NuiInput
---@field conceal_char string

---@type SecretInput
local SecretInput = Input:extend("SecretInput")
-- local SecretInput = Input:init

---nui_popup_options
---@class SecretInputOptions: nui_input_options
---@field conceal_char? string

---@param popup_options nui_popup_options
---@param options SecretInputOptions
function SecretInput:init(popup_options, options)
  assert(
    not options.conceal_char or vim.api.nvim_strwidth(options.conceal_char) == 1,
    "conceal_char must be a single char"
  )

  popup_options.win_options = vim.tbl_deep_extend("force", popup_options.win_options or {}, {
    conceallevel = 2,
    concealcursor = "nvi",
  })

  SecretInput.super.init(self, popup_options, options)

  ---@diagnostic disable-next-line: inject-field, invisible
  self._.conceal_char = type(options.conceal_char) == "nil" and "*" or options.conceal_char
end

function SecretInput:mount()
  SecretInput.super.mount(self)

  ---@type string?
  local conceal_char = self._.conceal_char ---@diagnostic disable-line: invisible, undefined-field
  local prompt_length = vim.api.nvim_strwidth(vim.fn.prompt_getprompt(self.bufnr))

  vim.notify("SecretInput is about to mount!")

  vim.api.nvim_buf_call(self.bufnr, function()
    vim.cmd(string.format(
      [[
        syn region SecretValue start=/^/ms=s+%s end=/$/ contains=SecretChar
        syn match SecretChar /./ contained conceal %s
      ]],
      prompt_length,
      conceal_char and "cchar=" .. (conceal_char or "*") or ""
    ))
  end)
end

function M.sudo_save()
  -- return vim.cmd([[ command! W execute 'w !sudo tee % > /dev/null' <bar> edit! ]])
  -- vim.api.nvim_paste(, crlf, phase)
  -- vim.api.nvim_input(":execute 'w !sudo tee % >/dev/null' <bar> edit!")

  local bar = vim.keycode("<bar>")
  local base_cmd = ":execute 'w !sudo tee % >/dev/null'"
  local main_cmd = string.format("%s " .. "edit!", bar)
  local cmd = base_cmd .. " " .. main_cmd

  vim.api.nvim_feedkeys(cmd, "n", true)

  local event = require("nui.utils.autocmd").event

  ---@type nui_popup_options
  local popup_options = {
    relative = "cursor",
    size = 20,
    border = {
      style = "single",
      text = {
        top = "[Input]",
        top_align = "left",
      },
    },
    win_options = {
      win_highlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual",
    },
  }

  local opts = {
    conceal_char = false, -- entirely hide all chars
    prompt = "> ",
    default_value = cmd,
    on_close = function()
      vim.notify("Input closed")
    end,
    on_submit = function(value)
      -- Execute the command
      -- vim.cmd(value)
      -- vim.cmd("noautocmd " .. value) -- Use noautocmd to avoid triggering autocommands
      vim.api.nvim_feedkeys(value, "n", true) -- Feed the command to Neovim
      vim.notify("Command executed: " .. value)

      -- We may need to provide something for the callback to block-on to
      -- prevent the password input field from being dropped/closed immediately
      -- vim.defer_fn(function()
      --   input:close()
      -- end, 1000) -- Close after 1 second
    end,

    on_change = function(value)
      -- Handle input change if needed
      vim.notify("Input changed: " .. value)
    end,
  }

  local secret_input = SecretInput(popup_options, opts)

  secret_input:on("BufWinEnter", function()
    vim.notify("Secret input buffer entered")
    secret_input._mounted = true
  end)

  secret_input:on("BufLeave", function()
    vim.notify("Secret input buffer left")
    secret_input:unmount()
  end, { once = true })

  -- local input = Input(popup_options, {
  --   prompt = "> ",
  --   default_value = cmd,
  --   on_close = function()
  --     vim.notify("Input closed")
  --   end,
  --   on_submit = function(value)
  --     -- Execute the command
  --     -- vim.cmd(value)
  --     -- vim.cmd("noautocmd " .. value) -- Use noautocmd to avoid triggering autocommands
  --     vim.api.nvim_feedkeys(value, "n", true) -- Feed the command to Neovim
  --     vim.notify("Command executed: " .. value)
  --
  --     -- We may need to provide something for the callback to block-on to
  --     -- prevent the password input field from being dropped/closed immediately
  --     -- vim.defer_fn(function()
  --     --   input:close()
  --     -- end, 1000) -- Close after 1 second
  --
  --     local secret = SecretInput(popup_options, {
  --       conceal_char = false,
  --     })
  --   end,
  --
  --   -- on_change = function(value)
  --   --   -- Handle input change if needed
  --   --   vim.notify("Input changed: " .. value)
  --   -- end,
  -- })

  -- vim.notify("Input mounted, waiting for user input...")

  -- Optionally, you can unmount the input after a certain time or condition
  -- vim.defer_fn(function()
  --   input:unmount()
  --   vim.notify("Input unmounted")
  -- end, 5000) -- Unmount after 5 seconds
end

return M.setup()
