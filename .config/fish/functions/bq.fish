#!/usr/bin/env fish
#

function __bq_help
    printf 'bq: Query a package.json file using jq

    Usage:
    bq [options] <section> [<key>]

    Options:
    -h, --help     Show this help message and exit

    Sections:
    s, scripts             Query the scripts section of package.json
    d, dep, dependencies   Query the dependencies section
    dd, dev, devDependencies  Query the devDependencies section
    <anything else>        Used as the jq key as-is (e.g. name, version)

    Example:
    bq s build      # Get the build script from package.json\n'
end

function __bq_fallback_chain --argument-names try fallback
    not 00-valid_pacman $try; and not 00-valid_pacman $fallback; and colorize red "Error: Neither '$try' nor '$fallback' commands are available. Please install one of them.\n"; and return 1
    00-valid_pacman $try; and echo $try; and return 0
    00-valid_pacman $fallback; and echo $fallback; and return 0
    return 1
end

function bq --description "Calls bat (or cat) on a 'package.json' file, piping the input arg part to jq"
    argparse h/help -- $argv
    or begin
        colorize red "Error: Invalid arguments. Use 'bq -h' for help.\n"; and return 1
    end

    set -q _flag_help; and __bq_help && return 0

    # we can fallback for bat -> cat,
    # but we cannot fallback for jq
    #
    # bfs -> fd -> find
    # jq -> X
    set -l finder ( __bq_fallback_chain bfs ( __bq_fallback_chain fd find) )
    # fd is recursive + regex by default; pin it to ./package.json like bfs/find
    test "$finder" = fd; and set finder fd -d1 -g

    set -l section $argv[1]

    #### handle each flag variant
    switch "$section"
        case s scripts
            set section .scripts
        case d dep deps dependencies
            set section .dependencies
        case dd dev devDeps devDependencies
            set section .devDependencies
        case ''
            set section .
        case '*'
            set section ".\"$section\""
    end
    set -l processor jq $section
    # optional key within the section, e.g. `bq s test:unit`; --arg avoids jq parsing the key
    set -q argv[2]; and set processor jq --arg k $argv[2] "$section"'[$k]'
    ###############################

    # locate the package.json file
    set -l package_file ($finder package.json)[1]
    test -n "$package_file"; or begin
        colorize red "Error: no package.json found.\n"; and return 1
    end

    # jq output comes back as a list of lines; re-join and pretty-print with a second jq
    set -l data ($processor "$package_file")
    or return 1
    printf '%s\n' $data | jq .

    return 0
end
