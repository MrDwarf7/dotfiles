local M = {}

--- Open a URL under the cursor with the current operating system
---@param path string The path of the file to open with the system opener
function M.system_open(path)
	-- TODO: REMOVE WHEN DROPPING NEOVIM <0.10
	if vim.ui.open then
		return vim.ui.open(path)
	end
	local cmd
	if vim.fn.has('win32') == 1 and vim.fn.executable('explorer') == 1 then
		cmd = { 'cmd.exe', '/K', 'explorer' }
	elseif vim.fn.has('unix') == 1 and vim.fn.executable('xdg-open') == 1 then
		cmd = { 'xdg-open' }
	elseif (vim.fn.has('mac') == 1 or vim.fn.has('unix') == 1) and vim.fn.executable('open') == 1 then
		cmd = { 'open' }
	end
	if not cmd then
		M.notify('Available system opening tool not found!', vim.log.levels.ERROR)
	end
	vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand('<cfile>') }), { detach = true })
end

--- regex used for matching a valid URL/URI string
M.url_matcher =
	'\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+'

--- Delete the syntax matching rules for URLs/URIs if set
function M.delete_url_match()
	for _, match in ipairs(vim.fn.getmatches()) do
		if match.group == 'HighlightURL' then
			vim.fn.matchdelete(match.id)
		end
	end
end

--- Add syntax matching rules for highlighting URLs/URIs
function M.set_url_match()
	M.delete_url_match()
	if vim.g.highlighturl_enabled then
		vim.fn.matchadd('HighlightURL', M.url_matcher, 15)
	end
end

return M
