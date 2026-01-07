#!/usr/bin/env fish
#

function pqi --description 'Calls `paru -Q | rg -i <term>` to search installed packages (cast insensitive)'
    command paru -Q | rg -i "$argv[1]"
    return $status
end
