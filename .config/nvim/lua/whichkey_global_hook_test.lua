---@diagnostic disable: redefined-local
local M = {}

local global_key_wrapper = function(
	leader_key,
	base_layer_show_key,
	name,
	nested_key,
	nested_key_command,
	nested_key_desc
)
	local leader_key = leader_key or "<Leader>"
	local prefix = base_layer_show_key or ""
	local suffix = name or ""
	local nested_key = nested_key or ""
	local nested_key_desc = nested_key_desc or ""
	local nested_key_command = nested_key_command or ""

	local initial_table = {
		-- wk.register({
		[leader_key] = {
			[prefix] = {
				name = suffix,
				[nested_key] = {
					nested_key_command,
					nested_key_desc,
				},
			},
		},
		-- })
	}
	return initial_table
end

M.wk_mappings = function(base_layer_show_key, name, nested_key, nested_key_command, nested_key_desc)
	local wk = require("which-key")
	local leader_key = "<Leader>"

	local initial_table =
		global_key_wrapper(leader_key, base_layer_show_key, name, nested_key, nested_key_command, nested_key_desc)

	return wk.register(initial_table)
end

return M
