if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x fish_sequence_key_delay_ms 160
    bind -M default H beginning-of-line
    bind -M default L end-of-line
end

