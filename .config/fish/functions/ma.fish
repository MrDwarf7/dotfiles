#!/usr/bin/env fish
#

function ma_cmp
   complete -c ma -s h -l help                       -d 'Print help information'
   complete -c ma -s V -l version                    -d 'Print version information'
   complete -c ma -s t -l task                       -d 'The task name to execute (can omit the flag if the task name is the last argument) [default: default]'
   complete -c ma -s p -l profile                    -d 'The profile name (will be converted to lower case) [default: development]'
   complete -c ma -s e -l env                        -d 'Set environment variables'
   complete -c ma -s l -l loglevel                   -d 'The log level (verbose, info, error, off) [default: info]'
   complete -c ma -s v -l verbose                    -d 'Sets the log level to verbose (shorthand for --loglevel verbose)'
   complete -c ma      -l makefile                   -d 'The optional toml file containing the tasks definitions'
   complete -c ma      -l completion                 -d 'Will enable completion for the defined tasks for a given shell'
   complete -c ma      -l cwd                        -d 'Will set the current working directory. The search for the makefile will be from this directory if defined.'
   complete -c ma      -l no-workspace               -d 'Disable workspace support (tasks are triggered on workspace and not on members)'
   complete -c ma      -l no-on-error                -d 'Disable on error flow even if defined in config sections'
   complete -c ma      -l allow-private              -d 'Allow invocation of private tasks'
   complete -c ma      -l skip-init-end-tasks        -d 'If set, init and end tasks are skipped'
   complete -c ma      -l skip-tasks                 -d 'Skip all tasks that match the provided regex (example: pre.*|post.*)'
   complete -c ma      -l env-file                   -d 'Set environment variables from provided file'
   complete -c ma      -l quiet                      -d 'Sets the log level to error (shorthand for --loglevel error)'
   complete -c ma      -l silent                     -d 'Sets the log level to off (shorthand for --loglevel off)'
   complete -c ma      -l no-color                   -d 'Disables colorful output'
   complete -c ma      -l time-summary               -d 'Print task level time summary at end of flow'
   complete -c ma      -l experimental               -d 'Allows access unsupported experimental predefined tasks.'
   complete -c ma      -l disable-check-for-updates  -d 'Disables the update check during startup'
   complete -c ma      -l output-format              -d 'The print/list steps format (some operations do not support all formats) (default, short-description, markdown, markdown-single-page, markdown-sub-section, autocomplete)'
   complete -c ma      -l output-file                -d 'The list steps output file name'
   complete -c ma      -l hide-uninteresting         -d 'Hide any minor tasks such as pre/post hooks.'
   complete -c ma      -l print-steps                -d 'Only prints the steps of the build in the order they will be invoked but without invoking them'
   complete -c ma      -l list-all-steps             -d 'Lists all known steps'
   complete -c ma      -l list-category-steps        -d 'List steps for a given category'
   complete -c ma      -l diff-steps                 -d 'Runs diff between custom flow and prebuilt flow (requires git)'
    return 0
end

function ma --wraps=source --description 'Alias for cargo make'
    ma_cmp
    command cargo make $argv
end
