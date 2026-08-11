---@brief
---
--- https://github.com/luals/lua-language-server
---
--- Lua language server.
---
--- `lua-language-server` can be installed by following the instructions [here](https://luals.github.io/#neovim-install).
---
--- The default `cmd` assumes that the `lua-language-server` binary can be found in `$PATH`.
---
--- If you primarily use `lua-language-server` for Neovim, and want to provide completions,
--- analysis, and location handling for plugins on runtime path, you can use the following
--- settings.
---
--- ```lua
--- vim.lsp.config('lua_ls', {
---   on_init = function(client)
---     if client.workspace_folders then
---       local path = client.workspace_folders[1].name
---       if
---         path ~= vim.fn.stdpath('config')
---         and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
---       then
---         return
---       end
---     end
---
---     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
---       runtime = {
---         -- Tell the language server which version of Lua you're using (most
---         -- likely LuaJIT in the case of Neovim)
---         version = 'LuaJIT',
---         -- Tell the language server how to find Lua modules same way as Neovim
---         -- (see `:h lua-module-load`)
---         path = {
---           'lua/?.lua',
---           'lua/?/init.lua',
---         },
---       },
---       -- Make the server aware of Neovim runtime files
---       workspace = {
---         checkThirdParty = false,
---         library = {
---           vim.env.VIMRUNTIME
---           -- Depending on the usage, you might want to add additional paths
---           -- here.
---           -- '${3rd}/luv/library'
---           -- '${3rd}/busted/library'
---         }
---         -- Or pull in all of 'runtimepath'.
---         -- NOTE: this is a lot slower and will cause issues when working on
---         -- your own configuration.
---         -- See https://github.com/neovim/nvim-lspconfig/issues/3189
---         -- library = {
---         --   vim.api.nvim_get_runtime_file('', true),
---         -- }
---       }
---     })
---   end,
---   settings = {
---     Lua = {}
---   }
--- })
--- ```
---
--- See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the above fields:
--- * [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
--- * [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)
---

local root_markers1 = {
  ".emmyrc.json",
  ".luarc.json",
  ".luarc.jsonc",
}

local root_markers2 = {
  ".luacheckrc",
  ".stylua.toml",
  "stylua.toml",
  "selene.toml",
  "selene.yml",
}

local root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers1, root_markers2, { ".git" } }
  or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { ".git" })

local library_paths = {
  vim.split(package.path, ";"),
  vim.env.VIMRUNTIME,
  vim.api.nvim_get_runtime_file("", true),
  "$VIMRUNTIME",
  "$VIMRUNTIME/lua",
  "${3rd}/luv/library",
  "${3rd}/busted/library",
  "${3rd}/luaassert/library",
  "lua",
  "lua/?.lua",
  "lua/?/init.lua",
  -- vim.fn.stdpath("data") .. "/lazy/wezterm-types/lua/wezterm/types/wezterm.lua",
}

library_paths = vim.list_extend(
  library_paths,
  vim.tbl_filter(function(d)
    return not d:match(vim.fn.stdpath("config") .. "/?a?f?t?e?r?")
  end, vim.api.nvim_get_runtime_file("", true))
)

local runtime_t = {
  version = "LuaJIT",
  path = library_paths,
}

local workspace_t = {
  checkThirdParty = true,
  library = library_paths,
  ignoreDir = {
    "node_modules",
    "target",
    "vendor",
  },
}

---@type vim.lsp.Config
return {
  ---@param client vim.lsp.Client
  ---@return void
  on_init = function(client) ---@type (function|vim.lsp.Config)?
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    if type(client.config.settings.Lua) ~= "table" then
      client.config.settings.Lua = {}
    end

    assert(type(client.config.settings.Lua) == "table", "Expected client.config.settings.Lua to be a table")

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = runtime_t,
      workspace = workspace_t,
    })
  end,

  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = root_markers,
  settings = {
    Lua = {
      runtime = runtime_t,
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        disable = { "missing-fields" },
        globals = { "vim", "require" },
      },
      workspace = workspace_t,
      codeLens = {
        enable = true,
        completion = {
          callSnippet = "Replace",
        },
        doc = {
          privateName = { "^_" },
        },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
        library = library_paths,
        -- {
        --   vim.env.VIMRUNTIME,
        --   vim.api.nvim_get_runtime_file("", true),
        --   "$VIMRUNTIME",
        --   "$VIMRUNTIME/lua",
        --   "${3rd}/luv/library",
        --   "${3rd}/busted/library",
        --   "${3rd}/luaassert/library",
        --   "lua",
        -- },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
