#!/usr/bin/env fish

function fish_user_key_bindings
    set -x fish_sequence_key_delay_ms 160

    bind -M default H beginning-of-line
    bind -M default L end-of-line

    bind -M visual H beginning-of-line
    bind -M visual L end-of-line

    bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint; end"
    # bind -M insert jj "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint; end"
    bind -M insert kj "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint; end"
    bind -M insert kk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint; end"

end
