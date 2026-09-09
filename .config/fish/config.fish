#!/usr/bin/env fish

#Changes for xdg dir when using fish
# must be done via one of the dirs listed in
# 'man 5 enviornment.d'
# ~/.config/environment.d/*.conf
# /etc/environment.d/*.conf
# /run/environment.d/*.conf
# /usr/local/lib/environment.d/*.conf
# /usr/lib/environment.d/*.conf
# /etc/environment

# Reset sudo password prompt lockout timer if playin around with sudo and getting locked out
# faillock --user $USER --reset
test (uname) = "Darwin"; and set -gx IS_MACOS 1

# if set -q IS_MACOS 1
if test $IS_MACOS -eq 1
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

# Commands to run in interactive sessions can go in here
if status is-interactive
    # 01eval_if_pacman zoxide "zoxide init fish" # zoxide init fish | source
    # 01eval_if_pacman fzf "fzf --fish" # fzf --fish | source
    # #

    # Immediately call starship on term start (interactive)
    10-eval_if_pacman starship "starship init fish --print-full-init"
    commandline -f repaint
    # 01eval_if_pacman direnv "direnv hook fish | source"

    # source our secrets file if it exists
    if test -e "$HOME/.secret/secrets.fish"
        source "$HOME/.secret/secrets.fish" &
    end

    # 00-valid_pacman shellup; and shellup &

    # 099autostart_tmux new
end
