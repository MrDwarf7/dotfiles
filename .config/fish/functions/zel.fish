#!/usr/bin/env fish

function zel --description 'zellij start'
    command zellij --session $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; printf "\n")
end
