---@diagnostic disable: cast-local-type
require("git"):setup()

require("relative-motions"):setup({ only_motions = true })

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
