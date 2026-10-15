#!/usr/bin/env fish
#

set -g TM_DBG 0

function __tm_load --description 'Load tm registry and command modules'
    set -l master_dbg $TM_DBG
    set -l dir "$__fish_config_dir/functions/tm"
    if not test -d "$dir"
        colorize red "tm: missing command modules at $dir\n" >&2
        return 1
    end

    # Modules set TM_DBG from their source toggle, so snapshot it and restore the master between sources.
    for file in "$dir"/*.fish
        set -l module (string replace -r '\.fish$' '' -- (path basename "$file"))
        source "$file"
        set -l source_status $status
        set -g "TM_DBG_$module" "$TM_DBG"
        set -g TM_DBG "$master_dbg"
        if test $source_status -ne 0
            return $source_status
        end
    end
end

function tm --description 'Registry-driven tmux wrapper'
    __tm_load
    or return $status

    set -l requested $argv[1]
    if test -z "$requested"
        __tm_dbg dispatch 'default attach'
        __tm_attach
        return $status
    end

    set -l entry (__tm_find_entry "$requested")
    if test -z "$entry"
        __tm_dbg dispatch "default attach $requested"
        __tm_attach $argv
        return $status
    end

    set -l parts (string split '|' -- "$entry")
    set -l handler __tm_$parts[1]
    __tm_dbg dispatch "command $parts[1]"
    $handler $argv[2..-1]
end
