#!/usr/bin/env fish
#

function aas --wraps=source --description 'Jj workspace picker via fzf'
    jj diff $argv --stat | tail -1
end
