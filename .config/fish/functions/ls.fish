#!/usr/bin/env fish
#

# TODO: [common_list_client] : Move the 'base' cmd to either an env var, or a func call or something

function ls
    if test -z "$LIST_CLIENT"
        printf "LIST_CLIENT is not set\n"
        set -gx LIST_CLIENT ls
        return 1
    end
    command $LIST_CLIENT -ah --color=always --group-directories-first $argv
end
