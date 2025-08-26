#!/bin/env bash
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

# requires the `bash-completion`
# sudo pacman -S bash-completion
bash_completion="/usr/share/bash-completion/bash_completion"
bash_completion_fallback="/etc/bash_completion.d/000_bash_completion_compat.bash"

# if [ -f /usr/share/bash-completion/bash_completion ]; then
if ! shopt -oq posix; then
  if [ -f "$bash_completion" ]; then
    # shellcheck source=/usr/share/bash-completion/bash_completion
    source "$bash_completion"
  elif [ -f /etc/bash_completion ]; then
    # shellcheck source=/etc/bash_completion
    source "$bash_completion_fallback"
  fi
fi

# Check if exa or eza exists,
# if it does set LIST_CLIENT to it,
# otherwise ls

case "$(command -v eza || command -v exa)" in
"")
  export LIST_CLIENT="ls"
  ;;
*)
  export LIST_CLIENT="eza"
  ;;
esac

# set aliases if LIST_CLIENT is exa or eza

if [[ $LIST_CLIENT == "eza" || $LIST_CLIENT == "exa" ]]; then
  alias l='exa -lah --color=always --follow-symlinks --icons=always --git'
  alias la='exa -lah --color=always --follow-symlinks --icons=always --git'
  alias ls='exa -ah --color=automatic'
else
  alias l='ls -lah --color=auto'
  alias la='ls -la - --color=auto'
  alias ls='ls -ah --color=auto'
fi

# ----------------------------

bashrc="$HOME/.bashrc"

# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

alias gst="git status"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gstash="git stash"
alias gco="git checkout"

alias .b="source $bashrc"
alias basc="vim $bashrc"

alias cls='clear'
alias ca='clear && l'
alias neo='neofetch'
alias pf='pfetch'
alias shutdown='systemctl poweroff'

alias vi='/usr/bin/vim'
alias vim='nvim'
alias matrix='cmatrix'

function dot {
  folder=~/dotfiles/
  cd $folder || exit
  if [ -z "$1" ]; then
    (cd $folder && git fetch && git status)
  else
    (cd $folder && git fetch && git status)
  fi
}

# ------------------
# Path stuff
# -----------------

if [[ -d "$go_bin" ]]; then
  export GOBIN="$go_bin"
  export PATH="$PATH:$go_bin"
fi

# # Created by `pipx` on 2023-10-26 10:01:20
# eval "$(register-python-argcomplete pipx)"

export ZSH=/home/dwarf/.zshrc
export PATH="$PATH:/home/dwarf/.local/bin"

eval "$(starship init bash)"

echo ""
pfetch
