# Changes for xdg dir when using fish 
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
    fish_vi_key_bindings
    zoxide init fish | source
    source (/usr/sbin/starship init fish --print-full-init | psub)

    set -x fish_cursor_default block
    set -x fish_cursor_insert line
    set -x fish_cursor_visual block
end
