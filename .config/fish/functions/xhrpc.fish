#!/usr/bin/env fish
#

set -g DEFAULT_PATH_PREFIX $HOME/tmp
set -g DEFAULT_FILE_EXT json
set -g default_env stag

set -g XHRPC_DBG 0

function __xhrpc_dbg --argument-names content
    if test "$XHRPC_DBG" != 1
        return 0
    end
    colorize yellow "DEBUG: $content\n"
end

function xhrpc --argument-names env port comp --description "Fetch RPC data from a given environment, port, and component, and save it to a JSON file."
    # set -l loc $HOME/tmp/credits_9001.json; and xh http://stag:9001/rpc/credits | jq -S . > $loc

    set -l deps xh jq

    set -l missing (99-check_dependencies_names true $deps)
    test -n "$missing"; and begin
        colorize red "Error: Missing dependencies. Please install the following packages:\n$__cfg_TAB- $missing\n"; and return 1
    end

    # env: local | legacy | stag | notprod | <Something>
    # port: int
    # comp: string
    test -z "$env"; and set -l env $default_env
    test -z "$port"; or test -z "$comp"; and begin
        colorize red "Error: Missing required arguments: port and comp\n"; and return 1
    end

    # build/derives from env, port, comp
    set -l safe_comp (string replace -a '/' '_' "$comp")
    set --path -l full_output_filename "$env-$port-$safe_comp.$DEFAULT_FILE_EXT"
    set --path -l full_output_path "$DEFAULT_PATH_PREFIX/$full_output_filename"

    __xhrpc_dbg "env: $env"
    __xhrpc_dbg "port: $port"
    __xhrpc_dbg "comp: $comp"
    __xhrpc_dbg "safe_comp: $safe_comp"
    __xhrpc_dbg
    __xhrpc_dbg "DEFAULT_PATH_PREFIX: $DEFAULT_PATH_PREFIX"
    __xhrpc_dbg "DEFAULT_FILE_EXT: $DEFAULT_FILE_EXT"
    __xhrpc_dbg
    __xhrpc_dbg "full_output_filename: $full_output_filename"
    __xhrpc_dbg "full_output_path: $full_output_path"

    command xh "http://$env:$port/rpc/$comp" -F --check-status | jq -S . >$full_output_path
    if test -s $full_output_path
        printf "Success. Output written to:\n"
        colorize green "$full_output_path\n"
    else
        colorize red "Error: Output file is empty or does not exist: $full_output_path\n"; and return 1
    end

    return 0
end
