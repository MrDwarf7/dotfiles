#!/usr/bin/env fish

function 02export_if_pacman
    set -l program_one $argv[1]
    set -l env_var $argv[2]
    set -l fallback_prog $argv[3]

    # echo "2.0: Checking for $program_one"
    # echo "2.0: Setting $env_var"
    # echo "2.0: Falling back to $fallback"

    if 00valid_pacman $program_one
        # echo "2.1: Found $program_one"
        set -gx $env_var $program_one
        return 0
    else if test -n "$fallback_prog"
        # echo "2.2: Using fallback $fallback_prog"
        set -gx $env_var $fallback_prog
        return 0
    end
    return 1
end
