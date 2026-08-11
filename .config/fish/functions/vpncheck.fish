#!/usr/bin/env fish
#

function __vpncheck_help
    printf "vpncheck: Check if the VPN is working and show the current IP address and DNS servers

    Usage:
    vpncheck

    Options:
    -h, --help  Show this help message and exit\n"
    return 0
end

function check_deps
    # This function checks if the required dependencies are installed.
    #
    # System Dependencies:
    #   wireguard-tools
    #   openresolv
    set -l deps bat curl wireguard-tools openresolv

    for dep in $deps
        if not 00-valid_pacman $dep
            colorize red "Error: %s is not installed. Please install %s and try again.\n" "$dep" "$dep"
            return 1
        end
    end
end

function vpncheck --description "Check if the VPN is working and show the current IP address and DNS servers"
    argparse h/help -- $argv
    or begin
        colorize red "Error: Invalid arguments. Use 'vpncheck -h' for help.\n"; and __vpncheck_help; and return 1
    end
    set -q _flag_help; and __vpncheck_help && return 0

    check_deps || return $status

    sudo true
    colorize green ">Checking DNS servers...\n"
    command bat /etc/resolvconf.conf /etc/resolv.conf

    colorize green ">Checking ip route...\n"
    command ip route get 8.8.8.8

    colorize green ">Checking WireGuard status...\n"
    command sudo wg show

    colorize green ">Checking public IP address...\n"
    set curl_output $(curl --suppress-connect-headers -4 ifconfig.me 2>/dev/null)
    printf "%s\n" "$curl_output"

    printf "
If any of the above failed (or didn't produce output)
you can run one of the below commands to bring it up.
The first one is for wg-quick, the second is via vortix

- sudo wg-quick up wg0
- sudo vortix\n"

    return 0
end

# ip route get 8.8.8.8 && curl -4 ifconfig.me && b /etc/resolvconf.conf /etc/resolv.conf && sudo wg show
