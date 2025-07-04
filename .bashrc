#!/bin/bash
# shellcheck disable=SC1090,SC1091

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

force_color_prompt=yes

aliases_file=$HOME/.aliases
bashrc=~/.bashrc
bash_completion=/usr/share/bash-completion/bash_completion
bash_completion_fallback=/etc/bash_completion
go_bin=/usr/local/go/bin
pnpm_dir=$HOME/.xdg/data/pnpm

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  # shellcheck disable=SC2025
  PS1='\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  #PS1='[\u@\h \W]\$ '
else
  PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  # shellcheck disable=SC2015
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias l='ls -al --color=auto'
  alias ls='ls -l --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    # shellcheck source=/usr/share/bash-completion/bash_completion
    source "$bash_completion"
  elif [ -f /etc/bash_completion ]; then
    # shellcheck source=/etc/bash_completion
    source "$bash_completion_fallback"
  fi
fi

if [[ -d "$go_bin" ]]; then
  export GOBIN="$go_bin"
  export PATH="$PATH:$go_bin"
fi

# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# pnpm
if [[ -d $pnpm_dir ]]; then
  export PNPM_HOME="$pnpm_dir"
else
  mkdir -p "$pnpm_dir"
  export PNPM_HOME="$pnpm_dir"
fi

case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias .b='source $bashrc'
alias basc='vim $bashrc'

# Wrap the alias sourcing in a safety incase we don't have the file

if [[ -f $aliases_file ]]; then
  # shellcheck source=$HOME/.aliases
  source "$aliases_file"
fi

# USE asdf OR mise instead going forward I thin
# source /usr/share/nvm/init-nvm.sh

# if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
#   source /usr/share/nvm/init-nvm.sh
# fi

# source /home/dwarf/.config/broot/launcher/bash/br
