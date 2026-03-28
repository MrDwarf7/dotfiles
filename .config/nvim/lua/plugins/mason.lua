-- local lang_tables = require("lang_tables")

-- NOTE:
-- If we call `opts = {}` in any of the dependencies arrays,
-- we incur a significant startup time increase.
-- I assume this is because lazy.nvim registers all entries in a metatable,
-- and then (even if empty) merges them via vim.tbl_deep_extend when the plugin is loaded.
-- tl;dr: Don't put opts = {} in the dependencies array if you're also setting it up elsewhere.

---@class DapCache
local last_run_bin = {
  c = { location = nil, name = nil },
  cpp = { location = nil, name = nil },
}

local binary_paths = {
  "build/",
  "build/debug/",
  "build/release/",
  "cmake-build/",
  "cmake-build-debug/",
  "cmake-build-release/",
}

local find_binary = function()
  local workspace_root = vim.lsp.buf.list_workspace_folders()[1] or vim.fn.getcwd()
  for _, path in ipairs(binary_paths) do
    local candidate = workspace_root .. "/" .. path .. vim.fn.expand("%:t:r")
    if vim.fn.filereadable(candidate) == 1 then
      dd(candidate)
      return candidate
    end
  end
  return nil
end

local cache_check = function(lang)
  local cache = last_run_bin[lang]
  if cache.location and vim.fn.filereadable(cache.location) == 1 then
    local confirm = vim.fn.confirm("Re-use " .. cache.name .. "?", "&Yes\n&No", 1)
    if confirm == 1 then
      return cache.location
    end
    return nil
  end
  return nil
end

return {
  -- Primary handling of installs and such here,
  --
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    dependencies = {
      { "mason-org/mason.nvim", lazy = true },
      { "mason-org/mason-lspconfig.nvim", lazy = true },
      { "mfussenegger/nvim-dap", lazy = true },
    },

    -- I don't really udnerstand why this works, but it does and helps
    -- with startup time a bit.
    -- init = function()
    --   vim.defer_fn(function() end, 2)
    -- end,

    ---@param _ any : cached deps/metatable etc.
    opts = function(_)
      return {
        ensure_installed = require("lang_tables").mason_all(),
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        de_bounce_hours = 10, -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce. Used only if run_on_start is true.

        -- interop for naming conventions between tools
        integrations = {
          ["mason-lspconfig"] = true,
          ["mason-null-ls"] = true,
          ["mason-nvim-dap"] = true,
        },
      }
    end,
  },

  {
    "mason-org/mason.nvim",
    keys = {
      {
        "<Leader>pm",
        function()
          vim.cmd("Mason")
        end,
        desc = "Mason",
      },
    },
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", lazy = true },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      -- ensure_installed = lang_tables.mason_ensure_installed()
    },
    -- don't do this here as-per the comment at top of file
  },

  {
    "mfussenegger/nvim-dap",
    lazy = true,
    -- opts = {
    --   --
    --   adapters = require("lang_tables").daps_all(),
    -- },
    dependencies = {
      { "rcarriga/nvim-dap-ui", lazy = true },
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      { "mfussenegger/nvim-dap", lazy = true },
      { "nvim-neotest/nvim-nio", lazy = true },
    },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({ reset = true })
        end,
        desc = "DAP UI Toggle",
      },
      -- {
      --   "<leader>db",
      --   function()
      --     require("dap").toggle_breakpoint()
      --   end,
      --   desc = "DAP Toggle Breakpoint",
      -- },
    },
    --
  },

  {
    "julianolf/nvim-dap-lldb",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      -- stylua: ignore start
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP [c]ontinue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP Step [i]nto" },
      { "<leader>do", function() require("dap").step_over() end, desc = "DAP Step [o]ver" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "DAP Step [O]ut" },
      { "<leader>dz", function() require("dap").step_back() end, desc = "DAP Step Back" },
      { "<leader>dB", function() require("dap").clear_breakpoints() end, desc = "DAP Clear [B]reakpoints" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle [b]reakpoint" },
      -- stylua: ignore end
    },
    opts = {
      -- Can omit if you're using mason
      -- codelldb_path = "/path/to/codelldb",
      configurations = {
        -- C lang configurations
        c = {
          {
            name = "Launch Debugger - Make",
            type = "lldb",
            request = "launch",
            cwd = "${workspaceFolder}",
            program = function()
              -- Build with debug symbols
              local out = vim.fn.system({ "make", "debug" })
              if vim.v.shell_error ~= 0 then
                require("utils").output.err("Build failed: " .. out)
                return nil
              end

              -- check cache - ask user if they want to re-use the last binary if it exists and is valid
              -- if last_run_bin.c.location and vim.fn.filereadable(last_run_bin.c.location) == 1 then
              --   local confirm = vim.fn.confirm("Re-use " .. last_run_bin.c.name .. "?", "&Yes\n&No", 1)
              --   if confirm == 1 then
              --     return last_run_bin.c.location
              --   end
              -- end

              local location = cache_check("c")
              if location then
                return location
              end

              -- get the LSP's defined root and find 'build' from there
              local binary = find_binary()

              -- ask user if it's correct - caache it if so
              if binary then
                local confirm = vim.fn.confirm("Launch " .. binary .. "?", "&Yes\n&No", 1)
                if confirm == 1 then
                  last_run_bin.c.location = binary
                  last_run_bin.c.name = vim.fn.expand("%:t:r")
                  return binary
                end
              end

              return nil
              --
            end,
          },
        },
        cpp = {
          {
            name = "Launch Debugger - Meson",
            type = "lldb",
            request = "launch",
            cwd = "${workspaceFolder}",
            program = function()
              local out = vim.fn.system({ "meson", "compile", "-C", "build" })
              if vim.v.shell_error ~= 0 then
                require("utils").output.err("Build failed: " .. out)
                return nil
              end

              local location = cache_check("cpp")
              if location then
                return location
              end

              local binary = find_binary()
              if binary ~= nil then
                local confirm = vim.fn.confirm("Launch " .. binary .. "?", "&Yes\n&No", 1)
                if confirm == 1 then
                  last_run_bin.cpp.location = binary
                  last_run_bin.cpp.name = vim.fn.expand("%:t:r")
                  return binary
                end
              end
              return nil
            end,
          },
        },
      },
    },
  },

  {
    "igorlfs/nvim-dap-view",
    -- let the plugin lazy load itself
    lazy = false,
    keys = {
      -- stylua: ignore start
      { "<leader>dv", function() require("dap-view").toggle() end, desc = "DAP View Toggle" },
      { "<leader>dw", "<CMD>DapViewWatch<CR>", desc = "DAP View Toggle"  },
      -- stylua: ignore end
    },
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      --
    },
  },
}
