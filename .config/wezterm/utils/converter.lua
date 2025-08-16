---@class mywez.Converter
---@field init fun(self: mywez.Converter): mywez.Converter
---@field string_to_bool fun(value: string|boolean): boolean
local Converter = {}

---@private
Converter.__index = Converter

--- Takes a string or boolean value and converts it to a boolean.
--- Defaults to false if the value is not a recognized boolean string.
---@param value string|boolean The value to convert.
--- @return boolean The converted boolean value.
function Converter.string_to_bool(value)
	if type(value) == "boolean" then
		return value
	elseif type(value) == "string" then
		value = value:lower()
		if value == "true" or value == "1" then
			return true
		elseif value == "false" or value == "0" then
			return false
		end
	end
	return false -- !!! default to false !!!
end

function Converter:init()
	setmetatable(self, {
		__index = Converter,
	})
	return self
end

-- setmetatable(Converter, Converter)

---@return mywez.Converter
return Converter:init()
