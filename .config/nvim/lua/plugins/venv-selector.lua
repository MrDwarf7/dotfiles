---@param env string
---@param rem string
---@return void
local set_validator = function(env, rem)
	local validation = require("utils.validation")
	-- _G.dump({
	-- 	cache_path = v
	-- })
	return validation.expand_create_file("venv-selector", env, rem)
end

---@type LazyPluginBase
return {
	"linux-cultist/venv-selector.nvim",
	-- disabled = true,
	disabled = false,
	lazy = true,
	ft = { "python" },
	-- branch = "regexp", -- This is the regexp branch, use this for the new version
	dependencies = {
		{ "neovim/nvim-lspconfig", lazy = true },
		{ "mfussenegger/nvim-dap", lazy = true },
		{ "mfussenegger/nvim-dap-python", lazy = true }, --optional
		{ "ibhagwan/fzf-lua", lazy = true },
		-- {
		-- 	"nvim-telescope/telescope.nvim",
		-- 	branch = "0.1.x",
		-- 	dependencies = { "nvim-lua/plenary.nvim", lazy = true },
		-- 	lazy = true,
		-- },
	},
	---@type LazyKeys
	keys = {
		{ "<Leader>lv", "<cmd>VenvSelect<cr>" },
		{ "<Leader>fv", "<cmd>VenvSelect<cr>" },
	},
	opts = {
		search = {
			my_venvs = {
				command = "fd -Lua python$" .. vim.uv.cwd(),
			},
		},

		options = {
			debug = true,
			enable_cached_venvs = true,
			set_environment_variables = true,
			notify_user_on_venv_activation = true,
			picker = "auto", -- default. Options are: "telescope", "fzf-lua", "snacks", "native", "mini-pick" or "auto"
		},

		cache = {
			file = set_validator("XDG_CACHE_HOME", "/venv-selector/venvs2.json"),
		},
	},
}
