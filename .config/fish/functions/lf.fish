#!/usr/bin/env fish
#


function lf --description 'List all files including hidden files with details'
    # set __base $(099listing_cmd_base)
    set __base "$LIST_CLIENT_BASE_CMD"
    set --append __base "-lahfo $argv"
    eval $__base

    # if test -z "$LIST_CLIENT"
    #     printf "LIST_CLIENT is not set\n"
    #     set -gx LIST_CLIENT ls
    #     return 1
    # end
    # command $LIST_CLIENT -lahfo --color=always --follow-symlinks --icons=always --group-directories-first --git $argv
end
