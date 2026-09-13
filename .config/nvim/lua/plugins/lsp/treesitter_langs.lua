---@class TreesitterLangs
---@field languages string[]
---@field languages_tbl fun(): string[] Returns a list of all languages.
---
---@field data_formats string[]
---@field data_formats_tbl fun(): string[] Returns a list of all data formats.
---
---@field system string[]
---@field system_tbl fun(): string[] Returns a list of all system files.
---
---@field flatten fun(): string[] Returns a flat list of all languages, data formats, and system files.
local M = {}

M = {
  --
  languages = {

    "awk",
    "bash",
    "c",
    "c_sharp",
    "cmake",
    "cpp",
    "css", -- not in given list but
    "elixir",
    "fish",
    "fsh",
    "go",
    "javascript",
    "jjdescription",
    "just",
    "lua",
    "luadoc",
    "luap",
    "make",
    "meson",
    "mlir",
    "nginx",
    "nu",
    "odin",
    "prisma",
    "python",
    "regex",
    "rust",
    "scss", --- not in given list but
    "sql",
    "terraform",
    "tsx",
    "typescript",
    "typst", -- not in given list but
    "vim",
    "zig",
    -- "luau",
    -- "powershell",
    -- "robot",
    -- "surrealdb",
    -- "teal",
    -- "tmux", --- WOULD BE moved to langs, but it's not really
  },

  data_formats = {

    "desktop",
    "embedded_template",
    "gomod",
    "gosum",
    "html",
    "htmldjango",
    "http",
    "ini",
    "jinja",
    "jinja_inline",
    "jq",
    "json",
    "json5",
    "kdl",
    "markdown",
    "markdown_inline",
    "poe_filter",
    "ron",
    "rst",
    "scss",
    "toml",
    "tsv",
    "vimdoc",
    "yaml",
    -- "jsonc",
  },

  system = {

    "diff",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "gpg",
    "ninja",
    "passwd",
    "printf",
    "ssh_config",
    -- "robots",
    -- "tmux", --- WOULD BE moved to langs, but it's not really
  },
}

-- TODO: [extract] : pull this out into a common if not already in vim_ext/{lst/tbl).lua

function M.flatten()
  local ret = {}
  for _, sub_tbl in pairs(M) do
    if type(sub_tbl) == "table" then
      for _, tool in ipairs(sub_tbl) do
        table.insert(ret, tool)
      end
    end
  end
  return ret
end

function M.languages_tbl()
  return M.languages
end
function M.data_formats_tbl()
  return M.data_formats
end
function M.system_tbl()
  return M.system
end

return M
