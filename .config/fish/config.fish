#!/usr/bin/env fish
#

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
        /usr/sbin/starship init fish | source
        commandline -f repaint
    end
    # /usr/sbin/starship init fish

    # if test -e /bin/direnv 
    #     direnv hook fish | source
    # end

    fish_vi_key_bindings

    # Handled by ./conf.d/01-pre.fish
    # zoxide init fish | source
    
    # This is now a part of the ./functions/fish_prompt.fish file
    # source (/usr/sbin/starship init fish --print-full-init | psub)

    # Handled by conf.d/01-pre.fish
    # source (/bin/mise activate fish | psub)

    # mise activate fish | source

end
