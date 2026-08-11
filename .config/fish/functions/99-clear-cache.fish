#!/usr/bin/env fish
#

#
# 99-clear-cache
# or
# 99-clear-cache $SOME_VARIABLE
# or
# 99-clear-cache $SOME_VARIABLE $SOME_OTHER_VARIABLE

function 99-clear-cache --argument-names opt_additional --description 'Clears my own manually cached env vars'
    printf "This function is currently unavailable.\n"
    return

    ###    # Make sure main env exists
    ###    # test -z "$CACHED_ENVS_LIST"; and colorize red "Error: No cached env vars to clear!"; and return 1
    ###    test -z "$CACHED_ENVS_LIST"; and colorize red "Error: No cached env vars to clear!"; and return 1
    ###    # clone env list to local mut
    ###    set -l local_cached_envs $CACHED_ENVS_LIST
    ###
    ###    printf "Additional env vars to clear: %s\n" "$opt_additional"
    ###    set -q opt_additional; and not test -z "$opt_additional"; and set --append local_cached_envs $opt_additional
    ###    printf "Current variables to clear: %s\n" "$local_cached_envs"
    ###
    ###    for env_var in $local_cached_envs
    ###        # need to clear BOTH the actual variable itself
    ###        # AND the env var item (which we can do in one go by removing the entire thing)
    ###        printf "Clearing cached env var: %s\n" "$env_var"
    ###        # -e/--erase optionally takes a scope - so
    ###        __env_cached_remove $env_var
    ###    end
    ###    set -q CACHED_ENVS_LIST; and set --universal -e CACHED_ENVS_LIST
    ###    return 0
end
