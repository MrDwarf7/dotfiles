#!/usr/bin/env fish
#

function cd- --wraps=source --description 'Use "cd -" shorthand'
    cd - $argv
end
