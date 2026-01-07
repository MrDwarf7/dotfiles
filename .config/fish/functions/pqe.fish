#!/usr/bin/env fish
#

function pqe --description 'Calls `paru -Q | rg -i <term>` to search installed packages (regex enabled)'
    command paru -Q | rg -e "$argv[1]"
    return $status
end
