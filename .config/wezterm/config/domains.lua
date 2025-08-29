---@class mywez.Domains
---@field ssh_domains SshDomain[]
---@field unix_domains UnixDomain[]
---@field wsl_domains WslDomain[]

---@return mywez.Domains
return {
	-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
	---@type SshDomain
	ssh_domains = {
		{
			name = "the_yeti",
			remote_address = "the_yeti",
			multiplexing = "WezTerm",
			default_prog = { "pwsh.exe", "-NoLogo" },
			-- local_echo_threshold_ms = 15,
		},
		{
			name = "nixbook",
			remote_address = "nixbook",
			multiplexing = "WezTerm",
			default_prog = { "fish", "-l" },
		},
		{
			name = "manbook",
			remote_address = "manbook",
			multiplexing = "WezTerm",
			local_echo_threshold_ms = 130,
			-- overlay_lag_indicator = true,
			default_prog = { "fish", "-l" },
		},
	},
	-- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
	---@type UnixDomain
	unix_domains = {},

	-- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
	---@type WslDomain
	wsl_domains = {
		{
			name = "WSL:Arch",
			distribution = "Arch",
			username = "dwarf",
			default_cwd = "/home/dwarf",
			-- default_prog = { "fish", "-l" },
		},
		{
			name = "WSL:NixOS",
			distribution = "NixOS",
			username = "dwarf",
			default_cwd = "/home/dwarf",
		},
	},
}
