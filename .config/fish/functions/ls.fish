#!/usr/bin/env fish
#

function ls --description 'List all files including hidden files with details'
    # set __base $(099listing_cmd_base)
    set __base "$LIST_CLIENT_BASE_CMD"
    set --append __base "-ah --icons=never $argv"
    eval $__base

    # if test -z "$LIST_CLIENT"
    #     printf "LIST_CLIENT is not set\n"
    #     set -gx LIST_CLIENT ls
    #     return 1
    # end
    # command $LIST_CLIENT -ah --color=always --group-directories-first $argv
end
