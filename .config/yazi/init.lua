---@diagnostic disable: cast-local-type
-- require("git"):setup()

th.git = th.git or {}
th.git_modified = ui.Style():fg("blue")
th.git_deleted = ui.Style():fg("red"):bold()

th.git.modified_sign = "M"
th.git.deleted_sign = "D"
th.git.added_sign = "A"
th.git.untracked_sign = "U"
th.git.updated_sign = "u"

function Linemode:mtime_better()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	else
		time = os.date("%Y-%m-%d %I:%M %p", time)
	end

	return ui.Line(string.format("%s", time))
	--- If you want to also have the file size displayed all the time
	-- local size = self._file:size()
	-- return ui.Line(string.format("%s %s", size and ya.readable_size(size) or "", time))
end

function Linemode:ctime_better()
	local time = math.floor(self._file.cha.created or 0)
	if time == 0 then
		time = ""
	else
		time = os.date("%Y-%m-%d | %I:%M %p", time)
	end

	return ui.Line(string.format("%s", time))
	--- If you want to also have the file size displayed all the time
	-- local size = self._file:size()
	-- return ui.Line(string.format("%s %s", size and ya.readable_size(size) or "", time))
end

-- Show symlink(s) for the hovered item in the status bar (bar at bottom), similar to in the dir listings
Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

-- Show user/group of the hovered item (files) in the status bar
Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	})
end, 500, Status.RIGHT)

-- ---------- PLUGINS ----------

require("mime-ext.local"):setup({
	-- Expand the existing filename database (lowercase), for example:
	with_files = {
		lua = "text/x-lua",
		makefile = "text/makefile",
	},

	-- Expand the existing extension database (lowercase), for example:
	with_exts = {
		lua = "text/x-lua",
	},

	-- If the MIME type is not in both filename and extension databases,
	-- then fallback to Yazi's preset `mime.local` plugin, which uses `file(1)`
	fallback_file1 = false,
})

require("relative-motions"):setup({
	show_numbers = "relative",
	show_motion = true,
	only_motions = false,
})

-- require("duckdb"):setup()

-- TODO: [broken] : mdv-previewer is currently broken (peek method's 'self:show' call is failing).
-- It's disabled here AS WELL as the item(s) in the ./yazi.toml file:
-- ./yazi.toml:201 ( prepend_previewers )
-- --./yazi.toml:267 --- this is actually fine to leave (prepend_preloaders) one

-- require("mdv-previewer"):setup({
-- 	theme = "monokai", -- Option: "terminal" | "solarized-dark" | "nord" | "tokyonight" | "kanagawa" | "gruvbox" | "monokai" | "tokyonight" | " material-ocean" | "catppuccin"
-- 	code_theme = "tokyonight", -- Option: "terminal" | "solarized-dark" | "nord" | "tokyonight" | "kanagawa" | "gruvbox" | "monokai" | "tokyonight" | " material-ocean" | "catppuccin"
-- })

require("sshfs"):setup({
	-- Default:
	-- mount_dir = os.getenv("HOME") .. "/mnt",
	mount_dir = "/mnt",

	-- -- Password authentication attempts before giving up
	-- password_attempts = 3,
	--
	-- -- Default mount point: Go to home, root, or always ask where to go
	-- default_mount_point = "auto", -- home | root | auto
	--
	-- -- Default user selection: Use SSH config user or prompt for choice
	-- default_user = "auto", -- auto | prompt

	-- -- SSHFS mount options (array of strings)
	-- -- These options are passed directly to the sshfs command
	-- sshfs_options = {
	--   "reconnect",                      -- Auto-reconnect on connection loss
	--   "ConnectTimeout=5",               -- Connection timeout in seconds
	--   "compression=yes",                -- Enable compression
	--   "ServerAliveInterval=15",         -- Keep-alive interval (15s × 3 = 45s timeout)
	--   "ServerAliveCountMax=3",          -- Keep-alive message count
	--   -- "dir_cache=yes",               -- Enable directory caching (default: yes)
	--   -- "dcache_timeout=300",          -- Cache timeout in seconds
	--   -- "dcache_max_size=10000",       -- Max cache size
	--   -- "allow_other",                 -- Allow other users to access mount
	--   -- "uid=1000,gid=1000",           -- Set file ownership
	--   -- "follow_symlinks",             -- Follow symbolic links
	-- },

	-- standard/reliable
	sshfs_options = {
		"reconnect",
		"ServerAliveInterval=15",
		"ServerAliveCountMax=3",
	},

	-- Performance optimized
	-- sshfs_options = {
	--   "reconnect",
	--   "compression=yes",
	--   "cache_timeout=300",
	--   "ConnectTimeout=10",
	--   "dir_cache=yes",
	--   "dcache_timeout=600",
	-- },

	-- Multi-user access
	-- sshfs_options = {
	--   "reconnect",
	--   "allow_other",
	--   "uid=1000,gid=1000",
	--   "umask=022",
	--   "ServerAliveInterval=30",
	-- },

	-- -- Picker UI settings
	-- ui = {
	-- 	-- Maximum number of items to show in the menu picker.
	-- 	-- If the list exceeds this number, a different picker (like fzf) is used.
	-- 	menu_max = 15, -- Recommended: 10–20. Max: 36.
	--
	-- 	-- Picker strategy:
	-- 	-- "auto": uses menu if items <= menu_max, otherwise fzf (if available) or a filterable list
	-- 	-- "fzf": always use fzf if available, otherwise fallback to a filterable list
	-- 	picker = "auto", -- "auto" | "fzf"
	-- },
})
