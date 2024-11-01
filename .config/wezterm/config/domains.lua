return {
	-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
	ssh_domains = {
		{
			name = "the_yeti",
			remote_address = "the_yeti",
			multiplexing = "WezTerm",
			default_prog = { "powershell.exe", "-NoLogo" },
			-- local_echo_threshold_ms = 15,
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
	},
}
