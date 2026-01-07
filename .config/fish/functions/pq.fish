#!/usr/bin/env fish
#

function pq --description 'Calls `paru -Q | rg -i <term>` to search installed packages'
    command paru -Q | rg $argv[1]
    return $status
end
