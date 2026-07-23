#!/usr/bin/env fish
#

###### IMPORTANT
# If '$argv' is at the end of the command, simply omiti it,
# `alias` builtin will automatically append it for you.

## <action><on what>

### Shell specific aliases
alias ef "exec fish"

#### <cd><fish>
alias cf "cd ~/dotfiles/.config/fish || printf 'Failed to cd into ~/dotfiles/.config/fish\n'"
#### <nvim><fish>
alias vf "nvim ~/dotfiles/.config/fish || printf 'Failed to open ~/dotfiles/.config/fish in nvim\n'"

#### <cd><hermes>
alias ch "cd ~/.hermes/ || printf 'Failed to cd into ~/.hermes/\n'"
alias vh "nvim ~/.hermes/config.yaml || printf 'Failed to open ~/.hermes/config.yaml in nvim\n'"

##################################################

alias vortix 'printf "Aliased :: Using sudo\n"; sudo vortix'

##################################################

alias yaysiv 'yay -Siv'
alias yayup 'yay -Syu'
alias yays 'yay -S'
alias yayss 'yay -Ss'

alias par paru
alias pars "paru -S"
alias parss "paru -Ss"
alias parsu "paru -Syu"

alias parq "paru -Q"

alias parsi "paru -Si"
alias piv "paru -Siv"

# alias pq "command paru -Q | rg"
alias pq pqi
alias pqe pqi
alias pqie pqi

alias p $PKG_MANAGER

# See also `pqiv` function that uses the output (if singular) from the above `pqi` function
# to then call `paru -Siv <output>`

alias shutdown 'systemctl poweroff'
# alias reboot reboot ## doesn't need an alias lmao

alias shutdownf 'sudo systemctl poweroff --force'
alias rebootf 'sudo reboot --force'

alias aa jj
# interactions with the alias inside of the jj config.toml -> wraps an fzf output to cd
alias aag 'cd $(jj wo)'

# alias au jjui
# alias au lza ## no longer needed -> au is now default

alias ghd gh-dash

alias at just
alias b bat
alias c cat
alias c- "cd -"
alias ccc c3c
alias cd- "cd -"

# Previously was an actual funciton but we literally just call "l.fish"
alias la l

alias cls "command clear ; command printf '\e[3J' "
alias lg lazygit
alias lzd lazydocker
alias lzs lazyjournal
alias lzvim "set -x NVIM_APPNAME lazyvim ; nvim"
alias ma "command cargo make"
alias md "command mkdir -p"
alias rgi "rg --ignore-case --heading --line-number"
alias rgie "rg --ignore-case --heading --regexp"
# alias rgif "rg --ignore-case --heading --"
alias t "command tv"
alias tenkip "command tenki --mode rain -f 200 -t 90 -l 50 --show-fps"
alias twt "command taskwarrior-tui"
alias z. "command zoxide add $PWD"
alias ze "command zoxide edit"

alias rup recent_updated_pkgs
alias rip recent_installed_pkgs

#### DMS (Dank Linux) specific aliases - for direct terminal use only! Do not bind these as keymaps lol
alias dmslock 'dms ipc call lock lock'

# alias usudo="env SHELL(which fish) sudo -E $argv" ### not sure if this works, leave as fn for now
# alias zl (command zellij --session $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; printf "\n"))
