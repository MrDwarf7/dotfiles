#!/usr/bin/env fish
#

function 02export_if_pacman --description "If a provided program is available via pacman, exports an environment variable, otherwise uses a provided fallback"
    # Exports a program if it is found in pacman, otherwise it exports a fallback
    #
    # Parameters:
    # $argv[1]: The program to check for
    # $argv[2]: The environment variable to set
    # $argv[3]: The fallback program
    #
    # Returns:
    # 0 if the program is found
    # 0 if the fallback program is used
    # 1 if the program is not found
    set -l program_one $argv[1]
    set -l env_var $argv[2]
    set -l fallback_prog $argv[3]

    # printf "2.0: Checking for %s\n" "$program_one"
    # printf "2.0: Setting %s\n" "$env_var"
    # printf "2.0: Falling back to %s\n" "$fallback_prog"

    if test -z "$env_var"
        # printf "2.X: No env var provided, cannot set.\n"
        # printf "\n"
        return 1
    end

    if 00valid_pacman "$program_one"
        # printf "2.1: Found %s\n" "$program_one"
        # printf "\n"
        set -gx $env_var $program_one
        return 0
    else if test -n "$fallback_prog"
        # printf "2.2: Using fallback %s\n" "$fallback_prog"
        # printf "\n"
        set -gx $env_var $fallback_prog
        return 0
    end
    # printf "\n"
    return 1
end
