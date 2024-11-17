---@diagnostic disable: cast-local-type
require("git"):setup()

require("relative-motions"):setup({ only_motions = true })

-- THEME.git_modified = ui.Style():fg("blue")
-- THEME.git_deleted = ui.Style():fg("red"):bold()

function Linemode:mtime_better()
	local time = math.floor(self._file.cha.modified or 0)
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
