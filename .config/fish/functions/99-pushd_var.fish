#!/usr/bin/env fish
#

function 99-pushd_var --wraps=pushd --argument-names env_var_value --description 'pushd to the directory specified'
    set --path env_var_value $env_var_value
    test -z "$env_var_value"; and colorize red "Error: No environment variable data!"; and return 1
    not test -d $env_var_value; and colorize red "Error: Environment variable '$env_var_value' is not a valid directory!"; and return 2

    pushd $env_var_value
    or return 3
end
