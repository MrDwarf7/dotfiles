----- Items marked with TODO are to be turned back on
----- Items marked with NOTE will likely need to be tweaked

return {
  bacon_ls = {
    enabled = diagnosticls == "bacon-ls",
  },
  bashls = {},
  basedpyright = {}, -- ???
  biome = {},
  clangd = {
    -- TODO:
    cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
    single_file_support = true,
    -- capabilities = self:capabilities(),
  },
  neocmake = {},
  cssls = {},

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
  html = {},
  jsonls = {},
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_dir = require("lspconfig.util").root_pattern(".git", ".luacheckrc", ".luarocks", "lua.config.*"),
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
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = true,
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
            "${3rd}/luv/library",
            -- unpack(vim.api.nvim_get_runtime_file("", true)),
            -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            -- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
        },
      },
    },
  },
  marksman = {},
  -- markdown_oxide = {},

  ols = {},
  omnisharp = {
    filetypes = { "cs", "vb" },
  },
  powershell_es = {
    -- cmd = { "pwsh", "-NoLogo", "-NoProfile", "-Command", "Invoke-EditorServices" },
    filetypes = { "powershell", "ps1", "psm1", "psd1" },
    root_dir = require("lspconfig.util").root_pattern(".git", ".editorconfig", ".gitignore", ".ps1", ".psm1", ".psd1"),
    settings = {
      powershell = {
        codeFormatting = {
          Preset = "OTBS",
        },
      },
      scriptAnalysis = {
        enable = true,
      },
      completion = {
        enable = true,
        useCommandDiscovery = true,
      },
    },
  },
  prismals = {},

  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = require("lspconfig.util").root_pattern(
      ".git",
      "setup.py",
      "setup.cfg",
      "pyproject.toml",
      "requirements.txt",
      "\\.venv",
      "venv"
    ),
    on_attach = vim.lsp.inlay_hint.enable(),
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
  ruff = {
    cmd_env = { RUFF_TRACE = "messages" },
    init_options = {
      settings = {
        logLevel = "error",
      },
    },
    keys = {
      {
        "<Leader>lo",
        LazyVim.lsp.action["source.organizeImports"],
        desc = "Organize Imports",
      },
    },
    filetypes = { "python" },
    ------ most of this is already setup via LazyVim's extra for lang.python
    -- setup = {
    -- [ruff] = function(_, opts)
    -- 	LazyVim.lsp.on_attach(function(client, _)
    -- 		client.server_capabilities.hoverProvider = false
    -- 	end, ruff)
    -- end
    -- }
  },

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
  volar = {},
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
