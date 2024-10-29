#!/usr/bin/env fish

function colorize_hex -d 'Add background to hex code colors in a command'
    set -l cmd (commandline)
    set -l colorstrings (string match -ra '[0-9A-F]{6}' -- $cmd)
    if test (count $colorstrings) -eq 0
        return
    end
    set -l colorized_cmd (
        string replace -ra '\e\[[^m]*m' '' -- $cmd |
        string replace -ra '[^[:print:]]' ''
    )
    set -l color
    for color in $colorstrings
        set colorized_cmd (string replace $color (printf '%s%s' (set_color -b $color) $color) -- $colorized_cmd)
        #set colorized_cmd (string replace $color (printf '%s%s%s' (set_color normal) $color (set_color normal) '.') -- $colorized_cmd)
    end
    commandline --replace -- $colorized_cmd
    #commandline -f suppress-autosuggestion
    #echo $colorized_cmd
end

# ctrl-k to colorize
bind \ck colorize_hex
