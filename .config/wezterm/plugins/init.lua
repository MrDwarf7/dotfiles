-- TODO: proper types

---@alias mywez.SpecConfig table<string, any>

---@class mywez.PluginSpec
---@field name string
---@field url string
---@field enabled boolean? -- Can also be a string - we will handle this as boolean
---@field config mywez.SpecConfig

---@class mywez.PluginManager: Wezterm.Plugin
---@field plugin_dir string
---@field specs mywez.PluginSpec[]
---@field loaded_plugins table
---@field initialized boolean
local PluginManager = {
	plugin_dir = "plugins",
	specs = {}, -- BUG: Pretty sure it's defering to the empty table
	loaded_plugins = {},
	initialized = false,
}

---@type mywez.Debug
local dbg = require("utils.debug")

--- Locates individual spec files in the directory.
---
---@private
---@param spec_dir string The directory to search for plugin specs.
---@param skip_init boolean? If true, skips the init.lua file.
---@return table<string, mywez.PluginSpec>
local function module_list(spec_dir, skip_init)
	local found_sepcs = {}
	local wezterm = require("wezterm") ---@type Wezterm

	---@type mywez.Validator
	local Validator = require("utils.validator")

	if skip_init == nil or skip_init == true then
		skip_init = true
	end

	spec_dir = string.format("%s", table.concat(Validator.path_segment(spec_dir, false, true), "/"))

	local files = wezterm.glob(wezterm.config_dir .. "/" .. spec_dir .. "/*.lua")

	wezterm.log_info("Found " .. #files .. " files in " .. spec_dir)

	for i, file_path in ipairs(files) do
		local filename = file_path:match("([^/\\]+)$")

		-- skip the init.lua file
		if skip_init and filename:match("init%.lua$") then
			files[i] = ""
			goto continue
		end

		-- "bar.lua" -> "bar"
		if not filename:match("^_") then
			local module_name = filename:match("(.+)%.lua$")
			wezterm.log_info("Found module: " .. module_name)

			if module_name then
				wezterm.log_info("Loading module: " .. module_name)
				local require_path = spec_dir .. "." .. module_name
				wezterm.log_info("Requiring module: " .. require_path)
				require_path = require_path:gsub("^/+", "") -- remove leading slashes
				wezterm.log_info("Final require path: " .. require_path)

				found_sepcs[module_name] = require(require_path)
				wezterm.log_info("Loaded spec: " .. found_sepcs[module_name].name)
			end
		end

		::continue::
	end

	local c = 0
	for k, v in pairs(found_sepcs) do
		c = c + 1
		wezterm.log_info("Found spec: " .. k .. " with name: " .. (v.name or "nil"))
	end
	wezterm.log_info("Total specs found: " .. c)

	-- dbg.recursive_print(found_sepcs, 2, {}, 24)

	return found_sepcs
end

function PluginManager:discover_specs()
	if type(self.plugin_dir) == "nil" then
		self.plugin_dir = "plugins"
	end

	if not self.plugin_dir then
		self.plugin_dir = "plugins"
	end

	if self.initialized then
		return self
	end

	---@type mywez.Validator
	local validator = require("utils.validator")
	local wezterm = require("wezterm") ---@type Wezterm

	local modules = module_list(self.plugin_dir)

	-- dbg.recursive_print(modules, 2, {}, 24)

	-- TODO: Bro... Why is this not loading them???????????????????????????????????????????

	local plugin_files = validator.valid_modules(wezterm, self.plugin_dir, modules)
	if not plugin_files then
		wezterm.log_error("No valid plugin files found in " .. self.plugin_dir)
		return PluginManager
	end

	-- for k, v in pairs(plugin_files) do
	-- wezterm.log_info("222222 Found plugin file: " .. k .. " with spec: " .. (v.name or "nil"))
	-- end

	for _, plugin_file in ipairs(plugin_files) do
		wezterm.log_info("Loading plugin spec from " .. plugin_file)
		-- BUG: v   this literally never fires?? Neither does the else statement?? (see bug note at top)
		local success, spec = pcall(require, plugin_file)
		if success and spec then
			-- wezterm.log_warn("33333333 VALUE: " .. (spec.name or "nil"))
			table.insert(PluginManager.specs, spec)
		else
			---@type Wezterm
			wezterm.log_error("Failed to load plugin spec from " .. plugin_file .. ": " .. (spec or "unknown error"))
		end
	end

	self.initialized = true
	return self
end

--- Applies the loaded plugin specs to the given configuration.
---@param wezterm Wezterm The wezterm module.
---@param config Config|mywez.Config The configuration to apply the plugins to.
---@return mywez.PluginManager
function PluginManager:apply_to_config(wezterm, config)
	self:discover_specs()

	---@type mywez.Converter
	local Converter = require("utils.converter")

	for _, spec in ipairs(self.specs) do
		spec.enabled = Converter.string_to_bool(spec.enabled)
		if spec.enabled == false then
			wezterm.log_info("Skipping disabled plugin: " .. spec.name)
			goto continue
		end

		if spec.url then
			local plugin = wezterm.plugin.require(spec.url)
			self.loaded_plugins[spec.name] = plugin

			if plugin.apply_to_config or (spec.enabled == true) then
				plugin.apply_to_config(config, spec.config or {})
			end
		end
		::continue::
	end
	return self
end

function PluginManager:init()
	local wezterm = require("wezterm") ---@type Wezterm
	-- Set the plugin directory to the default plugins directory

	setmetatable(self, {
		__index = PluginManager,
		__call = function(_, ...)
			return PluginManager.apply_to_config(PluginManager, wezterm, ...)
		end,
	})
	return self
end

-- We auto-init the disovery of specs on require("plugins") call
-- PluginManager:discover_specs()

return PluginManager:init()
