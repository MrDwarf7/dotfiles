#!/usr/bin/env fish

function la
    if test -z $LIST_CLIENT
        printf "LIST_CLIENT is not set\n"
        set -gx LIST_CLIENT "ls"
        return 1
    end
    command $LIST_CLIENT -lah --color=always --follow-symlinks --icons=always --git $argv
end
