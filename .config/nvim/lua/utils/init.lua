---@class utils.Utils
---@field arch utils.Arch
-- ---@field autofmt: utils.AutoFmt
---@field bufdel utils.BufDel
---@field converter utils.Converter
---@field list utils.List
---@field output utils.Output
---@field sudo utils.Sudo
---@field tsutils utils.TsUtils
---@field user_commands utils.UserCommands
---@field validation utils.Validation
--- Setup function for utils.Utils module.
---@field setup fun(): utils.Utils
local Utils = {
	arch = {},
	-- autofmt =  nil,
	bufdel = {},
	converter = {},
	list = {},
	output = {},
	sudo = {},
	tsutils = {},
	-- user_commands = {},
	validation = {},
}
-- local Utils = {
-- 	arch = require("utils.arch"),
-- 	-- autofmt =  require("utils.autofmt")
-- 	bufdel = require("utils.bufdel"),
-- 	converter = require("utils.converter"),
-- 	list = require("utils.list"),
-- 	output = require("utils.output"),
-- 	sudo = require("utils.sudo"),
-- 	tsutils = require("utils.tsutils"),
-- 	-- user_commands = require("utils.user_commands"),
-- 	validation = require("utils.validation"),
-- }

local fields_table = {
	["setup"] = true,
	["get"] = true,
	["__fields"] = true,
	["__tostring"] = true,
	["__arch"] = false,
	["__bufdel"] = false,
	["__converter"] = false,
	["__list"] = false,
	["__output"] = false,
	["__sudo"] = false,
	["__tsutils"] = false,
}

Utils.__fields = vim.tbl_filter(function(v)
	return not vim.tbl_contains(vim.tbl_keys(fields_table), v)
end, vim.tbl_keys(Utils))

Utils.__name = "utils.Utils"

--
local has_init_utils = false

function Utils.get(key)
	return Utils[key] or nil
end

local init = function(skip_fields)
	skip_fields = skip_fields or fields_table or nil
	local fields = Utils.__fields
		or vim.tbl_filter(function(v) -- hopefully we don't have to re-compute this though
			return not vim.tbl_contains(vim.tbl_keys(skip_fields), v)
		end, vim.tbl_keys(Utils))

	local field_len = 0

	-- Several closures to remove them from the
	-- hot-loop and hopefully optimize a bit

	---@param v string
	---@return boolean
	local to_skip = function(v)
		return skip_fields[v] or false
	end

	---@param len number
	---@param field any|table
	---@param expected_type string
	---@return boolean
	local use_field = function(len, field, expected_type)
		return len == 0 or type(field) == expected_type
	end

	---@param mod any|table
	---@param expected_type_one string
	---@param field string
	---@param expected_type_two string
	---@return boolean
	local check_module = function(mod, expected_type_one, field, expected_type_two)
		return type(mod) == expected_type_one and type(mod[field]) == expected_type_two
	end

	---@param tbl table
	---@param name string
	---@return table
	local set_child_metatable = function(tbl, name)
		return setmetatable(tbl, {
			__index = tbl,
			__tostring = function()
				return tostring(Utils) .. "." .. name:lower()
			end,
		})
	end

	for key, value in pairs(fields) do
		local field = Utils[value]
		local is_skipped = to_skip(value)

		if is_skipped then
			goto continue
		end

		field_len = table.maxn(field)

		if use_field(field_len, field, "nil") then
			local m = require("utils." .. value:lower())
			if type(m) == "table" and type(m.setup) ~= "function" then
				Utils[value] = m
				Utils[value] = set_child_metatable(Utils[value], value)
				goto continue
			end

			if check_module(m, "table", "setup", "function") then
				Utils[value] = m.setup()
				Utils[value] = set_child_metatable(Utils[value], value)
			end
		end
		::continue::
	end

	return Utils
end

function Utils.setup()
	if has_init_utils then
		return Utils
	end

	-- we want to go through OURSELVES as a table, and
	-- check each key if it's nil,
	-- if nil:
	--  local m = require("utils." .. key:lower())
	--  if m.setup (and is a function) then we call m.setup()
	--  else we can move on (some sub-moduels in utils don't have a setup functions)
	--
	--  We need to AVOID interacting with Utils methods (like this setup function, and
	--  the Utils.get() function), so we can do this by checking if the key
	--  is one of those reserved words first.

	Utils = init(fields_table)
	has_init_utils = true

	return setmetatable(Utils, {
		__fields = Utils.__fields or function()
			return vim.tbl_filter(function(v)
				return not vim.tbl_contains(vim.tbl_keys(fields_table), v)
			end, vim.tbl_keys(Utils))
		end,

		__tostring = function()
			return "utils.Utils"
		end,

		__name = Utils.__name or tostring(Utils) or "utils.Utils",

		__newindex = function(table, key, value)
			rawset(table, key, value)
		end,

		__delindex = function(table, key)
			rawset(table, key, nil)
		end,

		__add = function(a, b)
			return vim.tbl_extend("force", a, b)
		end,

		__arch = function()
			if type(Utils.arch) ~= "nil" then
				return Utils.arch
			else
				Utils.arch = require("utils.arch")
			end
		end,

		__bufdel = function()
			if type(Utils.bufdel) ~= "nil" then
				return Utils.bufdel
			else
				Utils.bufdel = require("utils.bufdel")
			end
		end,

		__converter = function()
			if type(Utils.converter) ~= "nil" then
				return Utils.converter
			else
				Utils.converter = require("utils.converter")
			end
		end,

		__list = function()
			if type(Utils.list) ~= "nil" then
				return Utils.list
			else
				Utils.list = require("utils.list")
			end
		end,

		__output = function()
			if type(Utils.output) ~= "nil" then
				return Utils.output
			else
				Utils.output = require("utils.output")
			end
		end,

		__sudo = function()
			if type(Utils.sudo) ~= "nil" then
				return Utils.sudo
			else
				Utils.sudo = require("utils.sudo")
			end
		end,

		__tsutils = function()
			if type(Utils.tsutils) ~= "nil" then
				return Utils.tsutils
			else
				Utils.tsutils = require("utils.tsutils")
			end
		end,

		-- 		__user_commands = function()
		-- 			if type(Utils.user_commands) ~= "nil" then
		-- 				return Utils.user_commands
		-- 			else
		-- 				Utils.user_commands = require("utils.user_commands")
		-- 			end
		-- 		end,

		__validation = function()
			if type(Utils.validation) ~= "nil" then
				return Utils.validation
			else
				Utils.validation = require("utils.validation")
			end
		end,
	})
end

---@return utils.Utils
-- return Utils.setup()
-- Utils
return Utils.setup()
