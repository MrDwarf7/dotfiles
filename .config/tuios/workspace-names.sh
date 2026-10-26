#!/bin/sh
set -eu

# Input is list-windows followed by list-workspaces. Only rename changed labels.
labels() {
    jq -rs --arg home "$HOME" '
        (.[0].windows | INDEX(.window_id)) as $panes |
        .[1].workspaces[] |
        $panes[.focused_window_id // ""] as $pane |
        select(.window_count > 0 and ($pane.cwd // "") != "") |
        ($pane.cwd | if . == $home then "~" else
            sub("/+$"; "") | split("/") | last // "/"
        end | gsub("[[:cntrl:]]"; " ")) as $label |
        select(.name != $label) | "\(.workspace)\t\($label)"
    '
}

sync_session() {
    panes=$(tuios list-windows -s "$1" --json) || return
    workspaces=$(tuios list-workspaces -s "$1" --json) || return
    updates=$(printf '%s\n%s\n' "$panes" "$workspaces" | labels) || return
    printf '%s\n' "$updates" |
        while IFS="$(printf '\t')" read -r workspace name; do
            [ -n "$workspace" ] || continue
            tuios set-workspace-name -s "$1" -- "$workspace" "$name" >/dev/null || return
        done
}

case "${1:-}" in
    --self-test)
        actual=$(printf '%s\n' '
            {"windows":[
                {"window_id":"first","cwd":"/wrong-pane"},
                {"window_id":"focused","cwd":"/tmp/api folder/"},
                {"window_id":"home","cwd":"/test-home"},
                {"window_id":"root","cwd":"/"},
                {"window_id":"slash","cwd":"/tmp/slash\\dir"}]}
            {"workspaces":[
                {"workspace":1,"name":"old","window_count":2,"focused_window_id":"focused"},
                {"workspace":2,"name":"","window_count":1,"focused_window_id":"home"},
                {"workspace":3,"name":"","window_count":1,"focused_window_id":"root"},
                {"workspace":4,"name":"api folder","window_count":1,"focused_window_id":"focused"},
                {"workspace":5,"name":"","window_count":0},
                {"workspace":6,"name":"","window_count":1,"focused_window_id":"missing"},
                {"workspace":7,"name":"","window_count":1,"focused_window_id":"slash"}]}
        ' | HOME=/test-home labels)
        [ "$actual" = "$(printf '1\tapi folder\n2\t~\n3\t/\n7\tslash\\dir')" ]
        printf 'workspace naming self-check passed\n'
        exit
        ;;
    --once)
        sync_session "${2:?session required}"
        exit
        ;;
esac

# This push component is also the separator after the final workspace tab.
printf '│\n'
# Subscribe before reconciling, so a change during the first read is not lost.
# ponytail: client-owned; use daemon hooks if names must update with no clients.
tuios subscribe --types prompt,command-finished,window-focused,workspace-switched,window-created,window-closed,window-moved,session-created |
    while IFS= read -r event; do
        kind=$(printf '%s\n' "$event" | jq -r '.type')
        case "$kind" in
            subscribed|gap)
                sessions=$(tuios ls --json | jq -r '.[].name')
                printf '%s\n' "$sessions" |
                    while IFS= read -r session; do
                        [ -n "$session" ] || continue
                        sync_session "$session"
                    done
                ;;
            *)
                session=$(printf '%s\n' "$event" | jq -r '.session // empty')
                [ -n "$session" ] || continue
                sync_session "$session"
                ;;
        esac
    done
