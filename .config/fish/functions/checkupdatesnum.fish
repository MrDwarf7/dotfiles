#!/usr/bin/env fish
#

function checkupdatesnum --wraps=source --description 'Wrapper funciton around the "checkupdates" call that also displays the number'
    set -l output (command checkupdates)
    printf "%s\n" $output
    printf "%s\n" (count $output)
    return $status
end
