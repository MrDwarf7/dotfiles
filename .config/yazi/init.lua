---@diagnostic disable: cast-local-type
require("git"):setup()

-- require("starship"):setup({
-- 	hide_flags = false,
-- 	flags_after_prompt = true,
-- 	config_file = "~\\dotfiles\\.config\\starship\\starship_yazi.toml", -- Slightly altered version to deal with Yazi's spacing at top of panel
-- })

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
