#!/usr/bin/env fish
#

function lza --wraps=source --description 'Launch jjui with all files by default'
    if test $(count $argv) -gt 0
        command jjui $argv
        return 0
    end
    # if not set -q $argv[1]
    #     jjui -r 'all()'
    #     return 0
    # end
    command jjui -r 'all()'
    return 0
end
