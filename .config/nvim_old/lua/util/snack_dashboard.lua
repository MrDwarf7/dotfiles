local M = {}

M.options = function()
	---@class snacks.dashboard.Config
	-----@field enabled? boolean
	-----@field sections snacks.dashboard.Section
	-----@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>

	return {
		enabled = true,
		width = 60,
		row = nil, -- dashboard position. nil for center
		col = nil, -- dashboard position. nil for center
		pane_gap = 4, -- empty columns between vertical panes
		autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
		-- These settings are used by some built-in sections
		preset = {
			-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
			---@type fun(cmd:string, opts:table)|nil
			pick = nil,
			-- Used by the `keys` section to show keymaps.
			-- Set your custom keymaps here.
			-- When using a function, the `items` argument are the default keymaps.
			---@type snacks.dashboard.Item[]
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "w", desc = "Find Words", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				-- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
				{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			-- Used by the `header` section
			header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
		},
		-- item field formatters
		formats = {
			icon = function(item)
				if item.file and item.icon == "file" or item.icon == "directory" then
					return M.icon(item.file, item.icon)
				end
				return { item.icon, width = 2, hl = "icon" }
			end,
			footer = { "%s", align = "center" },
			header = { "%s", align = "center" },
			file = function(item, ctx)
				local fname = vim.fn.fnamemodify(item.file, ":~")
				fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
				if #fname > ctx.width then
					local dir = vim.fn.fnamemodify(fname, ":h")
					local file = vim.fn.fnamemodify(fname, ":t")
					if dir and file then
						file = file:sub(-(ctx.width - #dir - 2))
						fname = dir .. "/…" .. file
					end
				end
				local dir, file = fname:match("^(.*)/(.+)$")
				return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
			end,
		},
		-- sections = {
		-- 	{ section = "header", padding = 6 },
		-- 	{ section = "keys", gap = 1, padding = 4 },
		-- 	{ section = "startup" },
		-- },

		--   1 | 2 | 3
		--
		sections = {

			{
				pane = 3,
				icon = " ",
				desc = "Browse Repo",
				height = 8,
				padding = 14,
				key = "b",
				action = function()
					Snacks.gitbrowse()
				end,
			},
			function()
				local in_git = Snacks.git.get_root() ~= nil
				local cmds = {

					{
						title = "Notifications",
						-- cmd = "gh notify -s -a -n5",
						cmd = "gh status",
						action = function()
							vim.ui.open("https://github.com/notifications")
						end,
						key = "n",
						icon = " ",
						height = 8,
						enabled = true,
						padding = 10,
					},
					{
						title = "Open Issues",
						cmd = "gh issue list -L 3",
						key = "i",
						action = function()
							vim.fn.jobstart("gh issue list --web", { detach = true })
						end,
						icon = " ",
						height = 4,
						padding = 2,
					},
					{
						icon = " ",
						title = "Open PRs",
						cmd = "gh pr list -L 3",
						key = "p",
						action = function()
							vim.fn.jobstart("gh pr list --web", { detach = true })
						end,
						height = 4,
						padding = 2,
					},
					{
						pane = 3,
						icon = " ",
						title = "Git Status",
						cmd = "git --no-pager diff --stat -B -M -C",
						height = 12,
						-- width = 60,
						width = 80,
					},
				}

				return vim.tbl_map(function(cmd)
					return vim.tbl_extend("force", {
						pane = 1,
						section = "terminal",
						enabled = in_git,
						padding = 2,
						ttl = 5 * 60,
						indent = 3,
					}, cmd)
				end, cmds)
			end,

			{ pane = 2, section = "header", padding = 8 },
			{ pane = 2, section = "keys", gap = 1, padding = 8 },
			{ pane = 2, section = "startup" },
		},
	}
end

return M.options()
