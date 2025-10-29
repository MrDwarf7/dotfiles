local folder_name = "vimpack"
local nvim_dir = vim.fn.stdpath("config")
local fullpath = nvim_dir .. "/lua/" .. folder_name

require("utils")

vim.print(vim.inspect(fullpath))

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/Saghen/blink.compat" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp" },
})

---@return string
local function get_cwd()
  return fullpath
    :gsub(nvim_dir, "") -- remove the leading full path section
    :gsub("\\", "/") -- fix windows bs
    :gsub("/+", "/") -- fix windows bs
    :gsub("/", "%.")
    :gsub("%.lua%.", "")
end

--- Builds a local filepath to the current
--- directory using module level globals.
---
--- Returns `true` if the module loaded.
--- and `false` if it failed.
---
---@param filename string
---@return boolean|table
local function require_local(filename)
  local fmtted = get_cwd()

  fmtted = fmtted:sub(-1) == "." and fullpath:sub(1, -2) or fmtted .. "." .. filename

  local ok, module_table = pcall(require, fmtted)
  if not ok then
    vim.notify(
      "The filename/module requested isn't available. You tried: '" .. filename .. "'. Which formatted as: " .. fmtted
    )
    return false
  end
  return module_table
end

local plugin_order = {
  "oil",

  "mason",
  "mason-lspconfig",
  "mason-tool-installer",

  "lazydev",
  "luasnip",
  "blink",

  --
  "servers",
}

local collected = {}
for _, name in ipairs(plugin_order) do
  local mod = require_local(name)
	-- vim.print(vim.inspect(mod))
  if type(mod) == "table" then
    collected[name] = mod
  end
end

for _, name in ipairs(plugin_order) do
  local mod = collected[name]
  if mod then
    if type(mod.setup) == "function" then
      mod.setup()
    end
    if type(mod.keys) == "function" then
      mod.keys()
    end
  end
end

-- require_local("oil").setup().keys()
--
-- require_local("mason").setup().keys()
-- require_local("mason-lspconfig").setup().keys()
-- require_local("mason-tool-installer").setup().keys()
-- require("vimpack.servers").gather().setup()
--
-- -- require_local("lazydev").setup()
--
-- require_local("luasnip").setup()
-- require_local("blink").setup()
