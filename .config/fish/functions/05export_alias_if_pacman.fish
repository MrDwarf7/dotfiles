#!/usr/bin/env fish
#

# Exports an alias by checking pacman for the program
#
# Parameters:
# $argv[1]: The program to check for
# $argv[2]: The alias name
# $argv[3]: The alias value
#
# Returns:
# 0 if the program is found
# 1 if the program is not found
function 05export_alias_if_pacman
    set -l program_one $argv[1]
    set -l alias_name $argv[2]
    set -l alias_value $argv[3]

    # printf "5.0: Checking for %s\n" "$program_one"
    # printf "5.0: Setting %s\n" "$alias_name"
    # printf "5.0: Falling back to %s\n" "$alias_value"

    if 00valid_pacman "$program_one"
        # printf "5.1: Setting %s to %s\n" "$alias_name" "$alias_value"
        alias $alias_name=$alias_value
        return 0
    end
    return 1
end
