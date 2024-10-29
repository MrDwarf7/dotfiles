#!/usr/bin/env fish

function ca --description 'Clear screen and run ls'
    cls && exa -a --tree --level=1 --icons=always
end
