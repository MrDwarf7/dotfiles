local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
--[[ local cmd = vim.api.nvim_create_user_command ]]
--[[ local namespace = vim.api.nvim_create_namespace ]]

local utils = require('config.utils')

local M = {}

--[[ vim.on_key(function(char) ]]
--[[   if vim.fn.mode() == "n" then ]]
--[[     local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char)) ]]
--[[     if vim.opt.hlsearch:get() ~= new_hlsearch then ]]
--[[       vim.opt.hlsearch = new_hlsearch ]]
--[[     end ]]
--[[   end ]]
--[[ end, namespace("auto_hlsearch")) ]]

local bufferline_group = augroup('bufferline', { clear = true })
autocmd({ 'BufAdd', 'BufEnter', 'TabNewEntered' }, {
	desc = 'Update buffers when adding new buffers',
	group = bufferline_group,
	callback = function(args)
		local buf_utils = require('config.utils.buffer')
		if not vim.t.bufs then
			vim.t.bufs = {}
		end
		if not buf_utils.is_valid(args.buf) then
			return
		end
		if args.buf ~= buf_utils.current_buf then
			buf_utils.last_buf = buf_utils.is_valid(buf_utils.current_buf) and buf_utils.current_buf or nil
			buf_utils.current_buf = args.buf
		end
		local bufs = vim.t.bufs
		if not vim.tbl_contains(bufs, args.buf) then
			table.insert(bufs, args.buf)
			vim.t.bufs = bufs
		end
		vim.t.bufs = vim.tbl_filter(buf_utils.is_valid, vim.t.bufs)
	end,
})

--[[ autocmd("BufDelete", { ]]
--[[   desc = "Update buffers when deleting buffers", ]]
--[[   group = bufferline_group, ]]
--[[   callback = function(args) ]]
--[[     local removed ]]
--[[     for _, tab in ipairs(vim.api.nvim_list_tabpages()) do ]]
--[[       local bufs = vim.t[tab].bufs ]]
--[[       if bufs then ]]
--[[         for i, bufnr in ipairs(bufs) do ]]
--[[           if bufnr == args.buf then ]]
--[[             removed = true ]]
--[[             table.remove(bufs, i) ]]
--[[             vim.t[tab].bufs = bufs ]]
--[[             break ]]
--[[           end ]]
--[[         end ]]
--[[       end ]]
--[[     end ]]
--[[     vim.t.bufs = vim.tbl_filter(require("config.utils.buffer").is_valid, vim.t.bufs) ]]
--[[     if removed == 1 then ]]
--[[ 			vim.api.nvim_buf_delete(buf, { force = true }) ]]
--[[     end ]]
--[[     vim.cmd.redrawtabline() ]]
--[[   end, ]]
--[[ }) ]]

autocmd({ 'VimEnter', 'FileType', 'BufEnter', 'WinEnter' }, {
	desc = 'URL Highlighting',
	group = augroup('highlighturl', { clear = true }),
	callback = function()
		utils.set_url_match()
	end,
})

autocmd('BufWinEnter', {
	desc = 'Make q close help, man, quickfix, dap floats',
	group = augroup('q_close_windows', { clear = true }),
	callback = function(args)
		local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf })
		if vim.tbl_contains({ 'help', 'nofile', 'quickfix' }, buftype) and vim.fn.maparg('q', 'n') == '' then
			vim.keymap.set('n', 'q', '<cmd>close<cr>', {
				desc = 'Close window',
				buffer = args.buf,
				silent = true,
				nowait = true,
			})
		end
	end,
})

--- Close a given buffer (fancy way of basically just killing the empty buffer that stays spawned but hidden when closing all windows)
---@param bufnr? number The buffer to close or the current buffer if not provided
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close(bufnr, force)
	if not bufnr or bufnr == 0 then
		bufnr = vim.api.nvim_get_current_buf()
	end
	if M.is_valid(bufnr) and #vim.t.bufs > 1 then
		if not force and vim.api.nvim_get_option_value('modified', { buf = bufnr }) then
			local bufname = vim.fn.expand('%')
			local empty = bufname == ''
			if empty or 'buftype' == 'Neotree' or 'neotree' or 'neo-tree' then
				bufname = 'Untitled'
			end
			local confirm = vim.fn.confirm(('Save changes to "%s"?'):format(bufname), '&Yes\n&No\n&Cancel', 1, 'Question')
			if confirm == 1 then
				if empty then
					return
				end
				vim.cmd.write()
			elseif confirm == 2 then
				force = true
			else
				return
			end
		end
		require('mini.bufremove').delete()
	else
		local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
		vim.cmd(('silent! %s %d'):format((force or buftype == 'terminal') and 'bdelete!' or 'confirm bdelete', bufnr))
	end
end

local lsp_utils = require('config.utils.lsp-utils')

function M.lsp_hovering_autocmd()
	local lsp_utils_group = augroup('lsp_utils_group', { clear = true })

	autocmd({
		'CursorHold',
		'CursorHoldI',
		lsp_utils({
			desc = 'Show hover information',
			group = lsp_utils_group,
		}),
		M.lsp_utils.code_action_listener(),
	})
end

return M
