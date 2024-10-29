#!/usr/bin/env fish

function zela --description 'zellij attach'
    zellij a
end

function zel --description 'zellij start'
    zellij --session $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; echo "")
end

# alias zel 'zellij --session $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; echo "")'
# alias zela 'zellij a'
