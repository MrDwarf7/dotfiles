---@type LazyPluginBase
return {
	"Civitasv/cmake-tools.nvim",
	lazy = true,
	ft = { "cmake", "cpp", "h", "hpp" },
	-- previously
	-- init = function()
	config = function(_)
		local loaded = false
		local function check()
			local cwd = vim.uv.cwd()
			if vim.fn.filereadable(cwd .. "/CmakeLists.txt") == 1 then
				---@type ManagerOpts
				require("lazy").load({ plugins = "cmake-tools.nvim" })
				loaded = true
			end
		end
		check()
		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function()
				if not loaded then
					check()
				end
			end,
		})
	end,
}
