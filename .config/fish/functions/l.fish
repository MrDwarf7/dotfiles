#!/usr/bin/env fish
#


function l --description 'List all files including hidden files with details'
    set __base "$LIST_CLIENT_BASE_CMD"
    set --append __base "-laho $argv"
    eval $__base
end


# if test -z "$LIST_CLIENT"
#     printf "LIST_CLIENT is not set\n"
#     set -gx LIST_CLIENT ls
#     return 1
# end
# command $LIST_CLIENT -laho --color=always --follow-symlinks --icons=always --group-directories-first --git $argv
