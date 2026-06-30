#!/usr/bin/env fish

function rgif --wraps=rg --description='Search for a regex and output first match line per file'
    set -l text $argv

    # Single rg call with --heading --line-number, process in one streaming pass
    # We only need the FIRST match per file, so track state while streaming
    set -l current_file ""
    set -l first_line 0

    rg --ignore-case --line-number --heading "$text" | while read -l line
        # Empty line = separator between files
        if test -z "$line"
            if test -n "$current_file"
                printf '%s:%d\n' "$current_file" $first_line
            end
            set current_file ""
            set first_line 0
            continue
        end

        # Match line (NN:content) - capture first line number only
        if string match -q -r '^\d+:' "$line"
            if test $first_line -eq 0
                set first_line (string split -m1 ':' "$line")[1]
            end
        else
            # File header - output previous file if exists, start new
            if test -n "$current_file"
                printf '%s:%d\n' "$current_file" $first_line
            end
            set current_file "$line"
            set first_line 0
        end
    end

    # Output last file
    if test -n "$current_file"
        printf '%s:%d\n' "$current_file" $first_line
    end
end
