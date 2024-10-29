#!/usr/bin/env fish

function 04export_onto_path_if_pacman 
    set -l value $argv[1]
    set -l env_var $argv[2]

    # echo "4.0: Checking for $value"
    # echo "4.0: Setting $env_var"

    if 00valid_pacman $value
        # echo "4.1: Setting $env_var to $value"
        set -gx PATH $PATH $env_var
        return 0
    end
    return 1
end
