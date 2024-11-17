#!/usr/bin/env fish

# Exports a program if it is found in pacman, otherwise it exports a fallback
#
# Parameters:
# $1: The program to check for
# $2: The environment variable to set
# $3: The fallback program
#
# Returns:
# 0 if the program is found
# 0 if the fallback program is used
# 1 if the program is not found
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
    else
        return 1
    end
    return 1
end
