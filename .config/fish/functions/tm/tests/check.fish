#!/usr/bin/env fish

function fail
    printf 'tm regression check failed: %s\n' (string join ' ' -- $argv) >&2
    exit 1
end

set -l socket tm-check-$fish_pid
set -l temp_root (mktemp -d)
or fail 'could not create temporary tmux socket directory'
set -g __tm_check_socket $socket
set -g __tm_check_temp_root $temp_root
set -gx TMUX_TMPDIR $temp_root
set -e TMUX
set -e TMUX_PANE
function __tm_check_cleanup --on-event fish_exit
    command tmux -L "$__tm_check_socket" kill-server >/dev/null 2>&1
    command rm -rf "$__tm_check_temp_root"
end

set -l functions_dir "$__fish_config_dir/functions"
set -gx fish_function_path "$functions_dir" $fish_function_path
source "$functions_dir/tm.fish"
command tmux -L "$socket" -f /dev/null new-session -d -s source 'sleep 60'
or fail 'could not start isolated tmux server'
command tmux -L "$socket" set-option -g default-command 'sleep 60'
command tmux -L "$socket" new-session -d -s destination-long 'sleep 60'
or fail 'could not create prefix-collision session'
set -gx TMUX (command tmux -L "$socket" display-message -p '#{socket_path},#{pid},#{session_id}')
set -gx TMUX_PANE (command tmux -L "$socket" list-panes -t '=source' -F '#{pane_id}')
command tmux split-window -h -t "$TMUX_PANE" 'sleep 60'
or fail 'could not create the second pane'

set -l source_window (command tmux display-message -p -t "$TMUX_PANE" '#{window_id}')
set -l original_panes (command tmux list-panes -t "$source_window" -F '#{pane_id}')
set -l prefix_window (command tmux display-message -p -t '=destination-long:' '#{window_id}')

__tm_load
or fail 'module loader failed'
set -g TM_DBG 1
__tm_load
or fail 'module loader failed with global debugging enabled'
test "$TM_DBG" = 1
or fail 'module loader did not restore the global debug master'
set -g TM_DBG 0
set -g TM_DBG_to 1
set -l module_debug (__tm_dbg to module-only 2>&1)
string match -q '*tm/to :: module-only*' -- "$module_debug"
or fail 'module debug did not emit its own output'
set -g TM_DBG_to 0
set -l disabled_debug (__tm_dbg to disabled 2>&1)
test -z "$disabled_debug"
or fail 'disabled module debug emitted output'
set -g TM_DBG 1
set -l global_debug (__tm_dbg detach global 2>&1)
string match -q '*tm/detach :: global*' -- "$global_debug"
or fail 'global debug did not enable another module'
set -g TM_DBG 0

# Moving to the current session must leave the window and every pane untouched.
tm to source >/dev/null 2>&1
test $status -eq 0
or fail 'same-session move was not a no-op'
set -l same_window (command tmux display-message -p -t "$TMUX_PANE" '#{window_id}')
test "$same_window" = "$source_window"
or fail 'same-session move changed the current window'
set -l same_panes (command tmux list-panes -t "$source_window" -F '#{pane_id}')
test (string join ' ' -- $same_panes) = (string join ' ' -- $original_panes)
or fail 'same-session move changed pane identities'

# A missing exact name must create a new session, not match its existing prefix.
tm to destination >/dev/null 2>&1
test $status -eq 0
or fail 'move to a new destination failed'
set -l destination_id (command tmux display-message -p -t '=destination:' '#{session_id}')
set -l destination_windows (command tmux list-windows -t "$destination_id" -F '#{window_id}')
contains -- "$source_window" $destination_windows
or fail 'new destination did not receive the original window'
test (count $destination_windows) -eq 1
or fail 'new destination placeholder was not replaced'
set -l moved_panes (command tmux list-panes -t "$source_window" -F '#{pane_id}')
test (string join ' ' -- $moved_panes) = (string join ' ' -- $original_panes)
or fail 'new-destination move changed pane identities'
set -l prefix_window_after (command tmux display-message -p -t '=destination-long:' '#{window_id}')
test "$prefix_window_after" = "$prefix_window"
or fail 'prefix-collision session was modified'

# Moving to an existing destination preserves its existing window and panes.
tm mw destination-long >/dev/null 2>&1
test $status -eq 0
or fail 'move to an existing destination failed'
set -l existing_id (command tmux display-message -p -t '=destination-long:' '#{session_id}')
set -l existing_windows (command tmux list-windows -t "$existing_id" -F '#{window_id}')
contains -- "$prefix_window" $existing_windows
or fail 'existing destination window was destroyed'
contains -- "$source_window" $existing_windows
or fail 'existing destination did not receive the original window'
set -l before_invalid (command tmux list-sessions -F '#{session_id}')
tm to . >/dev/null 2>&1
test $status -ne 0
or fail 'invalid destination name unexpectedly succeeded'
set -l after_invalid (command tmux list-sessions -F '#{session_id}')
test (string join ' ' -- $before_invalid) = (string join ' ' -- $after_invalid)
or fail 'invalid destination name mutated tmux sessions'

tm ks >/dev/null 2>&1
or fail 'default kill did not select a session that has never been attached'
command tmux has-session -t "$existing_id" 2>/dev/null
and fail 'default kill left the most recent session alive'

printf 'tm regression check passed\n'
