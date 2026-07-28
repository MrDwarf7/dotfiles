#!/usr/bin/env fish
#

function 99-pushd_var --wraps=pushd --argument-names env_var_value --description 'pushd to the directory specified'
    set --path env_var_value $env_var_value
    test -z "$env_var_value"; and colorize red "Error: No environment variable data!"; and return 1
    not test -d $env_var_value; and colorize red "Error: Environment variable '$env_var_value' is not a valid directory!"; and return 1

    pushd $env_var_value; or colorize red "Error: Failed to pushd to '$env_var_value'!"; and return 1

    # if test -z "$env_var_value"
    #     colorize red "Error: No environment variable data!"
    #     return 1
    # end

    # if not test -d $env_var_value
    #     colorize red "Error: Environment variable '$env_var_value' is not a valid directory!"
    #     return 1
    # end

    # pushd $env_var_value; or begin
    #     colorize red "Error: Failed to pushd to '$env_var_value'!"
    #     return 1
    # end
end
