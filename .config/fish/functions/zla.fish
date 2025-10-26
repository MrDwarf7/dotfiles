#!/usr/bin/env fish
#

function zla --description 'zellij attach'
    if not command -q zellij
        printf "Error: zellij is not installed.\n" >&2
        return 1
    end

    set lines (zellij list-sessions -s)
    set temp_lines

    for line in $lines
        if test -z "$line"
            continue
        end

        # Extract the part after the name: [Created ...]
        set parts (string split -m 1 ' [' $line)
        set name (string trim $parts[1])
        set rest $parts[2]

        # Extract the time string between "Created " and " ago"
        set created_part (string split -m 1 ' ago' $rest)[1]
        set time_str (string trim (string sub -s 9 $created_part))

        # Parse the time string into total seconds
        set total_seconds 0
        set time_parts (string split ' ' $time_str)

        for t in $time_parts
            set num (string match -r '\d+' $t)
            set unit (string match -r '[a-z]+' $t)

            switch $unit
                case s second seconds
                    set seconds $num
                case m min mins minute minutes
                    set seconds (math "$num * 60")
                case h hr hrs hour hours
                    set seconds (math "$num * 3600")
                case d day days
                    set seconds (math "$num * 86400")
                case '*'
                    set seconds 0 # Unknown unit, skip
            end

            set total_seconds (math "$total_seconds+$seconds")
        end

        # Collect as "seconds\toriginal_line"
        set -a temp_lines (printf "%s\t%s" $total_seconds $line)
    end

    # Sort numerically ascending (smallest seconds first = most recent first),
    # then extract the original lines
    set sorted_lines (string join \n $temp_lines | sort -n | cut -f 2- | string split \n)

    # If you want just the names, extract them like this:
    # set sessions
    # for l in $sorted_lines
    #     set parts (string split -m 1 ' [' $l)
    #     set -a sessions (string trim $parts[1])
    # end
    # But since the printf uses full lines, using sorted_lines

    # printf "%s\n" $sorted_lines

    # To find the most recently created session (first in sorted)
    if set -q sorted_lines[1]
        set most_recent (string split -m 1 ' [' $sorted_lines[1])[1]
        # Trim any trailing stuff if needed
        set most_recent (string trim $most_recent)
    else
        set most_recent ""
    end

    # Existing logic, but perhaps attach to most recent if no argv
    if test (count $argv) -gt 0
        zellij a $argv
    else if test -n "$most_recent"
        zellij a $most_recent
    else
        # Assuming zln is zellij new or something
        # zln
        zla _main >/dev/null || zln _main
    end
end
