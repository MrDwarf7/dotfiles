#!/usr/bin/env fish

function ls
    if test -z $LIST_CLIENT
        echo "LIST_CLIENT is not set"
        set -gx LIST_CLIENT "ls"

        return 1
    end
    command $LIST_CLIENT -ah --color=automatic $argv
end
