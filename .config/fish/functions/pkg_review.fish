#!/usr/bin/env fish
#

function pkg_review --description 'Review installed packages with fzf'
    pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
end
