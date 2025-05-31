#!/usr/bin/env fish

function lt
    if test -z $LIST_CLIENT
        printf "LIST_CLIENT is not set\n"
        set -gx LIST_CLIENT "ls"
        return 1
    end
    command $LIST_CLIENT -a --tree --level=2 --icons=always $argv
end
