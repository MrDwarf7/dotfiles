#!/usr/bin/env fish

# Exports an alias by checking pacman for the program
#
# Parameters:
# $1: The program to check for
# $2: The alias name
# $3: The alias value
#
# Returns:
# 0 if the program is found
# 1 if the program is not found
function 05export_alias_if_pacman
    set -l program_one $argv[1]
    set -l alias_name $argv[2]
    set -l alias_value $argv[3]

    # echo "5.0: Checking for $program_one"
    # echo "5.0: Setting $alias_name"
    # echo "5.0: Falling back to $alias_value"

    if 00valid_pacman "$program_one"
        # echo "5.1: Setting $alias_name to $alias_value"
        alias $alias_name=$alias_value
        return 0
    end
    return 1
end
