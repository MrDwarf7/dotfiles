-- TODO: remove unnecessary file in AstroNvim v4
return function(_, opts)
	local mason_nvim_dap = require("mason-nvim-dap")

	-- config = function(opts)
	--       local path = "~/dotfiles/.virtualenvs/debugpy/Scripts"
	--     end,
	mason_nvim_dap.setup(opts)
end
