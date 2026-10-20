#!/usr/bin/env fish
#

# This overlaps directly with an jj alias; just without the space
# so `jj ds` and `aads` are the same thing.

function aads --wraps=source --description 'Jj workspace picker via fzf'
    jj diff $argv --stat
end
