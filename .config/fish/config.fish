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

# Commands to run in interactive sessions can go in here
if status is-interactive
    # 01eval_if_pacman zoxide "zoxide init fish" # zoxide init fish | source
    # 01eval_if_pacman fzf "fzf --fish" # fzf --fish | source
    # #
    # 04var_to_syspath mise "$HOME/.xdg/data/mise/shims" --prepend
    # 01eval_if_pacman mise "mise activate fish | source"

    # Immediately call starship on term start (interactive)
    01eval_if_pacman starship "starship init fish --print-full-init"
    commandline -f repaint
    # 01eval_if_pacman direnv "direnv hook fish | source"

    # source our secrets file if it exists
    if test -e "$HOME/.secret/secrets.fish"
        source "$HOME/.secret/secrets.fish" &
    end

    # 099autostart_tmux new
end
