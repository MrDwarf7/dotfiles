#!/usr/bin/env fish
#

function 03export_path_if_pacman --description "If a provided program is available via pacman, exports an environment variable to a path"
    # Exports an environment variable if the program is found in pacman
    # Used to set an env var to a path specfically
    #
    # Parameters:
    # $argv[1]: The program to check for
    # $argv[2]: The environment variable to set
    # $argv[3]: The path value
    #
    # Returns:
    # 0 if the program is found
    # 1 if the program is not found
    set -l program_one $argv[1]
    set -l env_var $argv[2]
    set -l path_value $argv[3]

    # printf "3.0: Checking for %s\n" "$program_one"
    # printf "3.0: Setting %s\n" "$env_var"
    # printf "3.0: Falling back to %s\n" "$fallback_prog"

    if test -z "$env_var"
        # printf "3.X: No env var provided, cannot set.\n"
        # printf "\n"
        return 1
    end

    if 00valid_pacman "$program_one"
        # printf "3.1: Setting $env_var to %s\n" "$path_value"
        set -gx $env_var $path_value
        return 0
    end
    return 1
end
