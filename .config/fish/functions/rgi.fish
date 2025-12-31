#!/usr/bin/env fish
#

function rgi --wraps=rg --description 'A wrapper around ripgre with the \'-i\' flag'
    rg -i $argv
end
