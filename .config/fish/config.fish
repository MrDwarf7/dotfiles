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

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Immediately call starship -- subsequent redraws are handled by the
    # call under ./functions/fish_prompt.fish
    # source (/usr/sbin/starship init fish --print-full-init | psub)
    if test -e /usr/sbin/starship
        # /usr/sbin/starship init fish | source
        command starship init fish | source
        commandline -f repaint
    end

    # source our secrets file if it exists
    if test -e "$HOME/.secret/secrets.fish"
        source "$HOME/.secret/secrets.fish"
    end

    # if test -e /bin/direnv
    #     direnv hook fish | source
    # end

    fish_vi_key_bindings

    # Handled by conf.d/01-pre.fish
    # command fzf --fish | source
    # mise activate fish | source   ## -- but being buggy

    # pnpm
    set -gx PNPM_HOME "/home/dwarf/.xdg/data/pnpm"
    if not string match -q -- $PNPM_HOME $PATH
        set -gx PATH "$PNPM_HOME" $PATH
    end
    # pnpm end

    test -r "$HOME/.opam/opam-init/init.fish" && source "$HOME/.opam/opam-init/init.fish" >/dev/null 2>/dev/null; or true
end
