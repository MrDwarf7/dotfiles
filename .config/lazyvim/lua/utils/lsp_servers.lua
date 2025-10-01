----- Items marked with TODO are to be turned back on
----- Items marked with NOTE will likely need to be tweaked

local arch = require("utils.arch")

-----@class LspServers
-----@field servers table<string, table>
local M = {}

M.servers = {
  -- bacon_ls = {
  --   enabled = diagnostics == "bacon-ls",
  -- },
  basedpyright = {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
      ".git",
      "setup.py",
      "setup.cfg",
      "pyproject.toml",
      "requirements.txt",
      "\\.venv",
      "venv",
      --
      "Pipfile",
      "pyrightconfig.json",
    },
    settings = {
      -- pyright = {
      --   config = vim.fn.getcwd() .. "/pyrightconfig.json",
      -- },
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
  }, -- ???
  bashls = {},
  biome = {},
  -- c3_lsp = {},
  clangd = {
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
      )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
        "lspconfig.util"
      ).find_git_ancestor(fname)
    end,
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
    cmd = {
      "clangd",
      -- "--std=c++latest",
      "--background-index",
      -- "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    -- cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
    -- single_file_support = true,
    -- capabilities = self:capabilities(),
  },
  cssls = {},
  css_variables = {},
  cssmodules_ls = {},
  -- deno = {}, -- commented due to conflict with tsserver
  -- deno = {
  -- 	root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
  -- 	settings = {
  -- 		deno = {
  -- 			enable = true,
  -- 			suggest = {
  -- 				imports = {
  -- 					hosts = {
  -- 						["https://deno.land"] = true,
  -- 					},
  -- 				},
  -- 			},
  -- 		},
  -- 	},
  -- },
  docker_compose_language_service = {},
  dockerls = {},
  -- erlangls = {},
  -- eslint = {},
  -- gleam = {},
  -- gopls = {},
  html = {},
  hyprls = {},
  jsonls = {},
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath("config")
          and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
          path = {
            "lua/?.lua",
            "lua/?/init.lua",
          },
        },
        workspace = {
          checkThirdParty = true,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      })
    end,
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
      ".git",
    },
    root_dir = require("lspconfig.util").root_pattern(
      ".git",
      ".luacheckrc",
      ".luarc.json",
      ".luarocks",
      "lua.config.*",
      ".vim",
      "nvim"
    ),
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          disable = { "missing-fields" },
          globals = { "vim", "require" },
        },
        workspace = {
          checkThirdParty = true,
          library = {
            vim.env.VIMRUNTIME,
            vim.api.nvim_get_runtime_file("", true),
            "$VIMRUNTIME",
            "$VIMRUNTIME/lua",
            -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            "${3rd}/luv/library",
            "${3rd]/busted/library",
            "${3rd]/luaassert/library",
            "lua",
            -- unpack(vim.api.nvim_get_runtime_file("", true)),
            -- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },

          -- library = vim.api.nvim_get_runtime_file("", true),
        },
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
          library = {
            "$VIMRUNTIME",
            "$VIMRUNTIME/lua",
            -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            "${3rd}/luv/library",
            "${3rd]/busted/library",
            "${3rd]/luaassert/library",
            "lua",
            -- unpack(vim.api.nvim_get_runtime_file("", true)),
            -- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  -- marksman = {},
  -- markdown_oxide = {},
  mesonlsp = {},
  neocmake = {},
  ocamlls = {
    cmd = { "ocamllsp", "--stdio" },
    filetypes = { "ocaml", "reason" },
    root_dir = require("lspconfig.util").root_pattern("dune-project", "dune-workspace", "dune"),
    settings = {
      ocamllsp = {
        diagnostics = {
          enable = true,
        },
        formatting = {
          enable = true,
        },
        symbols = {
          enable = true,
        },
      },
    },
  },
  ocamllsp = {},
  ols = {},
  omnisharp = {
    filetypes = { "cs", "vb" },
  },
  -- powershell_es = {
  --   -- cmd = { "pwsh", "-NoLogo", "-NoProfile", "-Command", "Invoke-EditorServices" },
  --   filetypes = { "powershell", "ps1", "psm1", "psd1" },
  --   root_dir = require("lspconfig.util").root_pattern(".git", ".editorconfig", ".gitignore", ".ps1", ".psm1", ".psd1"),
  --   settings = {
  --     powershell = {
  --       codeFormatting = {
  --         Preset = "OTBS",
  --       },
  --     },
  --     scriptAnalysis = {
  --       enable = true,
  --     },
  --     completion = {
  --       enable = true,
  --       useCommandDiscovery = true,
  --     },
  --   },
  -- },
  prismals = {},
  -- svelte_language_server = {},
  -- pyright = {
  --   cmd = { "pyright-langserver", "--stdio" },
  --   filetypes = { "python" },
  --   root_dir = require("lspconfig.util").root_pattern(
  --     ".git",
  --     "setup.py",
  --     "setup.cfg",
  --     "pyproject.toml",
  --     "requirements.txt",
  --     "\\.venv",
  --     "venv"
  --   ),
  --   on_attach = vim.lsp.inlay_hint.enable(),
  --   settings = {
  --     python = {
  --       analysis = {
  --         autoSearchPaths = true,
  --         diagnosticMode = "workspace",
  --         useLibraryCodeForTypes = true,
  --       },
  --     },
  --   },
  -- },
  -- qmls = {},
  ruff = {
    -- cmd_env = { RUFF_TRACE = "messages" },
    -- init_options = {
    --   settings = {
    --     logLevel = "error",
    --   },
    -- },
    keys = {
      {
        "<Leader>lo",
        LazyVim.lsp.action["source.organizeImports"],
        desc = "Organize Imports",
      },
    },
    -- filetypes = { "python" },
    ------ most of this is already setup via LazyVim's extra for lang.python
    -- setup = {
    -- [ruff] = function(_, opts)
    -- 	LazyVim.lsp.on_attach(function(client, _)
    -- 		client.server_capabilities.hoverProvider = false
    -- 	end, ruff)
    -- end
    -- }
  },

  -- stylua = {},
  -- svelte-language-server = {}
  rust_analyzer = { enabled = false }, -- NOTE: If using bacon_ls then this is FALSE OTHERWISE -> enabled = true;

  tailwindcss = {
    filetypes = {
      "html",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    flags = { debounce_text_changes = 300 },
    root_dir = require("lspconfig.util").root_pattern("tailwind.config.*"),
  },
  taplo = {},
  vimls = {},
  -- volar = {},
  yamlls = {},
  zls = {
    settings = {
      zls = {
        -- zig_exe_path = zig_exe,
        enableAutofix = true,
        enable_snippets = true,
        enable_ast_check_diagnostics = true,
        enable_autofix = true,
        enable_import_embedfile_argument_completions = true,
        warn_style = true,
        enable_semantic_tokens = true,
        enable_inlay_hints = true,
        inlay_hints_hide_redundant_param_names = true,
        inlay_hints_hide_redundant_param_names_last_token = true,
        operator_completions = true,
        include_at_in_builtins = true,
        max_detail_length = 1048576,
      },
    },
  },
}

return M
