---@alias mywez.WeztermGPUBackend 'Vulkan'|'Metal'|'Gl'|'Dx12'
---@alias mywez.WeztermGPUDeviceType 'DiscreteGpu'|'IntegratedGpu'|'Cpu'|'Other'
---@alias mywez.AdapterMap { [mywez.WeztermGPUBackend]: GpuInfo? }?

---@class mywez.GpuAdapters
---@field __backends mywez.WeztermGPUBackend[]
---@field __preferred_backend mywez.WeztermGPUBackend
---@field __preferred_device_type mywez.WeztermGPUDeviceType
---@field DiscreteGpu mywez.AdapterMap
---@field IntegratedGpu mywez.AdapterMap
---@field Cpu mywez.AdapterMap
---@field Other mywez.AdapterMap
---@field ENUMERATED_GPUS GpuInfo[]
---@field AVAILABLE_BACKENDS table<string, mywez.WeztermGPUBackend[]>
---@field init fun(): mywez.GpuAdapters
---@field pick_best fun(): GpuInfo?
---@field pick_manual fun(backend: mywez.WeztermGPUBackend, device_type: mywez.WeztermGPUDeviceType): GpuInfo?
local GpuAdapters = {
	DiscreteGpu = nil,
	IntegratedGpu = nil,
	Cpu = nil,
	Other = nil,
	AVAILABLE_BACKENDS = {
		mac = { "Metal" },
		windows = { "Dx12", "Vulkan", "Gl" },
		linux = { "Vulkan", "Gl" },
	},
	ENUMERATED_GPUS = require("wezterm").gui.enumerate_gpus(),
	__backends = nil, -- set in init()
	__preferred_backend = nil, -- set in init()
}

----@private
-- GpuAdapters.__index = GpuAdapters

--- Will pick the best adapter based on the following criteria:
---    1. Best GPU available (Discrete > Integrated > Other (for wgpu's OpenGl implementation on Discrete GPU) > Cpu)
---    2. Best graphics API available (based off my very scientific scroll a big log file in neovim test 😁)
---
--- Graphics API choices are based on the platform:
---    - Windows: Dx12 > Vulkan > OpenGl
---    - Linux: Vulkan > OpenGl
---    - Mac: Metal
--- @see mywez.GpuAdapters.AVAILABLE_BACKENDS
---
--- If the best adapter combo is not found, it will return `nil` and lets Wezterm decide the best adapter.
---
--- Please note these are my own personal preferences and may not be the best for your system.
--- If you want to manually choose the adapter, use `GpuAdapters:pick_manual(backend, device_type)`
--- Or feel free to re-arrange `GpuAdapters.AVAILABLE_BACKENDS` to you liking
GpuAdapters.pick_best = function()
	local gpu = GpuAdapters
	local adapters_options = gpu.DiscreteGpu
	local preferred_backend = gpu.__preferred_backend

	------@type Wezterm
	---local wezterm = require("wezterm")

	if not adapters_options then
		adapters_options = gpu.IntegratedGpu
	end

	if not adapters_options then
		adapters_options = gpu.Other
		preferred_backend = "Gl"
	end

	if not adapters_options then
		adapters_options = gpu.Cpu
	end

	if not adapters_options then
		---@type Wezterm
		local wezterm = require("wezterm")
		wezterm.log_error("No GPU adapters found. Using Default Adapter.")
		return nil
	end

	local adapter_choice = adapters_options[preferred_backend]
	-- wezterm.log_info("Preferred Backend: ", preferred_backend)
	-- wezterm.log_info("Adapter Choice: ", adapter_choice)

	if not adapter_choice then
		---@type Wezterm
		local wezterm = require("wezterm")
		wezterm.log_error("Preferred backend not available. Using Default Adapter.")
		return nil
	end

	return adapter_choice
end

--- Manually pick the adapter based on the backend and device type.
--- If the adapter is not found, it will return nil and lets Wezterm decide the best adapter.
GpuAdapters.pick_manual = function(backend, device_type)
	---@type mywez.GpuAdapters
	local gpu = GpuAdapters
	local adapters_options = gpu[device_type]

	if not adapters_options then
		---@type Wezterm
		local wezterm = require("wezterm")
		wezterm.log_error("No GPU adapters found. Using Default Adapter.")
		return nil
	end

	local adapter_choice = adapters_options[backend]

	if not adapter_choice then
		---@type Wezterm
		local wezterm = require("wezterm")
		wezterm.log_error("Preferred backend not available. Using Default Adapter.")
		return nil
	end

	return adapter_choice
end

GpuAdapters.init = function()
	---@type mywez.Platform
	local Platform = require("utils.platform")

	---@class mywez.GpuAdapters
	local gpu = GpuAdapters

	-- ---@type Wezterm
	-- local wezterm = require("wezterm")
	-- wezterm.log_info("Enumerated GPUs: ", gpu.ENUMERATED_GPUS)
	-- wezterm.log_info("Available Backends: ", gpu.AVAILABLE_BACKENDS)
	-- wezterm.log_info("Current Platform: ", Platform.os)

	gpu.__backends = gpu.AVAILABLE_BACKENDS[Platform.os]
	gpu.__preferred_backend = gpu.AVAILABLE_BACKENDS[Platform.os][1]

	-- iterate over the enumerated GPUs and create a lookup table (`mywez.AdapterMap`)
	for _, adapter in ipairs(gpu.ENUMERATED_GPUS) do
		if not gpu[adapter.device_type] then
			gpu[adapter.device_type] = {}
		end
		gpu[adapter.device_type][adapter.backend] = adapter ---@type GpuInfo
	end

	------@type mywez.Debug
	---local Debug = require("utils.debug")
	-- Debug.recursive_print(self, 2, {}, 24)
	-- setmetatable(gpu, GpuAdapters)

	setmetatable(gpu, GpuAdapters)

	return gpu
end

---@return mywez.GpuAdapters
return GpuAdapters.init()
