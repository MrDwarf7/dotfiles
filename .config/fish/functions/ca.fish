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
    command $LIST_CLIENT -lah --color=always --follow-symlinks --icons=always --git
end
