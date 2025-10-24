#!/usr/bin/env fish
#

function lza --wraps=source --description 'Launch jjui with all files by default'
    if not set -q argv[1]
        jjui -r 'all()'
        return 0
    end
    jjui $argv
end
