#!/usr/bin/env fish

function cls --description 'Clear screen and stop scroll back'
    command clear
    command printf '\e[3J'
end
