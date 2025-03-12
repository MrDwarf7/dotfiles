#!/usr/bin/env fish

function fish_prompt --description 'Starship prompt'
    # Call repaint before and after as it feels snappier
    commandline -f repaint
    # source (/usr/sbin/starship init fish --print-full-init | psub)
    /usr/sbin/starship init fish | source
    commandline -f repaint
end
