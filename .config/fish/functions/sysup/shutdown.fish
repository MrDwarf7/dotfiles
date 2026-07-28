#!/usr/bin/env fish
#
# sysup/shutdown.fish -- optional shutdown after a successful update
#
# Pulled out of the orchestrator so the countdown logic is testable on
# its own (e.g. `__sysup_shutdown --wait-mins 0` for a dry run).

function __sysup_shutdown --description 'Countdown then shut down'
    argparse 'w/wait-mins=' -- $argv
    or return

    set -l mins 1
    if set -q _flag_wait_mins; and test -n "$_flag_wait_mins"
        set mins $_flag_wait_mins
    end

    set -l secs (math "60 * $mins")
    colorize yellow "[SYSUP] Shutdown in $mins min(s). Ctrl-C to cancel.\n"

    while test $secs -gt 0
        colorize yellow "[SYSUP] Shutdown in $secs s...\r"
        sleep 1
        set secs (math $secs - 1)
    end

    sudo shutdown -h now
end
