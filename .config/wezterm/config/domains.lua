return {
	-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
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
	},
	-- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
	unix_domains = {},

	-- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
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
