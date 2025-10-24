#!/usr/bin/env fish
#

function c- --wraps=source --description 'Use "cd -" shorthand'
    cd - $argv
end
