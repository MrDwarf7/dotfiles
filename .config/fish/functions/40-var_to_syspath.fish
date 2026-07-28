#!/usr/bin/env fish
#

function 40-var_to_syspath --wraps=fish_add_path --argument-names program_to_check env_var flag --description "If a provided program is available via pacman, exports a program onto the system PATH via fish's add_path fn"
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
    # Check if the $env_Var is already on path, if it is, return 0 early
    contains $argv[2] $PATH; and return 0

    # If valid prog and flag was given, pass the flag through to the fish_add_path function
    00-valid_pacman "$program_to_check"; and test -n "$flag"; and fish_add_path $flag $env_var; and return 0
    00-valid_pacman "$program_to_check"; and fish_add_path $env_var; and return 0
    or return 1

    ## old code
    # if 00-valid_pacman "$program_to_check"; and test -n "$flag"
    #     fish_add_path $flag $env_var
    #     return 0
    # end

    # if 00-valid_pacman "$program_to_check"
    #     fish_add_path $env_var
    #     return 0
    # end

    # return 1
end
