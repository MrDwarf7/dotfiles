#!/usr/bin/env fish
#

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

    # set -lx fn_dir (dirname (status filename))
    # bind -M insert \cg "fish -c 'source $fn_dir/vs.fish'; vs"

    # TODO: We'd also want to have a way to eg:
    # > some_query {{ ctrl-g }} ->
    ## which would act the same as if we'd done eg:
    # > vs some_query {{ enter }}
    #
    # This will; however, require use to stuff around with commandline cutting

    bind -M insert \cg vs

end
