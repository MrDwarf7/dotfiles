#!/usr/bin/env fish
#
# sysup.fish -- system update orchestrator (REGISTRY-DRIVEN MOCK)
#
# Design goals (fixes the drift problem):
#   - ONE source of truth for steps: sysup/registry.fish
#   - The orchestrator, plan builder, help, and runner ALL read the
#     registry. There is NO case statement mapping names -> functions.
#   - Each step is a file sysup/<name>.fish defining function sysup_<name>.
#     The runner calls sysup_$name directly, so the name and the function
#     are the same symbol -- impossible to drift apart.
#
# Naming convention:
#   sysup_<name>   = a dispatchable STEP (public API, registry-driven)
#   __sysup_*      = internal helper (private; not a step)
#   __mirror_*     = mirror subsystem private helpers
#
# Adding a new step (e.g. yazi's `ya` or flatpak):
#   1. Add ONE line to sysup/registry.fish:  set -a sysup_steps 'ya|y|Update yazi'
#   2. Create sysup/ya.fish with `function sysup_ya ...`
#   That's the ONLY two edits. Help, plan, and dispatch update automatically.

function sysup --description 'System update orchestrator'
    # Fish does NOT auto-load nested function files, so we glob-source the
    # helper dirs. This also keeps these helpers out of the global function
    # namespace until `sysup` actually runs (they're "hidden" in the dir).
    set -l --path derived (dirname (status filename))

    set -l --path base (realpath -s -e (echo $__fish_config_dir/functions/))
    if not test (string match -r "$derived" "$base")
        colorize red "[SYSUP] ERROR: sysup.fish must be in $base/sysup\n"
        colorize red "[SYSUP] Derived path: $derived\n"
        colorize red "[SYSUP] Base path:    $base\n"
        return 1
    end

    for d in sysup mirror_update
        set -l dir $base/$d
        if test -d $dir
            for f in $dir/*.fish
                source $f
            end
        end
    end

    __sysup_cmp
    argparse --name=sysup h/help s/skip=+ d/shutdown -- $argv
    or begin
        colorize red "[SYSUP] Invalid arguments: $argv\n"
        return 2
    end

    if set -q _flag_help
        __sysup_help
        return 0
    end
    set -l order (__sysup_plan --skip=(string join '' $_flag_skip))
    or return $status

    colorize blue "[SYSUP] Starting system update...\n"
    colorize blue "[SYSUP] Step order: $order\n"

    # Prime sudo and keep the timestamp fresh for the whole run so we don't
    # get prompted mid-update. rate-mirrors + the mirror install can blow
    # past the 15-min sudo timeout and silently block later sudo calls.
    sudo -v
    # Spawn the keepalive as a SEPARATE fish process (not an internal
    # background job). `while ... end &` inside fish keeps the parent blocked
    # at function return waiting on the job; `fish -c '...' &` truly detaches
    # so $last_pid is captured and the parent returns immediately.
    fish -c 'while true; sleep 50; sudo -n true 2>/dev/null; end' &
    set -g __sysup_keepalive_pid $last_pid

    # Make sure the keepalive dies on ANY exit path:
    #   - clean return / early abort  -> fish_exit handler
    #   - Ctrl-C (SIGINT)             -> --on-signal INT handler
    #   - kill / crash (SIGTERM)      -> --on-signal TERM handler
    # fish has no `trap`, so we register all three. The PID lives in a global
    # (__sysup_keepalive_pid) because --on-event/--on-signal handlers run as
    # separate invocations later and cannot see this function's locals. Each
    # handler erases all three so they can't leak across invocations.
    #
    ## Lint is regarding an event handler being registered in a non-global/non-autoloaded context.
    ## This is intentional - we only need this handler inside of the fn itself (and children)
    # @fish-lsp-disable-next-line 4007
    function __sysup_cleanup_keepalive --on-event fish_exit
        kill $__sysup_keepalive_pid 2>/dev/null
        __sysup_cleanup_unregister
    end
    function __sysup_cleanup_int --on-signal INT
        kill $__sysup_keepalive_pid 2>/dev/null
        # Do NOT unregister here -- the fish_exit handler is our backup.
        # Do NOT kill -INT %self -- that cancels this handler before exit runs.
        # exit 130 gives the standard "interrupted by SIGINT" status.
        exit 130
    end
    function __sysup_cleanup_term --on-signal TERM
        kill $__sysup_keepalive_pid 2>/dev/null
        # Do NOT unregister -- let fish_exit handle it during actual exit.
    end
    # fish_exit handler is the safety net -- it runs during actual shell exit
    # and cleans up the keepalive + unregisters all handlers.

    function __sysup_cleanup_unregister
        functions --erase __sysup_cleanup_keepalive 2>/dev/null
        functions --erase __sysup_cleanup_int 2>/dev/null
        functions --erase __sysup_cleanup_term 2>/dev/null
    end

    __sysup_mise_begin

    for name in $order
        set -l fn sysup_$name
        colorize yellow "[SYSUP] -> $name\n"
        $fn
        or begin
            kill $__sysup_keepalive_pid 2>/dev/null
            colorize red "[SYSUP] Step '$name' failed -- aborting.\n"
            __sysup_mise_end true
            return 5
        end
    end

    __sysup_mise_end
    colorize green "[SYSUP] System update complete!\n"

    if set -q _flag_shutdown
        __sysup_shutdown --wait-mins 1
    end

    # Stop the sudo keepalive now that we're done.
    kill $__sysup_keepalive_pid 2>/dev/null
end

function __sysup_cmp
    complete -c sysup -s h -l help -d 'Show help'
    complete -c sysup -s s -l skip -a (__sysup_step_letters) \
        -d 'Skip steps by letter (m p a c r y)'
    complete -c sysup -s d -l shutdown -d 'Shutdown after success'
end

function __sysup_help
    printf "Usage: sysup [FLAGS]\n\n"
    printf "Flags:\n"
    printf "  -h, --help     Show this help\n"
    printf "  -s, --skip     Skip steps by letter: %s\n" (__sysup_step_letters)
    printf "  -d, --shutdown Shut down after a successful update\n\n"
    printf "Steps (in registry order; '-' = cannot be skipped):\n"
    for entry in $sysup_steps
        set -l parts (string split '|' $entry)
        if test "$parts[2]" = -
            printf "  %-10s (always)  %s\n" $parts[1] $parts[3]
        else
            printf "  %-10s %s        %s\n" $parts[1] $parts[2] $parts[3]
        end
    end
end
