#!/usr/bin/env fish
#

function stacc --wraps=stakk --description 'Stakk TUI'
    command stakk $argv || return $status
end
