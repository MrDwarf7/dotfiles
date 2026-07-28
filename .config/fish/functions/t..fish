#!/usr/bin/env fish
#

function t. --wraps=source --description 'Wrapper around Thunar to launch in the current directory'
    set -l all_args (string join '.' $argv)
    if 00-valid_pacman thunar
        thunar $all_args &>/dev/null &
        return 0
    end
    return 1
end
