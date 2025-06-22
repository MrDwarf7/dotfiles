#!/usr/bin/env fish

# Exports an environment variable if the program is found in pacman
# Used to set an env var to a path specfically
#
# Parameters:
# $1: The program to check for
# $2: The environment variable to set
# $3: The path value
#
# Returns:
# 0 if the program is found
# 1 if the program is not found
function 03export_path_if_pacman
    set -l program_one $argv[1]
    set -l env_var $argv[2]
    set -l path_value $argv[3]

    # echo "3.0: Checking for $program_one"
    # echo "3.0: Setting $env_var"
    # echo "3.0: Falling back to $fallback_prog"

    if 00valid_pacman "$program_one"
        # echo "3.1: Setting $env_var to $path_value"
        set -gx $env_var $path_value
        return 0
    end
    return 1
end
