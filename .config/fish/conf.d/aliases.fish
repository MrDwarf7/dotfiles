#!/usr/bin/env fish
#

###### IMPORTANT
# If '$argv' is at the end of the command, simply omiti it,
# `alias` builtin will automatically append it for you.

alias yaysiv='yay -Siv'
alias yayup='yay -Syu'
alias yays='yay -S'
alias yayss='yay -Ss'

alias par paru
alias pars "paru -S"
alias parss "paru -Ss"
alias parsu "paru -Syu"

alias parq "paru -Q"

alias parsi "paru -Si"
alias parsiv "paru -Siv"

alias shutdown 'systemctl poweroff'

alias aa='jj'
# alias au jjui
# alias au lza ## no longer needed -> au is now default

alias ghd gh-dash

alias at just
alias b bat
alias c cat
alias c-="cd -"
alias ccc c3c
alias cd-="cd -"
alias cls="command clear ; command printf '\e[3J' "
alias ef="exec fish"
alias lg lazygit
alias lzd lazydocker
alias lzs lazyjournal
alias lzvim="set -x NVIM_APPNAME lazyvim ; nvim"
alias ma="command cargo make"
alias md="command mkdir -p"
alias p $PKG_MANAGER
alias pq="command paru -Q | rg"
alias pqi="command paru -Q | rg -i"
alias pqe="command paru -Q | rg -e"
alias pqie="command paru -Q | rg -i -e"
alias rgi="rg -i"
alias t="command tv"
alias tenkip="command tenki --mode rain -f 200 -t 90 -l 50 --show-fps"
alias twt="command taskwarrior-tui"
alias z..="command zoxide add $PWD"
alias ze="command zoxide edit"

# alias usudo="env SHELL(which fish) sudo -E $argv" ### not sure if this works, leave as fn for now
# alias zl (command zellij --session $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; printf "\n"))
