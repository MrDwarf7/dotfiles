local M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
}
function M.config()
  local dap, dapui = require("dap")
	require("dap-python")
	require("mason-nvim-dap").setup()

  vim.fn.sign_define('DapBreakpoint', {text='', texthl='error', linehl='', numhl=''})
  -- ADAPTERS
  dap.adapters.node2 = {
    type = 'executable',
    command = 'node-debug2-adapter',
    -- args = {os.getenv('HOME') .. '/.zinit/plugins/microsoft---vscode-node-debug2.git/out/src/nodeDebug.js'},
    -- args =  { vim.fn.stdpath('data') .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
    args = {},
  }

  dap.configurations.javascript = {
    {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      restart = true,
      -- port = 9229
      processId = require'dap.utils'.pick_process,
    },
  }
  dap.adapters.ruby = {
    type = 'executable';
    command = 'bundle';
    args = {'exec', 'readapt', 'stdio'};
  }

  dap.configurations.ruby = {
    {
      type = 'ruby';
      request = 'launch';
      name = 'Rails';
      program = 'bundle';
      programArgs = {'exec', 'rails', 's'};
      useBundler = true;
    },
  }

	dap.adapters.python = {
    type = 'executable',
    --[[ command = dap.python.resolve_python(), ]]
		--[[ command = 'python -m debugpy.adapter', ]]
    command = 'python3',
    args = { '-m', 'debugpy' },
  }

  dap.configurations.python = {
    {
			type = 'python',
			request = 'launch',
      name = 'Launch file',
			program = '${file}',
			--[[ pythonPath = function() ]]
			--[[ 	local venv = vim.fn.getcwd() ]]
			--[[ 	local ac_venv = vim.fn.glob(venv .. '/.venv/scripts/activate.ps1') ]]
			--[[ 	return ac_venv ]]
			--[[ end, ]]

			args = { '--listen', 'localhost:5678', '--wait-for-client'},
      cwd = vim.fn.getcwd(),
      --[[ sourceMaps = true, ]]
      console = 'ExternalTerminal',

    },
	}

end
return M
