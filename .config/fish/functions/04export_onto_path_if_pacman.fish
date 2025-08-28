#!/usr/bin/env fish
#

# Exports a program onto the path by checking pacman for the program
# Uses fish_add_path to add the program to the path
#
# Parameters:
# $argv[1]: The program to check for
# $argv[2]: The environment variable to set
# $argv[3]?: Optional flag to pass to fish_add_path (e.g. --prepend, --append)
#
# Returns:
# 0 if the program is found
# 1 if the program is not found
function 04export_onto_path_if_pacman
    # Check if the $env_Var is already on path, if it is, return 0 early
    if contains $argv[2] $PATH
        # printf "Return early.\n"
        return 0
    end

    set -l program_to_check $argv[1]
    set -l env_var $argv[2]
    set -l flag $argv[3]

    # printf "04export_onto_path_if_pacman: Checking for program '%s' to add '%s' to PATH with flag '%s'\n" $program_to_check $env_var $flag

    # If valid prog and flag was given, pass the flag through to the fish_add_path function
    if 00valid_pacman "$program_to_check" && test -n "$flag"
        fish_add_path $flag $env_var
        return 0
    end

    if 00valid_pacman "$program_to_check"
        fish_add_path $env_var
        return 0
    end
    return 1
end
