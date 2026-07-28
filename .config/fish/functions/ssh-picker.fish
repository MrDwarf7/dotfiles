#!/usr/bin/env fish
# @fish-lsp-disable 3003

# fzf SSH host picker -- fish port of Cleboost's ssh-menu.sh
#
# Config (optional, set once in config.fish to override the built-in defaults):
#   checked; set if not already -- set -gx SSH_PICKER_FAIL_DELAY 5                          # seconds to linger on connection failure
#   checked; set if not already -- set -gx SSH_PICKER_IGNORE_RE "(aur.archlinux|codeberg|ssh.gitlab|gitlab|github.com)"

function ssh-picker --description "fzf SSH host picker (port of Cleboost's ssh-menu.sh)"
    # Fail-delay is pulled from a global so it can be tuned without editing this file.
    if not set -q SSH_PICKER_FAIL_DELAY
        set -gx SSH_PICKER_FAIL_DELAY 5
    end

    # Ensure an SSH agent socket is set (Bitwarden SSH agent by default)
    if not set -q SSH_AUTH_SOCK; or test -z "$SSH_AUTH_SOCK"
        set -gx SSH_AUTH_SOCK "$HOME/.bitwarden-ssh-agent.sock"
    end

    # Host glob patterns to hide from the picker (wildcards supported, e.g. *.example.com)
    if not set -q SSH_PICKER_IGNORE_RE
        set -gx SSH_PICKER_IGNORE_RE "(aur.archlinux|codeberg|ssh.gitlab|gitlab|github.com)"
    end

    # Pull host entries out of ~/.ssh/config (skip wildcards / patterns).
    # The list is reversed so the most recently added hosts show first; the
    # manual-entry option below is prepended on top regardless.
    set -l hosts (
        begin
            grep -i -E '^Host[[:space:]]+' "$HOME/.ssh/config" 2>/dev/null \
            | sed -E 's/^Host[[:space:]]+//I' \
            | tr -d '"' \
            | grep -v '\*' \
            | tac
        end
    )

    # Drop any hosts matching the ignore globs
    set -l filtered_hosts
    for h in $hosts
        set -l skip 0
        for pat in $SSH_PICKER_IGNORE_RE
            # If string length of zero, just skip through
            if test -z "$pat"
                continue
            end

            if string match -qr -- $pat $h
                set skip 1
                break
            end
        end

        if test $skip -eq 0
            set -a filtered_hosts $h
        end
    end
    set hosts $filtered_hosts

    set -l selected_host

    if test -z "$hosts"
        read -P "No hosts found in ~/.ssh/config. Enter IP or hostname to connect to: " selected_host
    else
        set selected_host (
            begin
                printf '%s\n' "[Enter address manually]" $hosts \
                | fzf --prompt="Select SSH Host: " \
                      --height=100% \
                      --layout=reverse \
                      --border=rounded \
                      --margin=1 \
                      --padding=1 \
                      --color="bg+:-1,fg+:2,prompt:5,border:4" \
                      --header="Press ESC to exit"
            end
        )
    end

    # Manual entry branch
    if test "$selected_host" = "[Enter address manually]"
        clear
        read -P "Enter connection address (e.g. user@ip): " manual_host
        if test -n "$manual_host"
            set selected_host $manual_host
        else
            return 0
        end
    end

    # Connect if a real host was chosen
    if test -n "$selected_host"; and test "$selected_host" != "[Enter address manually]"
        # Drop floating state if the current window is floating (so the SSH
        # session doesn't inherit a tiny float)
        if 00-valid_pacman hyprctl; and hyprctl activewindow | string match -q "*floating: 1*"
            hyprctl dispatch 'hl.dsp.window.float({ action = "toggle" })'
        end

        # Copy Kitty terminfo to the remote if it's missing
        if test "$TERM" = xterm-kitty; and 00-valid_pacman kitty
            printf "Checking remote terminal compatibility...\n"
            if not ssh -o ConnectTimeout=3 -o BatchMode=yes "$selected_host" "infocmp xterm-kitty >/dev/null 2>&1"
                printf "Copying Kitty terminfo to remote server...\n"
                kitty +kitten ssh "$selected_host" exit >/dev/null 2>&1
            end
        end

        clear
        printf "Connecting SSH to %s...\n" "$selected_host"
        ssh -t "$selected_host" "clear; exec \$SHELL"

        # On failure, linger so the error is readable before the terminal closes
        if test $status -ne 0
            # printf "\nConnection error. Closing in %s seconds...\n" "$SSH_PICKER_FAIL_DELAY"
            printf "\nConnection error. Closing in %d seconds...\n" "$SSH_PICKER_FAIL_DELAY"
            sleep $SSH_PICKER_FAIL_DELAY
        end
    end
end
