---@class mywez.Config: Config
---@field config_dir string
---@field options Config
---@field init fun(self: mywez.Config): mywez.Config
---@field append fun(self: mywez.Config, new_options: mywez.Mod): mywez.Config
local Config = {
	config_dir = "config",
	options = {},
}

---@private
Config.__index = Config

-- Could actually have this as an inner priv func
-- and opt for a load_config() function
-- build a list of all the files that aren't prefixed with a '_' from the /config directory
-- and `"config" .. list[i]` and hand that through to the append func

--- Appends new options to the configuration, logging a warning if a duplicate key is found
function Config:append(config_mod)
	---@type Wezterm
	local wezterm = require('wezterm')
	local validator = require('utils.validator')

	wezterm.log_info('Appending config module: ', config_mod)

	local mod = validator.valid_modules(wezterm,  self.config_dir, config_mod)
	if not mod then
		return self
	end

	-- changing this to ipairs causes it to lock?
	for k, v in pairs(mod) do
		if self.options[k] ~= nil then
			wezterm.log_warn(
				'Duplicate config option detected: ',
				{ old = self.options[k], new = mod[k] }
			)
			goto continue
		end
		self.options[k] = v
		::continue::
	end
	return self
end


-- An (ideally) list-accepting version of append
function Config:yield_to(wezterm, spec_list, struct_field)
	for k, v in pairs(spec_list) do
		if self[struct_field][k] ~= nil then
			wezterm.log_warn(
				'Duplicate config option detected: ',
				{ old = self[struct_field][k], new = spec_list[k] }
			)
			goto continue
		end
		self[struct_field][k] = v
		::continue::
	end
	return self
end


--- Initializes the Config object, setting the metatable to itself (Module level)
function Config:init()
	setmetatable(self, {
		__index = Config,
	})
	return self
end

---@return mywez.Config
return Config:init()

