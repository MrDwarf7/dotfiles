#!/usr/bin/env fish

# Helper: output current file with its first match line if we have one
function __rgif_output_current
    set -l file $argv[1]
    set -l line $argv[2]
    if test -n "$file" -a $line -gt 0
        printf '%s:%d\n' "$file" $line
    end
end

# Main function
function rgif --wraps=rg --description='Search for a regex and output first match line per file'
    # argparse will require us to basically re-write the entire func tho....
    # argparse h/help n/limit -- $argv

    set -l limit 0
    set -l pattern_args
    set -l i 1

    while test $i -le (count $argv)
        if test $argv[$i] = -n
            set i (math $i + 1)
            if test $i -le (count $argv)
                set limit $argv[$i]
            else
                echo "Error: -n requires a number argument" >&2
                return 1
            end
        else
            set pattern_args $pattern_args $argv[$i]
        end
        set i (math $i + 1)
    end

    if test (count $pattern_args) -eq 0
        echo "Usage: rgif [-n <limit>] <pattern>" >&2
        return 1
    end

    set -l text $pattern_args

    # Single rg call with --heading --line-number, process in one streaming pass
    # We only need the FIRST match per file, so track state while streaming
    set -l current_file ""
    set -l first_line 0
    set -l output

    # Capture all output first, then apply limit if needed
    set output (rg --ignore-case --line-number --heading "$text" | while read -l line
        # Empty line = separator between files
        if test -z "$line"
            __rgif_output_current "$current_file" $first_line
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
            __rgif_output_current "$current_file" $first_line
            set current_file "$line"
            set first_line 0
        end
    end

    # Output last file
    __rgif_output_current "$current_file" $first_line)

    # Apply limit if requested
    if test $limit -gt 0
        printf '%s\n' $output | head -n $limit
    else
        printf '%s\n' $output
    end
end
