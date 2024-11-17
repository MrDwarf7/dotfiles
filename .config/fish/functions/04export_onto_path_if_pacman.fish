#!/usr/bin/env fish

# Exports a program onto the path by checking pacman for the program
# Uses fish_add_path to add the program to the path
#
# Parameters:
# $1: The program to check for
# $2: The environment variable to set
#
# Returns:
# 0 if the program is found
# 1 if the program is not found
function 04export_onto_path_if_pacman 
    set -l value $argv[1]
    set -l env_var $argv[2]

    # echo "4.0: Checking for $value"
    # echo "4.0: Setting $env_var"

    if 00valid_pacman $value
        # echo "4.1: Setting $env_var to $value"
        #
        # set -gx PATH $PATH $env_var
        fish_add_path $env_var
        return 0
    end
    return 1
end
