---@alias LspName string
---@alias ServerConfig table<LspName, any>

---@alias ServerConfigTable table<LspName, ServerConfig>

---@class servers.Servers
---@field ___recurse_max number
---@field __collected table<string, table>
---@field gather fun(dir?: string|nil): servers.Servers
---@field setup fun(opts?: ServerConfigTable|nil): ServerConfigTable
---@field with_autocmd fun(): servers.Servers
local Servers = {
  ___recurse_max = 100,
  __collected = {},
}

-- Servers.__current_dir = vim.fn.stdpath("config") .. "/lua/utils/lsp_servers"
Servers.__current_dir = vim.fn.stdpath("config") .. "/lua/vimpack/servers"

--- Collections LSP config files (tables) in the given dir ( or __current_dir )
--- excluding files that start with '_' or are named 'init.lua'.
---@param dir? string|nil Optional directory to gather server configs from.
---@return servers.Servers
function Servers.gather(dir)
  dir = dir or Servers.__current_dir or vim.fn.getcwd()
  Servers.__current_dir = vim.fs.normalize(dir)

  local errors = {}

  for name, ftype in vim.fs.dir(Servers.__current_dir) do
    if ftype == "file" and name:sub(1, 1) ~= "_" and name ~= "init.lua" then
      local server_name = name:gsub("%.lua$", "")
      local base_path = vim.fn.stdpath("config") .. "/lua/"
      local mod_name = Servers.__current_dir:gsub(base_path, ""):gsub("/", ".") .. "." .. server_name
      -- local mod_name = Servers.__current_dir:gsub(vim.fn.stdpath("config") .. "/lua/", ""):gsub("/", ".")
      --   .. "."
      --   .. name:gsub("%.lua$", "")

      local ok, server_config = pcall(require, mod_name)
      if ok and type(server_config) == "table" then
        if Servers.__collected[server_name] then
          table.insert(errors, string.format("Duplicate LSP server for: %s; overwriting.", server_name))
        end
        Servers.__collected[server_name] = server_config
      else
        table.insert(errors, string.format("Failed to load %s: %s", mod_name, tostring(server_config)))
      end
    end
  end

  -- match the lengths of the table set, and the collected servers

  if #errors > 0 then
    vim.notify(table.concat(errors, "\n"), vim.log.levels.WARN, { title = "LSP Servers" })
  end
  return Servers
end

function Servers.___decr()
  -- peek at the potential next value without consuming it
  if Servers.___recurse_max - 1 <= 0 then
    error("Maximum recursion depth reached in Servers.setup")
  end
  Servers.___recurse_max = Servers.___recurse_max - 1
end

--- Sets up the collected LSP servers
---internally handling gathering if
--- a private field is found to be empty.
---
--- returns the collected server configs.
---
function Servers.setup(opts)
  opts = vim.tbl_deep_extend("force", {}, opts or {})
  opts.dir = opts.dir or Servers.__current_dir

  local collected_len = vim.tbl_count(Servers.__collected)
  -- Servers.__collected_len == 0 then --or type(Servers.__collected_len) == "nil" then
  if collected_len == 0 then
    local ok_decr = pcall(Servers.___decr)
    if not ok_decr then
      return Servers.__collected
    end

    local ok_gather, err = pcall(Servers.gather, opts.dir)
    if not ok_gather then
      vim.notify(
        string.format("Failed to gather LSP servers:\n%s", tostring(err)),
        vim.log.levels.ERROR,
        { title = "LSP Servers" }
      )
      return Servers.__collected -- fallback (empty)
    end

    opts = vim.tbl_deep_extend("force", Servers.__collected, opts or {})
  end

  for server, config in pairs(Servers.__collected) do
    local final = vim.tbl_deep_extend("force", config, opts[server] or {})
    vim.lsp.config(server, config)
  end

	-- vim.print(vim.inspect(Servers))

  return Servers.__collected
end


function Servers.with_autocmd()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("vim_lsp_call", {}),
		callback = function(args)
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

			if client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			end
		end,
	})

	vim.cmd("set completeopt+=noselect")
	return Servers
end

setmetatable(Servers, {
  __call = function(_, ...)
    return Servers.setup(...)
  end,
  __index = function(_, key)
    return Servers.__collected[key]
  end,
})

---@return servers.Servers
return Servers
