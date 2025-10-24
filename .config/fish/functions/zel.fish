#!/usr/bin/env fish
#

function zel --description 'zellij start'

    if test -z $argv
        command zellij --session $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; printf "\n") || return $status
        return $status
    end
    command zellij $argv || return $status

    return $status
end
