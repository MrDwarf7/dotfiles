#!/usr/bin/env fish
#

# This overlaps directly with an jj alias; just without the space
# so `jj dss` and `aadss` are the same thing.

function aadss --wraps=source --description 'Jj workspace picker via fzf'
    jj diff $argv --stat | tail -1
end
