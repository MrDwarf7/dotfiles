set -g TM_DBG 0

# canonical|aliases|completion target|description
set -g tm_registry \
    'help|h,-h,--help|none|Show command help' \
    'list|l,ls,lses,lsses|none|List tmux sessions' \
    'attach|a,at,n,ns,new,nses|session|Attach to or create a session; bare tm uses the most recent session' \
    'detach|d,dt,de|session|Detach the current client or clients attached to a session' \
    'rename|rs,reses|session|Rename a session: tm rename OLD NEW' \
    'switch|s,sw|session|Switch the current client to a session' \
    'panes|lp,lpane|session|List panes in the current or named session' \
    'clients|lc,lcp,list-clients|none|List tmux clients' \
    'windows|lw,lwin|session|List windows in the current or named session' \
    'kill|k,ks,kses,kills|sessions|Kill one or more sessions (comma- or space-separated; leading -q is quiet)' \
    'killw|kw,kill-window|window|Kill a window' \
    'killpane|kp,kill-pane|pane|Kill a pane' \
    'killall|ka,killa|none|Kill all tmux sessions' \
    'to|mw|session|Move the current window to a session, creating it if needed'

function __tm_find_entry --description 'Find a command registry entry by canonical name or alias'
    set -l requested $argv[1]
    for entry in $tm_registry
        set -l parts (string split '|' -- "$entry")
        if test "$requested" = "$parts[1]"
            printf '%s\n' "$entry"
            return 0
        end
        for alias in (string split ',' -- "$parts[2]")
            if test "$requested" = "$alias"
                printf '%s\n' "$entry"
                return 0
            end
        end
    end
    return 1
end

function __tm_complete_commands --description 'Print registry commands and descriptions for completion'
    for entry in $tm_registry
        set -l parts (string split '|' -- "$entry")
        printf '%s\t%s\n' "$parts[1]" "$parts[4]"
        for alias in (string split ',' -- "$parts[2]")
            printf '%s\t%s\n' "$alias" "$parts[4]"
        end
    end
end

function __tm_print_help --description 'Print help generated from the tm registry'
    printf 'Usage: tm [COMMAND [ARGS...]]\n\n'
    printf 'A registry-driven wrapper for tmux. With no command, tm attaches to the most recently used session. An unrecognized first argument is treated as a session name to attach to or create.\n\n'
    printf 'Commands:\n'
    for entry in $tm_registry
        set -l parts (string split '|' -- "$entry")
        set -l names $parts[1]
        for alias in (string split ',' -- "$parts[2]")
            set -a names "$alias"
        end
        printf '  %-38s %s\n' (string join ', ' -- $names) "$parts[4]"
    end
    printf '\nExamples:\n  tm\n  tm attach mysession\n  tm to work\n  tm kill first,second\n\n'
    printf 'Debug: flip TM_DBG from 0 to 1 in functions/tm.fish for all modules, or in a command file for that module only.\n\n'
    printf 'To add a command, add a registry entry here and create functions/tm/<canonical>.fish. The registry drives dispatch, help, and completions.\n'
end
