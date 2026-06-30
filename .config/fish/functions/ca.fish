#!/usr/bin/env fish
#

function ca --description 'Clear screen and run ls'
    command clear
    if test -z "$LIST_CLIENT"
        printf "LIST_CLIENT is not set\n"
        set -gx LIST_CLIENT ls
        return 1
    end
    commandline -f repaint
    l
    # command $LIST_CLIENT -laho --color=always --follow-symlinks --icons=always --group-directories-first --git
end
