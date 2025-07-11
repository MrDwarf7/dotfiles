---@diagnostic disable: undefined-global
return {
  {
    "nvim-lspconfig",
    lazy = true,
		-- event = "VeryLazy",
		-- stylua: ignore start
		opts = function(opts)
			local keys = require("lazyvim.plugins.lsp.keymaps").get()

			local lsp_servers = require("utils.lsp_servers")

			-- Remove
			keys[#keys + 1] = { "<leader>cR", false }
			keys[#keys + 1] = { "<c-k>", false }
			keys[#keys + 1] = { "<Leader>ca", false }
			keys[#keys + 1] = { "<Leader>cA", false }
			keys[#keys + 1] = { "<Leader>cc", false }
			keys[#keys + 1] = { "<Leader>cC", false }
			keys[#keys + 1] = { "<Leader>cl", false }
			keys[#keys + 1] = { "<Leader>cr", false }


			keys[#keys + 1] = { "<Leader>l<S-i>", "<CMD>LspInfo<CR>", desc = "Lsp Info" }
			--  gd
			--  gr
			--  gI
			keys[#keys + 1] = { "gt", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" }
			keys[#keys + 1] = { "<leader>la", vim.lsp.buf.code_action, desc = "Lsp Action", mode = { "n", "v" }, has = "codeAction" }
			keys[#keys + 1] = { "<leader>lc", vim.lsp.codelens.run, desc = "CodeLens", mode = { "n", "v" }, has = "codeLens" }
			keys[#keys + 1] = { "<leader>lC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" }
			keys[#keys + 1] = { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
			keys[#keys + 1] = { "<Leader>lh", vim.diagnostic.open_float, desc = "float" }

			-- stylua: ignore end

			local ret = {
				-- options for vim.diagnostic.config()
				---@type vim.diagnostic.Opts
				diagnostics = {
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
						-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
						-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
						-- prefix = "icons",
					},
					underline = true,
					severity_sort = true,
					update_in_insert = false,
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
							[vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
							[vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
							[vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
						},
					},
				},
				-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the inlay hints.
				inlay_hints = {
					enabled = true,
					exclude = { }, -- filetypes for which you don't want to enable inlay hints
				},
				-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the code lenses.
				codelens = {
					enabled = false,
				},
				-- add any global capabilities here
				capabilities = {
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				},
				-- options for vim.lsp.buf.format
				-- `bufnr` and `filter` is handled by the LazyVim formatter,
				-- but can be also overridden when specified
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
				-- LSP Server Settings
				servers = vim.tbl_deep_extend("force", lsp_servers.servers, opts.servers or {}),
				-- you can do any additional lsp server setup here
				-- return true if you don't want this server to be setup with lspconfig
				setup = {
					-- example to setup with typescript.nvim
					-- tsserver = function(_, opts)
					--   require("typescript").setup({ server = opts })
					--   return true
					-- end,
					-- Specify * to use this function as a fallback for any server
					-- ["*"] = function(server, opts) end,
				},
			}
			return ret
		end,
  },
  {
    "rustaceanvim",
    opts = function(opts)
      local insert_opts = {
        tools = {
          float_win_config = {
            -- DOC BORDER
            border = "single",
            -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            highlight = "Normal",
          },
          hover_actions = {
            auto_focus = true,
          },
          inlay_hints = {
            autoSetHints = true,
            auto = true,
            highlight = "NonText",
          },
        },

        server = {
          on_attach = function(_, bufnr)
            vim.keymap.del("n", "<Leader>cR")

            vim.keymap.set("n", "<Leader>la", function()
              vim.cmd.RustLsp("codeAction")
            end, { desc = "[a]ction", buffer = bufnr })

            vim.keymap.set("n", "<Leader>dd", function()
              vim.cmd.RustLsp("debuggables")
            end, { desc = "[d]ebuggables", buffer = bufnr })

            vim.keymap.set("n", "<Leader>lc", function()
              vim.cmd.RustLsp("flyCheck")
            end, { desc = "[c]heck" })

            vim.keymap.set("n", "<Leader>dr", function()
              vim.cmd.RustLsp("runnables")
            end, { desc = "[r]un" })

            -- vim.lsp.inlay_hint.enable()
          end,

          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust.
              checkOnSave = true,
              diagnostics = {
                enable = diagnostics == "rust-analyzer",
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              files = {
                excludeDirs = {
                  ".direnv",
                  ".git",
                  ".github",
                  ".gitlab",
                  "bin",
                  "node_modules",
                  "target",
                  "venv",
                  ".venv",
                },
              },

              inlay_hints = {
                align = true,
                bindingHints = true,
                chainingHints = true,
                closingBraceHints = true,
                closureCaptureHints = true,
                closureReturnTypeHints = true,
                closureStyle = "rust_analyzer",
                discriminationHints = true,
                expressionAdjustmentHints = true,
                highlight = "Comment",
                implicitDrops = true,
                lifetimeEllisionHints = {
                  enable = true,
                  useParamaterNames = true,
                },
                -- lifetimeEllisionHints = true,
                maxLength = 120,
                mutableBorrowHints = true,
                parameterHints = {
                  enable = true,
                },
                -- parameterHints = true,
                prefix = " » ",
                rangeExclusiveHints = {
                  enable = true,
                },
                typeHints = true,
              },
            },
          },
        },

        dap = {
          adapter = {
            command = "lldb-vscode",
            name = "lldb",
            type = "executable",
          },
          configuration = {
            args = {},
            cwd = vim.fn.getcwd(),
            env = {},
            externalConsole = false,
            MIMode = "gdb",
            name = "lldb",
            program = "${file}",
            request = "launch",
            stopOnEntry = true,
            type = "lldb",
            setupCommands = {
              {
                description = "Enable pretty-printing for gdb",
                ignoreFailures = true,
                text = "-enable-pretty-printing",
              },
            },
            sourceLanguages = { "rust" },
          },
        },
      }

      table.insert(opts, insert_opts)
    end,
  },
  {
    "Airbus5717/c3.vim",
    ft = { "c3", "c3c" },
  },
}
